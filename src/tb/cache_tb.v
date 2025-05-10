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

    // 新增统计相关变量
    integer total_misses = 0;
    integer current_test_misses = 0;
    integer test_case_num = 1;
    integer expected_misses[1:3];  // 存储各测试用例预期未命中数

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

        // 设置预期未命中数
        expected_misses[1] = 2;  // Test1: 写未命中+读未命中
        expected_misses[2] = 3;  // Test2: 写Way0+写Way1+替换写
        expected_misses[3] = 1;  // Test3: 写未命中

        // ============ 测试1：基本写后读 ============
        $display("\n=== 测试1：基本写后读验证 ===");
        begin_test_case();
        test_write(32'h1000, 32'h11223344);
        test_read(32'h1000, 32'h11223344);
        end_test_case(1);

        // ============ 测试2：缓存替换 ============
        $display("\n=== 测试2：缓存替换验证 ===");
        begin_test_case();
        test_write(32'h2000, 32'hAABBCCDD); // Way0[0]
        test_write(32'h3000, 32'hDDCCBBAA); // Way1[0]
        test_write(32'h4000, 32'h12345678); // 应替换LRU路
        test_read(32'h4000, 32'h12345678);
        end_test_case(2);

        // ============ 测试3：写未命中 ============
        $display("\n=== 测试3：写未命中验证 ===");
        begin_test_case();
        test_write(32'h5000, 32'h55AA55AA);
        test_read(32'h5000, 32'h55AA55AA);
        end_test_case(3);

        // 显示最终统计
        $display("\n============ 缓存性能统计 ============");
        $display("| 测试用例 | 预期未命中 | 实际未命中 | 状态 |");
        $display("|----------|------------|------------|------|");
        $display("|   Test1  |     %2d     |     %2d     | %s |",
                expected_misses[1], 
                get_miss_count(1),
                (get_miss_count(1)==expected_misses[1]) ? "通过" : "失败");
        $display("|   Test2  |     %2d     |     %2d     | %s |",
                expected_misses[2], 
                get_miss_count(2),
                (get_miss_count(2)==expected_misses[2]) ? "通过" : "失败");
        $display("|   Test3  |     %2d     |     %2d     | %s |",
                expected_misses[3], 
                get_miss_count(3),
                (get_miss_count(3)==expected_misses[3]) ? "通过" : "失败");
        $display("----------------------------------------");
        $display("|  总计    |     %2d     |     %2d     |      |",
                expected_misses[1]+expected_misses[2]+expected_misses[3],
                total_misses);
        $display("========================================");

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

    // ================= 新增统计任务 =================
    task begin_test_case;
    begin
        current_test_misses = u_dut.cache_miss_count;
        $display("[STAT] 开始测试用例 %0d，当前未命中数：%0d", 
                test_case_num, current_test_misses);
    end
    endtask

    task end_test_case;
        input integer tc_num;
        integer actual_misses;
    begin
        actual_misses = u_dut.cache_miss_count - current_test_misses;
        total_misses += actual_misses;
        $display("[STAT] 测试用例 %0d 结果：", tc_num);
        $display("   预期未命中：%0d", expected_misses[tc_num]);
        $display("   实际未命中：%0d", actual_misses);
        $display("   内存访问次数：%0d", actual_misses);
        test_case_num += 1;
        #20;
    end
    endtask

    function integer get_miss_count;
        input integer tc;
    begin
        case(tc)
            1: get_miss_count = expected_misses[1];
            2: get_miss_count = expected_misses[2];
            3: get_miss_count = expected_misses[3];
            default: get_miss_count = 0;
        endcase
    end
    endfunction

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