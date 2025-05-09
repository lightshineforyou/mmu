`timescale 1ns / 1ps

module cache_tb;

    // ʱ�Ӻ͸�λ�ź�
    reg clk;
    reg resetn;

    // CPU�ӿ��ź�
    reg        cpu_valid;
    reg [3:0]  cpu_wstrb;
    reg [31:0] cpu_addr;
    reg [31:0] cpu_wdata;
    wire [31:0] cpu_rdata;
    wire [31:0] cache_miss_count;

    // �ڴ�ӿ��ź�
    wire        mem_valid;
    wire [3:0]  mem_wstrb;
    wire [33:0] mem_addr;
    wire [31:0] mem_wdata;
    reg  [31:0] mem_rdata;
    reg         mem_ready;
    // �ڴ����ݶ�̬���ɣ�ͬ���汾��
reg [31:0] stored_data [0:1023]; // ģ���ڴ�洢

always @(posedge clk) begin
    if (mem_valid && mem_ready) begin
        if (mem_wstrb != 0) begin
            // д��������洢�û����ݵ��ڴ�
            stored_data[mem_addr[31:6]] <= mem_wdata;
        end
    end
end

always @(*) begin
    if (mem_valid && mem_ready) begin
        if (mem_wstrb != 0) begin
            // д����������û�����
            mem_rdata = mem_wdata;
        end else begin
            // ��ȡ�������ش洢������
            mem_rdata = stored_data[mem_addr[31:6]];
        end
    end else begin
        mem_rdata = 32'h0;
    end
end

    // ʵ��������ģ��
    sv32 u_sv32 (
        .clk(clk),
        .resetn(resetn),
        .cpu_valid(cpu_valid),
        .cpu_ready(),          // δ���ӣ����ڲ��߼�����
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
        .is_instruction(1'b0), // ���������ݻ���
        .tlb_flush(1'b0),
        .stall(),
        .write_back(1'b0),
        .satp(32'h0),          // ���÷�ҳ
        .mstatus(32'h0),
        .privilege_mode(2'b11),
        .fault_address(),
        .page_fault()
    );

    // ʱ������
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ����������
    initial begin
        // ��ʼ��
        resetn = 0;
        cpu_valid = 0;
        cpu_wstrb = 0;
        cpu_addr = 0;
        cpu_wdata = 0;
        mem_ready = 1;          // �ڴ�ʼ�վ���
        mem_rdata = 32'h0;      // �ڴ淵�����ݳ�ʼ��Ϊ0
        #20;
        resetn = 1;

        // ===================================
        // ���Խ׶�1��������д��֤��ͬһ������ͬ��ǩ��
        // ===================================
        $display("\n--- �׶�1��������д��֤ ---");
        
        // д���ַ 0x100������=4, ��ǩ=0x04��
        write_data(32'h100, 32'ha5a5a5a5);
        // ��ȡ��ַ 0x100��Ӧ����
        read_data(32'h100, 32'ha5a5a5a5);

        // д���ַ 0x200������=8, ��ǩ=0x08��
        write_data(32'h200, 32'h11111111);
        // ��ȡ��ַ 0x200��Ӧ����
        read_data(32'h200, 32'h11111111);

        // д���ַ 0x400������=16, ��ǩ=0x10��
        write_data(32'h400, 32'h33333333);
        // ��ȡ��ַ 0x400��Ӧ����
        read_data(32'h400, 32'h33333333);

        // ��֤ȱʧ������Ԥ��3�Σ�
        $display("[�׶�1] ȱʧ���� = %d (Ԥ��3)", cache_miss_count);

        // ===================================
        // ���Խ׶�2��LRU�滻������֤
        // ===================================
        $display("\n--- �׶�2��LRU�滻��֤ ---");
        
        // ���ʵ�ַ 0x500������=20, ��ǩ=0x14��-> ȱʧ
        read_data(32'h500, 32'h0);
        // ���ʵ�ַ 0x600������=24, ��ǩ=0x18��-> ȱʧ
        read_data(32'h600, 32'h0);
        // �ٴη��� 0x100������=4��-> Ӧ���У�LRU������
        read_data(32'h100, 32'ha5a5a5a5);
        // ���ʵ�ַ 0x700������=28, ��ǩ=0x1C��-> ȱʧ���滻LRU·��
        read_data(32'h700, 32'h0);
        // ��֤ȱʧ������3 + 3 = 6��
        $display("[�׶�2] ȱʧ���� = %d (Ԥ��6)", cache_miss_count);

        // ===================================
        // ���Խ׶�3�������ͻ��֤
        // ===================================
        $display("\n--- �׶�3�������ͻ��֤ ---");
        
        // ���ʵ�ַ 0x800������=32, ��ǩ=0x20��-> ȱʧ
        read_data(32'h800, 32'h0);
        // ���ʵ�ַ 0x900������=36, ��ǩ=0x24��-> ȱʧ
        read_data(32'h900, 32'h0);
        // �ٴη��� 0x100������=4��-> Ӧ����
        read_data(32'h100, 32'ha5a5a5a5);
        // ��֤ȱʧ������6 + 2 = 8��
        $display("[�׶�3] ȱʧ���� = %d (Ԥ��8)", cache_miss_count);

        // ===================================
        // ���Խ���
        // ===================================
        #100;
        $display("\n--- ������� ---");
        $finish;
    end

    // д������
    task write_data(input [31:0] addr, input [31:0] data);
        begin
            @(negedge clk);
            cpu_valid = 1;
            cpu_wstrb = 4'hF;  // ȫ�ֽ�д��
            cpu_addr = addr;
            cpu_wdata = data;
            @(negedge clk);
            cpu_valid = 0;
            cpu_wstrb = 0;
            #10;
            $display("[д��] ��ַ=0x%h ����=0x%h", addr, data);
        end
    endtask

    // ��ȡ���񣨴�Ԥ��ֵ��飩
    task read_data(input [31:0] addr, input [31:0] expected);
        begin
            @(negedge clk);
            cpu_valid = 1;
            cpu_wstrb = 4'h0;  // ������
            cpu_addr = addr;
            @(negedge clk);
            cpu_valid = 0;
            #20; // �ȴ�����ȶ�
            if (cpu_rdata !== expected) begin
                $error("[����] ��ַ=0x%h Ԥ��=0x%h ʵ��=0x%h", addr, expected, cpu_rdata);
            end else begin
                $display("[��ȡ] ��ַ=0x%h ����=0x%h ��ȷ", addr, cpu_rdata);
            end
        end
    endtask

endmodule 