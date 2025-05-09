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
    // 内存数据动态生成（同步版本）
reg [31:0] stored_data [0:1023]; // 模拟内存存储

always @(posedge clk) begin
    if (mem_valid && mem_ready) begin
        if (mem_wstrb != 0) begin
            // 写入操作：存储用户数据到内存
            stored_data[mem_addr[31:6]] <= mem_wdata;
        end
    end
end

always @(*) begin
    if (mem_valid && mem_ready) begin
        if (mem_wstrb != 0) begin
            // 写入操作返回用户数据
            mem_rdata = mem_wdata;
        end else begin
            // 读取操作返回存储的数据
            mem_rdata = stored_data[mem_addr[31:6]];
        end
    end else begin
        mem_rdata = 32'h0;
    end
end

    // 实例化被测模块
    sv32 u_sv32 (
        .clk(clk),
        .resetn(resetn),
        .cpu_valid(cpu_valid),
        .cpu_ready(),          // 未连接（由内部逻辑处理）
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
        .is_instruction(1'b0), // 仅测试数据缓存
        .tlb_flush(1'b0),
        .stall(),
        .write_back(1'b0),
        .satp(32'h0),          // 禁用分页
        .mstatus(32'h0),
        .privilege_mode(2'b11),
        .fault_address(),
        .page_fault()
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 主测试流程
    initial begin
        // 初始化
        resetn = 0;
        cpu_valid = 0;
        cpu_wstrb = 0;
        cpu_addr = 0;
        cpu_wdata = 0;
        mem_ready = 1;          // 内存始终就绪
        mem_rdata = 32'h0;      // 内存返回数据初始化为0
        #20;
        resetn = 1;

        // ===================================
        // 测试阶段1：基本读写验证（同一索引不同标签）
        // ===================================
        $display("\n--- 阶段1：基本读写验证 ---");
        
        // 写入地址 0x100（索引=4, 标签=0x04）
        write_data(32'h100, 32'ha5a5a5a5);
        // 读取地址 0x100，应命中
        read_data(32'h100, 32'ha5a5a5a5);

        // 写入地址 0x200（索引=8, 标签=0x08）
        write_data(32'h200, 32'h11111111);
        // 读取地址 0x200，应命中
        read_data(32'h200, 32'h11111111);

        // 写入地址 0x400（索引=16, 标签=0x10）
        write_data(32'h400, 32'h33333333);
        // 读取地址 0x400，应命中
        read_data(32'h400, 32'h33333333);

        // 验证缺失次数（预期3次）
        $display("[阶段1] 缺失次数 = %d (预期3)", cache_miss_count);

        // ===================================
        // 测试阶段2：LRU替换策略验证
        // ===================================
        $display("\n--- 阶段2：LRU替换验证 ---");
        
        // 访问地址 0x500（索引=20, 标签=0x14）-> 缺失
        read_data(32'h500, 32'h0);
        // 访问地址 0x600（索引=24, 标签=0x18）-> 缺失
        read_data(32'h600, 32'h0);
        // 再次访问 0x100（索引=4）-> 应命中，LRU不更新
        read_data(32'h100, 32'ha5a5a5a5);
        // 访问地址 0x700（索引=28, 标签=0x1C）-> 缺失（替换LRU路）
        read_data(32'h700, 32'h0);
        // 验证缺失次数（3 + 3 = 6）
        $display("[阶段2] 缺失次数 = %d (预期6)", cache_miss_count);

        // ===================================
        // 测试阶段3：跨组冲突验证
        // ===================================
        $display("\n--- 阶段3：跨组冲突验证 ---");
        
        // 访问地址 0x800（索引=32, 标签=0x20）-> 缺失
        read_data(32'h800, 32'h0);
        // 访问地址 0x900（索引=36, 标签=0x24）-> 缺失
        read_data(32'h900, 32'h0);
        // 再次访问 0x100（索引=4）-> 应命中
        read_data(32'h100, 32'ha5a5a5a5);
        // 验证缺失次数（6 + 2 = 8）
        $display("[阶段3] 缺失次数 = %d (预期8)", cache_miss_count);

        // ===================================
        // 测试结束
        // ===================================
        #100;
        $display("\n--- 测试完成 ---");
        $finish;
    end

    // 写入任务
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

    // 读取任务（带预期值检查）
    task read_data(input [31:0] addr, input [31:0] expected);
        begin
            @(negedge clk);
            cpu_valid = 1;
            cpu_wstrb = 4'h0;  // 读操作
            cpu_addr = addr;
            @(negedge clk);
            cpu_valid = 0;
            #20; // 等待结果稳定
            if (cpu_rdata !== expected) begin
                $error("[错误] 地址=0x%h 预期=0x%h 实际=0x%h", addr, expected, cpu_rdata);
            end else begin
                $display("[读取] 地址=0x%h 数据=0x%h 正确", addr, cpu_rdata);
            end
        end
    endtask

endmodule 