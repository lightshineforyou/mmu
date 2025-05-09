`timescale 1ns / 1ps

module cache_tb;

    // 时钟和复位信号
    reg clk;
    reg resetn;

    // CPU接口信号
    reg        cpu_valid;
    reg [3:0]  cpu_wstrb;
    reg [31:0] cpu_addr;
    reg [31:0] cpu_wdata;
    wire [31:0] cpu_rdata;
    wire [31:0] cache_miss_count;

    // 内存接口信号
    wire        mem_valid;
    wire [3:0]  mem_wstrb;
    wire [33:0] mem_addr;
    wire [31:0] mem_wdata;
    reg  [31:0] mem_rdata;
    reg         mem_ready;

    // 实例化被测模块
    sv32 u_sv32 (
        .clk(clk),
        .resetn(resetn),
        .cpu_valid(cpu_valid),
        .cpu_ready(),          // 由内部逻辑处理
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
        .is_instruction(1'b0), // 测试数据缓存
        .tlb_flush(1'b0),
        .stall(),
        .write_back(1'b0),
        .satp(32'h0),          // 禁用分页
        .mstatus(32'h0),
        .privilege_mode(2'b11),
        .fault_address(),
        .page_fault()
    );

    // 时钟生成（周期10ns）
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 主测试流程
    initial begin
        // 初始化信号
        resetn = 0;
        cpu_valid = 0;
        cpu_wstrb = 0;
        cpu_addr = 0;
        cpu_wdata = 0;
        mem_ready = 1;          // 内存默认就绪
        mem_rdata = 32'h0;      // 初始内存数据为0
        #20;
        resetn = 1;

        // ===================================
        // 测试阶段1：验证用户数据写入与缓存命中
        // ===================================
        $display("\n--- 阶段1：用户数据验证 ---");
        
        // 写入地址 0x100（用户数据 0xa5a5a5a5）
        write_data(32'h100, 32'ha5a5a5a5);
        // 读取地址 0x100，应命中（预期用户数据）
        read_data(32'h100, 32'ha5a5a5a5);

        // 写入地址 0x200（用户数据 0x11111111）
        write_data(32'h200, 32'h11111111);
        // 读取地址 0x200，应命中（预期用户数据）
        read_data(32'h200, 32'h11111111);

        // 写入地址 0x400（用户数据 0x33333333）
        write_data(32'h400, 32'h33333333);
        // 读取地址 0x400，应命中（预期用户数据）
        read_data(32'h400, 32'h33333333);

        // 验证缺失次数（预期3次：三次写入未命中）
        $display("[阶段1] 缺失次数 = %d (预期3)", cache_miss_count);

        // ===================================
        // 测试阶段2：混合读写与LRU替换验证
        // ===================================
        $display("\n--- 阶段2：混合读写验证 ---");
        
        // 读取未写入地址 0x500（预期内存数据 0x00000500）
        read_data(32'h500, 32'h00000500);
        // 再次读取 0x500（应命中，预期内存数据）
        read_data(32'h500, 32'h00000500);

        // 写入新地址 0x600（用户数据 0x66666666）
        write_data(32'h600, 32'h66666666);
        // 读取地址 0x600，应命中（预期用户数据）
        read_data(32'h600, 32'h66666666);

        // 验证缺失次数（3 + 1 = 4）
        $display("[阶段2] 缺失次数 = %d (预期4)", cache_miss_count);

        // ===================================
        // 测试阶段3：LRU替换与跨组冲突
        // ===================================
        $display("\n--- 阶段3：LRU替换验证 ---");
        
        // 写入地址 0x700（用户数据 0x77777777）
        write_data(32'h700, 32'h77777777);
        // 写入地址 0x800（用户数据 0x88888888）
        write_data(32'h800, 32'h88888888);
        // 写入地址 0x900（用户数据 0x99999999）
        write_data(32'h900, 32'h99999999);

        // 读取历史地址 0x100（应命中，预期用户数据）
        read_data(32'h100, 32'ha5a5a5a5);
        // 读取历史地址 0x700（应命中，预期用户数据）
        read_data(32'h700, 32'h77777777);

        // 验证缺失次数（4 + 3 = 7）
        $display("[阶段3] 缺失次数 = %d (预期7)", cache_miss_count);

        // ===================================
        // 测试结束
        // ===================================
        #100;
        $display("\n--- 测试完成 ---");
        $finish;
    end

    // 内存数据动态生成（关键修改点）
    // --------------------------------
    // 写入操作：返回用户写入数据（验证缓存加载）
    // 读取操作：返回地址对齐值（验证缓存未命中行为）
    always @(*) begin
        if (mem_wstrb != 0) begin
            // 写入操作时，内存返回用户写入的数据
            mem_rdata = cpu_wdata;
        end else begin
            // 读取操作时，内存返回地址对齐值（高26位）
            mem_rdata = {mem_addr[31:6], 6'b0};
        end
    end

    // 写入任务（模拟用户数据写入）
    task write_data(input [31:0] addr, input [31:0] data);
        begin
            @(negedge clk);
            cpu_valid = 1;
            cpu_wstrb = 4'hF;  // 全字节写入
            cpu_addr = addr;
            cpu_wdata = data;
            @(negedge clk);
            cpu_valid = 0;
            cpu_wstrb = 0;
            #10;
            $display("[写入] 地址=0x%h 数据=0x%h", addr, data);
        end
    endtask

    // 读取任务（严格校验预期值）
    task read_data(input [31:0] addr, input [31:0] expected);
        begin
            @(negedge clk);
            cpu_valid = 1;
            cpu_wstrb = 4'h0;  // 读操作
            cpu_addr = addr;
            @(negedge clk);
            cpu_valid = 0;
            #20; // 等待缓存和内存响应
            if (cpu_rdata !== expected) begin
                $error("[错误] 地址=0x%h 预期=0x%h 实际=0x%h", addr, expected, cpu_rdata);
            end else begin
                $display("[读取] 地址=0x%h 数据=0x%h 正确", addr, cpu_rdata);
            end
        end
    endtask

endmodule