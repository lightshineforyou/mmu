`timescale 1ns / 1ps
`include "riscv_priv_csr_status.vh"

module sv32_test_new;
// 时钟和复位信号
reg clk;
reg resetn;

// CPU接口信号
reg         cpu_valid;
wire        cpu_ready;
reg  [3:0]  cpu_wstrb;
reg  [31:0] cpu_addr;
reg  [31:0] cpu_wdata;
wire [31:0] cpu_rdata;

// 内存接口信号
wire        mem_valid;
reg         mem_ready;
wire [3:0]  mem_wstrb;
wire [33:0] mem_addr;
wire [31:0] mem_wdata;
wire [31:0] mem_rdata;

// 控制信号
reg         is_instruction;
reg         tlb_flush;
wire        stall;
reg  [31:0] satp;
reg  [31:0] mstatus;
reg  [1:0]  privilege_mode;
wire [31:0] fault_address;
wire        page_fault;
wire  [31:0] tlb_miss_count;
// 例化TLB模块
// 例化被测试的MMU模块
sv32 u_sv32 (
    .clk            (clk),
    .resetn         (resetn),
    .cpu_valid      (cpu_valid),
    .cpu_ready      (cpu_ready),
    .cpu_wstrb      (cpu_wstrb),
    .cpu_addr       (cpu_addr),
    .cpu_wdata      (cpu_wdata),
    .cpu_rdata      (cpu_rdata),
    .mem_valid      (mem_valid),
    .mem_ready      (mem_ready),
    .mem_wstrb      (mem_wstrb),
    .mem_addr       (mem_addr),
    .mem_wdata      (mem_wdata),
    .mem_rdata      (mem_rdata),
    .is_instruction (is_instruction),
    .tlb_flush      (tlb_flush),
    .stall          (stall),
    .satp           (satp),
    .mstatus        (mstatus),
    .privilege_mode (privilege_mode),
    .fault_address  (fault_address),
    .page_fault     (page_fault),
    .tlb_miss_count (tlb_miss_count)
);

// 内存模块
blk_mem_gen_0 ram (
    .clka(clk),
    .addra(mem_addr[17:0]),
    .dina(mem_wdata),
    .douta(mem_rdata),
    .wea(mem_wstrb)
);

// 时钟生成
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// 内存响应逻辑
always @(posedge clk) begin
    if(mem_valid == 1'b1) begin
        mem_ready <= 1'b1;
    end else begin
        mem_ready <= 1'b0;
    end
end

// 写事务任务
task write_transaction;
    input [31:0] addr;
    input [31:0] wdata;
    input [3:0]  wstrb;
    begin
        @(negedge clk);
        cpu_valid = 1'b1;
        cpu_addr  = addr;
        cpu_wdata = wdata;
        cpu_wstrb = wstrb;
        @(posedge clk);
        while (!cpu_ready) @(posedge clk);
        cpu_valid = 1'b0;
        #10;
        $display("[WRITE] Addr=0x%h, Data=0x%h", addr, wdata);
    end
endtask

// 读事务任务
task read_transaction;
    input [31:0] addr;
    input [31:0] expected;
    begin
        @(negedge clk);
        cpu_valid = 1'b1;
        cpu_addr  = addr;
        cpu_wstrb = 4'b0000;
        @(posedge clk);
        while (!cpu_ready && !page_fault) @(posedge clk);
        cpu_valid = 1'b0;
        if (page_fault)
            $display("[FAULT] Page fault detected at addr=0x%h", fault_address);
        #10;
        $display("[READ] Addr=0x%h, Got=0x%h, Expected=0x%h", 
                 addr, cpu_rdata, expected);
        if (!page_fault && cpu_rdata !== expected)
            $display("[ERROR] Data mismatch!");
    end
endtask
 
// 测试主程序
initial begin
    // 初始化信号
    resetn         = 0;
    cpu_valid      = 0;
    cpu_wstrb      = 0;
    cpu_addr       = 0;
    cpu_wdata      = 0;
    mem_ready      = 0;
    is_instruction = 0;
    tlb_flush      = 0;
    satp           = 0;
    mstatus        = 0;
    privilege_mode = `PRIVILEGE_MODE_MACHINE;
    // for (int i = 0; i < 1024; i = i + 1) begin //
    //     ram.memory[i] = 32'h00000000; // 假设内存模块有一个 memory 数组
    // end
    // 复位释放
   
    #20 resetn = 1;
    #10;

    // 测试1：写回和写直达机制
    $display("\n=== Test 1: Write-Back and Write-Through ===");
    write_transaction(32'h0001_0000, 32'hAAAA_BBBB, 4'b1111); // 写直达
    write_transaction(32'h0002_0000, 32'hCCCC_DDDD, 4'b1111); // 写回

    // 测试2：TLB 缺失计数器
    $display("\n=== Test 2: TLB Miss Counter ===");
    tlb_flush = 1; // 清空 TLB
    #10;
    tlb_flush = 0;
    read_transaction(32'h0003_0000, 32'h0000_0000); // 触发 TLB 缺失
    read_transaction(32'h0004_0000, 32'h0000_0000); // 再次触发 TLB 缺失
    if (u_sv32.tlb_miss_count !== 2) begin
        $display("[ERROR] TLB Miss Count mismatch! Expected=2, Got=%d", u_sv32.tlb_miss_count);
    end else begin
        $display("[PASS] TLB Miss Count is correct.");
    end
    // 测试3：两路组相联映射
    $display("\n=== Test 3: Two-Way Set Associative TLB ===");
    write_transaction(32'h0005_0000, 32'h1234_5678, 4'b1111); // 写入第1路
    write_transaction(32'h0006_0000, 32'h8765_4321, 4'b1111); // 写入第2路
    write_transaction(32'h0007_0000, 32'hDEAD_BEEF, 4'b1111); // 替换第1路


 // 添加测试 BRAM 完整地址空间的代码
    $display("\n=== Test 4: Full BRAM Address Space ===");
    for (int i = 0; i < 256 * 1024; i = i + 4) begin
        write_transaction(i, 32'hDEADBEEF, 4'b1111);
        read_transaction(i, 32'hDEADBEEF);
    end
    // 完成测试
    #100;
    $display("\n=== All tests completed ===");
    $finish;
end

// 监视关键信号
initial begin
    $monitor("Time=%0t resetn=%b mode=%b satp=%h addr=%h data=%h fault=%b Time=%0t TLB Miss Count=%d",
             $time, resetn, privilege_mode, satp, cpu_addr, 
             cpu_rdata, page_fault,$time, tlb_miss_count);
end

endmodule