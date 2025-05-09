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

    // ʵ��������ģ��
    sv32 u_sv32 (
        .clk(clk),
        .resetn(resetn),
        .cpu_valid(cpu_valid),
        .cpu_ready(),          // ���ڲ��߼�����
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
        .is_instruction(1'b0), // �������ݻ���
        .tlb_flush(1'b0),
        .stall(),
        .write_back(1'b0),
        .satp(32'h0),          // ���÷�ҳ
        .mstatus(32'h0),
        .privilege_mode(2'b11),
        .fault_address(),
        .page_fault()
    );

    // ʱ�����ɣ�����10ns��
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // ����������
    initial begin
        // ��ʼ���ź�
        resetn = 0;
        cpu_valid = 0;
        cpu_wstrb = 0;
        cpu_addr = 0;
        cpu_wdata = 0;
        mem_ready = 1;          // �ڴ�Ĭ�Ͼ���
        mem_rdata = 32'h0;      // ��ʼ�ڴ�����Ϊ0
        #20;
        resetn = 1;

        // ===================================
        // ���Խ׶�1����֤�û�����д���뻺������
        // ===================================
        $display("\n--- �׶�1���û�������֤ ---");
        
        // д���ַ 0x100���û����� 0xa5a5a5a5��
        write_data(32'h100, 32'ha5a5a5a5);
        // ��ȡ��ַ 0x100��Ӧ���У�Ԥ���û����ݣ�
        read_data(32'h100, 32'ha5a5a5a5);

        // д���ַ 0x200���û����� 0x11111111��
        write_data(32'h200, 32'h11111111);
        // ��ȡ��ַ 0x200��Ӧ���У�Ԥ���û����ݣ�
        read_data(32'h200, 32'h11111111);

        // д���ַ 0x400���û����� 0x33333333��
        write_data(32'h400, 32'h33333333);
        // ��ȡ��ַ 0x400��Ӧ���У�Ԥ���û����ݣ�
        read_data(32'h400, 32'h33333333);

        // ��֤ȱʧ������Ԥ��3�Σ�����д��δ���У�
        $display("[�׶�1] ȱʧ���� = %d (Ԥ��3)", cache_miss_count);

        // ===================================
        // ���Խ׶�2����϶�д��LRU�滻��֤
        // ===================================
        $display("\n--- �׶�2����϶�д��֤ ---");
        
        // ��ȡδд���ַ 0x500��Ԥ���ڴ����� 0x00000500��
        read_data(32'h500, 32'h00000500);
        // �ٴζ�ȡ 0x500��Ӧ���У�Ԥ���ڴ����ݣ�
        read_data(32'h500, 32'h00000500);

        // д���µ�ַ 0x600���û����� 0x66666666��
        write_data(32'h600, 32'h66666666);
        // ��ȡ��ַ 0x600��Ӧ���У�Ԥ���û����ݣ�
        read_data(32'h600, 32'h66666666);

        // ��֤ȱʧ������3 + 1 = 4��
        $display("[�׶�2] ȱʧ���� = %d (Ԥ��4)", cache_miss_count);

        // ===================================
        // ���Խ׶�3��LRU�滻������ͻ
        // ===================================
        $display("\n--- �׶�3��LRU�滻��֤ ---");
        
        // д���ַ 0x700���û����� 0x77777777��
        write_data(32'h700, 32'h77777777);
        // д���ַ 0x800���û����� 0x88888888��
        write_data(32'h800, 32'h88888888);
        // д���ַ 0x900���û����� 0x99999999��
        write_data(32'h900, 32'h99999999);

        // ��ȡ��ʷ��ַ 0x100��Ӧ���У�Ԥ���û����ݣ�
        read_data(32'h100, 32'ha5a5a5a5);
        // ��ȡ��ʷ��ַ 0x700��Ӧ���У�Ԥ���û����ݣ�
        read_data(32'h700, 32'h77777777);

        // ��֤ȱʧ������4 + 3 = 7��
        $display("[�׶�3] ȱʧ���� = %d (Ԥ��7)", cache_miss_count);

        // ===================================
        // ���Խ���
        // ===================================
        #100;
        $display("\n--- ������� ---");
        $finish;
    end

    // �ڴ����ݶ�̬���ɣ��ؼ��޸ĵ㣩
    // --------------------------------
    // д������������û�д�����ݣ���֤������أ�
    // ��ȡ���������ص�ַ����ֵ����֤����δ������Ϊ��
    always @(*) begin
        if (mem_wstrb != 0) begin
            // д�����ʱ���ڴ淵���û�д�������
            mem_rdata = cpu_wdata;
        end else begin
            // ��ȡ����ʱ���ڴ淵�ص�ַ����ֵ����26λ��
            mem_rdata = {mem_addr[31:6], 6'b0};
        end
    end

    // д������ģ���û�����д�룩
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

    // ��ȡ�����ϸ�У��Ԥ��ֵ��
    task read_data(input [31:0] addr, input [31:0] expected);
        begin
            @(negedge clk);
            cpu_valid = 1;
            cpu_wstrb = 4'h0;  // ������
            cpu_addr = addr;
            @(negedge clk);
            cpu_valid = 0;
            #20; // �ȴ�������ڴ���Ӧ
            if (cpu_rdata !== expected) begin
                $error("[����] ��ַ=0x%h Ԥ��=0x%h ʵ��=0x%h", addr, expected, cpu_rdata);
            end else begin
                $display("[��ȡ] ��ַ=0x%h ����=0x%h ��ȷ", addr, cpu_rdata);
            end
        end
    endtask

endmodule