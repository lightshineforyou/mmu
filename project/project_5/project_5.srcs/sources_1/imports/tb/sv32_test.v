`timescale 1ns / 1ps
`include "riscv_priv_csr_status.vh"

module sv32_test;

reg clk;
reg resetn;

// CPU�ӿ��ź�
reg         cpu_valid;
wire        cpu_ready;
reg  [3:0]  cpu_wstrb;
reg  [31:0] cpu_addr;
reg  [31:0] cpu_wdata;
wire [31:0] cpu_rdata;

// �洢���ӿ��ź�
wire        mem_valid;
reg         mem_ready;
wire [3:0]  mem_wstrb;
wire [33:0] mem_addr;
wire [31:0] mem_wdata;
wire [31:0] mem_rdata;

// �����ź�
reg         is_instruction;
reg         tlb_flush;
wire        stall;
reg  [31:0] satp;
reg  [31:0] mstatus;
reg  [1:0]  privilege_mode;
wire [31:0] fault_address;
wire        page_fault;
wire [31:0] tlb_miss_count;

// ���ڴ�ģ�ͣ�4KB��
reg [31:0] mem [0:1023];
assign mem_rdata = (mem_addr < 32'h0000_4000) ? mem[mem_addr[11:2]] : 32'hDEADBEEF;

// ʵ��������ģ��
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

// ʱ������
initial clk = 0;
always #5 clk = ~clk;

// �ڴ���Ӧ
always @(posedge clk) begin
    mem_ready <= mem_valid;
end

// д��������
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
        mem[addr[11:2]] = wdata;
        $display("[WRITE] Addr=0x%h, Data=0x%h", addr, wdata);
    end
endtask

// ����������
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
            $display("[FAULT] Page fault at addr=0x%h", fault_address);
        #10;
        $display("[READ] Addr=0x%h, Got=0x%h, Expected=0x%h", addr, cpu_rdata, expected);
        if (!page_fault && cpu_rdata !== expected)
            $display("[ERROR] Data mismatch!");
    end
endtask

// ����������
initial begin
    // ��ʼ��
    clk = 0;
    resetn = 0;
    cpu_valid = 0;
    cpu_wstrb = 0;
    cpu_addr = 0;
    cpu_wdata = 0;
    mem_ready = 0;
    is_instruction = 0;
    tlb_flush = 0;
    mstatus = 0;
    privilege_mode = `PRIVILEGE_MODE_MACHINE;
    satp = 32'h80000001; // ��satp����

    // ��ʼ���ڴ�
    for (integer i = 0; i < 1024; i = i + 1)
        mem[i] = 32'h0;

    #20 resetn = 1;
    #10;

    // д���������
    write_transaction(32'h0000_1000, 32'hAAAA_0001, 4'b1111);
    write_transaction(32'h0000_2000, 32'hBBBB_0002, 4'b1111);

    // ������������TLB miss
    $display("\n=== TLB Miss Test ===");
    read_transaction(32'h0000_1000, 32'hAAAA_0001);
    read_transaction(32'h0000_2000, 32'hBBBB_0002);

    // �ٴζ�������Ӧ��TLB����
    read_transaction(32'h0000_1000, 32'hAAAA_0001);

    // ���TLB miss����
    $display("[RESULT] TLB Miss Count = %0d", tlb_miss_count);

    #100;
    $display("\n=== All tests completed ===");
    $finish;
end

endmodule