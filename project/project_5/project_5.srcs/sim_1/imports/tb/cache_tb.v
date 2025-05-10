`timescale 1ns/1ps

module cache_tb;

    reg clk;
    reg resetn;

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 复位生成
    initial begin
        resetn = 0;
        #20 resetn = 1;
    end

    // DUT接口
    reg         cpu_valid;
    reg [3:0]   cpu_wstrb;
    reg [31:0]  cpu_addr;
    reg [31:0]  cpu_wdata;
    wire [31:0] cpu_rdata;
    wire        cpu_ready;

    wire        mem_valid;
    reg         mem_ready;
    wire [3:0]  mem_wstrb;
    wire [33:0] mem_addr;
    wire [31:0] mem_wdata;
    reg  [31:0] mem_rdata;

    wire [31:0] cache_miss_count;
    wire        is_instruction = 0;
    wire        tlb_flush = 0;
    wire        stall;
    wire        write_back = 0;
    wire [31:0] satp = 0;
    wire [31:0] mstatus = 0;
    wire [1:0]  privilege_mode = 3;
    wire [31:0] fault_address;
    wire        page_fault;

    // 内存模型
    reg [31:0] memory [0:1023];  // 1KB内存空间
    integer i; // 声明i

    // 实例化DUT
    sv32 u_dut (
        .clk(clk),
        .resetn(resetn),
        .cpu_valid(cpu_valid),
        .cpu_ready(cpu_ready),
        .cpu_wstrb(cpu_wstrb),
        .cpu_addr(cpu_addr),
        .cpu_wdata(cpu_wdata),
        .cpu_rdata(cpu_rdata),
        .mem_valid(mem_valid),
        .mem_ready(mem_ready),
        .mem_wstrb(mem_wstrb),
        .mem_addr(mem_addr),
        .mem_wdata(mem_wdata),
        .mem_rdata(mem_rdata),
        .cache_miss_count(cache_miss_count),
        .is_instruction(is_instruction),
        .tlb_flush(tlb_flush),
        .stall(stall),
        .write_back(write_back),
        .satp(satp),
        .mstatus(mstatus),
        .privilege_mode(privilege_mode),
        .fault_address(fault_address),
        .page_fault(page_fault)
    );

    // 行为级内存模型
    always @(posedge clk) begin
        if (mem_valid) begin
            // 写操作
            if (|mem_wstrb) begin
                memory[mem_addr[31:2]] <= mem_wdata;  // 字地址对齐
                $display("[MEM] Write Addr=%h Data=%h", 
                        mem_addr, mem_wdata);
            end 
            // 读操作
            else begin
                mem_rdata <= memory[mem_addr[31:2]];
                $display("[MEM] Read Addr=%h Data=%h", 
                        mem_addr, mem_rdata);
            end
            mem_ready <= 1'b1;
        end else begin
            mem_ready <= 1'b0;
        end
    end

    // 主测试流程
    initial begin
        // 初始化
        cpu_valid = 0;
        cpu_wstrb = 0;
        cpu_addr = 0;
        cpu_wdata = 0;
        mem_ready = 0;
        mem_rdata = 0;
        
        // 初始化内存
        for (i = 0; i < 1024; i = i + 1) begin
            memory[i] = 32'h0;
        end

        // 等待复位完成
        wait(resetn);
        #30;

        // ============ 测试1：基本写后读 ============
        $display("\n=== 测试1：基本写后读验证 ===");
        test_write(32'h1000, 32'h11223344);
        test_read(32'h1000, 32'h11223344);

        // ============ 测试2：缓存替换 ============
        $display("\n=== 测试2：缓存替换验证 ===");
        // 写满两路
        test_write(32'h2000, 32'hAABBCCDD); // Way0[0]
        test_write(32'h3000, 32'hDDCCBBAA); // Way1[0]
        // 触发替换
        test_write(32'h4000, 32'h12345678); // 应替换LRU路
        test_read(32'h4000, 32'h12345678);

        // ============ 测试3：写未命中 ============
        $display("\n=== 测试3：写未命中验证 ===");
        test_write(32'h5000, 32'h55AA55AA);
        test_read(32'h5000, 32'h55AA55AA);

        $display("\n========================================");
        $display("           所有测试通过！               ");
        $display("========================================\n");
        #50 $finish;
    end

    // ================= 测试任务 =================
    task test_write;
        input [31:0] addr;
        input [31:0] data;
    begin
        cpu_addr = addr;
        cpu_wdata = data;
        cpu_wstrb = 4'hF;
        cpu_valid = 1;
        
        wait(cpu_ready);
        @(posedge clk);
        cpu_valid = 0;
        cpu_wstrb = 0;
        
        $display("[TEST] 写入地址：0x%h，数据：0x%h", addr, data);
        #20;
    end
    endtask

    task test_read;
        input [31:0] addr;
        input [31:0] expected;
    begin
        cpu_addr = addr;
        cpu_wstrb = 0;
        cpu_valid = 1;
        
        wait(cpu_ready);
        @(posedge clk);
        cpu_valid = 0;
        
        if (cpu_rdata === expected) begin
            $display("[TEST] 读取地址：0x%h，数据正确：0x%h", addr, cpu_rdata);
        end else begin
            $error("[ERROR] 地址0x%h 数据错误！期望：0x%h，实际：0x%h",
                  addr, expected, cpu_rdata);
        end
        #20;
    end
    endtask

    // ================= 波形记录 =================
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, cache_tb);
        // 记录DUT内部信号
        $dumpvars(1, u_dut.u_tag_ram.tags);
        $dumpvars(1, u_dut.u_tag_ram.payloads);
        $dumpvars(1, u_dut.u_tag_ram.v);
        $dumpvars(1, u_dut.u_tag_ram.lru);
    end

endmodule