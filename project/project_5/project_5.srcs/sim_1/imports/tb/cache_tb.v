`timescale 1ns/1ps

module cache_tb;

    reg clk;
    reg resetn;

    // ʱ������
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ��λ����
    initial begin
        resetn = 0;
        #20 resetn = 1;
    end

    // DUT�ӿ�
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

    // �ڴ�ģ��
    reg [31:0] memory [0:1023];  // 1KB�ڴ�ռ�
    integer i; // ����i

    // ʵ����DUT
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

    // ��Ϊ���ڴ�ģ��
    always @(posedge clk) begin
        if (mem_valid) begin
            // д����
            if (|mem_wstrb) begin
                memory[mem_addr[31:2]] <= mem_wdata;  // �ֵ�ַ����
                $display("[MEM] Write Addr=%h Data=%h", 
                        mem_addr, mem_wdata);
            end 
            // ������
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

    // ����������
    initial begin
        // ��ʼ��
        cpu_valid = 0;
        cpu_wstrb = 0;
        cpu_addr = 0;
        cpu_wdata = 0;
        mem_ready = 0;
        mem_rdata = 0;
        
        // ��ʼ���ڴ�
        for (i = 0; i < 1024; i = i + 1) begin
            memory[i] = 32'h0;
        end

        // �ȴ���λ���
        wait(resetn);
        #30;

        // ============ ����1������д��� ============
        $display("\n=== ����1������д�����֤ ===");
        test_write(32'h1000, 32'h11223344);
        test_read(32'h1000, 32'h11223344);

        // ============ ����2�������滻 ============
        $display("\n=== ����2�������滻��֤ ===");
        // д����·
        test_write(32'h2000, 32'hAABBCCDD); // Way0[0]
        test_write(32'h3000, 32'hDDCCBBAA); // Way1[0]
        // �����滻
        test_write(32'h4000, 32'h12345678); // Ӧ�滻LRU·
        test_read(32'h4000, 32'h12345678);

        // ============ ����3��дδ���� ============
        $display("\n=== ����3��дδ������֤ ===");
        test_write(32'h5000, 32'h55AA55AA);
        test_read(32'h5000, 32'h55AA55AA);

        $display("\n========================================");
        $display("           ���в���ͨ����               ");
        $display("========================================\n");
        #50 $finish;
    end

    // ================= �������� =================
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
        
        $display("[TEST] д���ַ��0x%h�����ݣ�0x%h", addr, data);
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
            $display("[TEST] ��ȡ��ַ��0x%h��������ȷ��0x%h", addr, cpu_rdata);
        end else begin
            $error("[ERROR] ��ַ0x%h ���ݴ���������0x%h��ʵ�ʣ�0x%h",
                  addr, expected, cpu_rdata);
        end
        #20;
    end
    endtask

    // ================= ���μ�¼ =================
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, cache_tb);
        // ��¼DUT�ڲ��ź�
        $dumpvars(1, u_dut.u_tag_ram.tags);
        $dumpvars(1, u_dut.u_tag_ram.payloads);
        $dumpvars(1, u_dut.u_tag_ram.v);
        $dumpvars(1, u_dut.u_tag_ram.lru);
    end

endmodule