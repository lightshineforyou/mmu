/*
 *  kianv harris multicycle RISC-V rv32ima
 *
 *  copyright (c) 2023/2024 hirosh dabui <hirosh@dabui.de>
 *
 *  permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  the software is provided "as is" and the author disclaims all warranties
 *  with regard to this software including all implied warranties of
 *  merchantability and fitness. in no event shall the author be liable for
 *  any special, direct, indirect, or consequential damages or any damages
 *  whatsoever resulting from loss of use, data or profits, whether in an
 *  action of contract, negligence or other tortious action, arising out of
 *  or in connection with the use or performance of this software.
 */

/*
    VA: Virtual Address
    PA: Physical Address
    satp: Supervisor Address Translation and Protection
    VPN: Virtual Page Number
    PPN: Physical Page Number
    PTE: Page Table Entry

    +---------------------------------+
    |         Virtual Address         |
    +--------+--------+---------------+
    |  VPN[1]|  VPN[0]|    offset     |
    +---|----+----|---+---------------+
        |         |
      +-V-+     +-V-+
      |   |     |   |
      |Page Table   |
      |   |     |   |
      +---+     +---+
        |         |
        |         |
      +-V-+     +-V-+
      |PTE|     |PTE|
      +---+     +---+
        |         |
        +---------+
                |
    +-----------|--------------------+
    |        Physical Address        |
    +--------------------+-----------+
    |     PPN            |   offset  |
    +--------------------+-----------+
*/

`include "sv32.vh"

module sv32 #(
    parameter NUM_ENTRIES_ITLB = 64,
    parameter NUM_ENTRIES_DTLB = 64
) (
    input wire clk,
    input wire resetn,

    input  wire        cpu_valid,
    output reg         cpu_ready,
    input  wire [ 3:0] cpu_wstrb,
    input  wire [31:0] cpu_addr,
    input  wire [31:0] cpu_wdata,
    output reg  [31:0] cpu_rdata,

    output reg         mem_valid,
    input  wire        mem_ready,
    output reg  [ 3:0] mem_wstrb,
    output reg  [33:0] mem_addr,
    output reg  [31:0] mem_wdata,
    input  wire [31:0] mem_rdata,

    output wire [31:0] cache_miss_count,

    input  wire is_instruction,
    input  wire tlb_flush,
    output reg  stall,
    input  wire write_back,
    input  wire [31:0] satp,
    input  wire [31:0] mstatus,
    input  wire [ 1:0] privilege_mode,
    output reg  [31:0] fault_address,
    output reg         page_fault
);

localparam S0 = 0, S1 = 1, S2 = 2, S_LAST = 3;
localparam STATE_WIDTH = $clog2(S_LAST);
reg [STATE_WIDTH-1:0] state, next_state;

wire [31:0] internal_tlb_miss_count;

wire [33:0] physical_data_address;
reg         translate_data_valid;
wire        translate_data_ready;
wire        page_fault_instruction;
wire        page_fault_data;

wire [33:0] physical_instruction_address;
reg         translate_instruction_valid;
wire        translate_instruction_ready;

wire        walk_translate_instruction_mem_valid;
wire        walk_translate_instruction_mem_ready;
wire [31:0] walk_translate_instruction_mem_addr;

wire        walk_translate_data_mem_valid;
wire        walk_translate_data_mem_ready;
wire [31:0] walk_translate_data_mem_addr;

wire [31:0] pte;

wire        walk_valid;
wire        walk_ready;

wire        trans_instr_to_phy_walk_valid;
wire        trans_instr_to_phy_walk_ready;

wire        trans_data_to_phy_walk_valid;
wire        trans_data_to_phy_walk_ready;

wire        walk_mem_valid;
reg         walk_mem_ready;
wire [31:0] walk_mem_addr;
reg  [31:0] walk_mem_rdata;

wire        is_page_fault;

// 实例化 table walk 模块
sv32_table_walk u_sv32_table_walk (
    .clk            (clk),
    .resetn         (resetn),
    .tlb_miss_count (internal_tlb_miss_count)
);

assign is_page_fault = page_fault_instruction || page_fault_data;
assign tlb_miss_count = internal_tlb_miss_count;

always @(posedge clk) begin
    if (!resetn) begin
        page_fault <= 1'b0;
        fault_address <= 0;
    end else begin
        page_fault <= is_page_fault;
        if (is_page_fault) fault_address <= cpu_addr;
    end
end

// === Cache tag ram 接口 ===
wire [5:0] cache_idx = cpu_addr[11:6]; // index width=6
wire [19:0] cache_tag = cpu_addr[31:12]; // tag width=20

reg cache_we_reg;
reg [31:0] cache_payload_reg;

// === Cache 写入使能信号 ===
// === Cache 写入使能信号 ===
always @(*) begin
    cache_we_reg = 1'b0;
    cache_payload_reg = 32'b0;

    // 写入操作（写直达策略）
    if (cpu_valid && (|cpu_wstrb)) begin
        if (hit_o) begin
            // 命中时直接更新缓存
            cache_we_reg = 1'b1;
            cache_payload_reg = cpu_wdata;
        end else if (mem_ready) begin
            // 未命中且内存响应完成时，分配新行并写入用户数据
            cache_we_reg = 1'b1;
            cache_payload_reg = cpu_wdata;
        end
    end 
    // 读取未命中时加载内存数据
    else if (cpu_valid && !hit_o && mem_ready) begin
        cache_we_reg = 1'b1;
        cache_payload_reg = mem_rdata;
    end
end

// === 实例化 Cache tag_ram ===
wire hit_o;

tag_ram #(
    .TAG_RAM_ADDR_WIDTH(6),
    .TAG_WIDTH(20),
    .PAYLOAD_WIDTH(32),
    .WAYS(2)
) u_tag_ram (
    .clk(clk),
    .resetn(resetn),
    .idx(cache_idx),
    .tag(cache_tag),
    .payload_i(cache_payload_reg),
    .we(cache_we_reg),
    .valid_i(cpu_valid),
    .hit_o(hit_o),
    .payload_o(cpu_rdata) // 不使用输出
);

// === Cache 缺失计数器 ===
reg [31:0] cache_miss_count_reg;
always @(posedge clk) begin
    if (!resetn) begin
        cache_miss_count_reg <= 0;
    end else if (cpu_valid && !hit_o) begin
        cache_miss_count_reg <= cache_miss_count_reg + 1;
    end
end
assign cache_miss_count = cache_miss_count_reg;

always @(posedge clk) begin
    state <= !resetn ? S0 : next_state;
end

wire translate_req_pending;
wire mmu_translate_enable = `GET_SATP_MODE(satp);
assign translate_req_pending = mmu_translate_enable && cpu_valid && !mem_ready && !page_fault;

wire translation_complete;
assign translation_complete = translate_instruction_ready || translate_data_ready;

always @(*) begin
    next_state = state;
    case (state)
        S0: next_state = translate_req_pending ? S1 : S0;
        S1: next_state = is_page_fault ? S0 : (translation_complete ? S2 : S1);
        S2: next_state = mem_ready ? S0 : S2;
        default: next_state = S0;
    endcase
end

always @(*) begin
    translate_instruction_valid = 1'b0;
    translate_data_valid = 1'b0;

    case (state)
        S0: begin
            if (translate_req_pending) begin
                translate_instruction_valid = is_instruction;
                translate_data_valid = !is_instruction;
            end
        end
    endcase
end

wire [33:0] selected_phys_addr;
assign selected_phys_addr = is_instruction ? physical_instruction_address : physical_data_address;

always @(*) begin
    stall = 1'b0;
    mem_addr = 0;
    cpu_rdata = 0;
    mem_wstrb = 0;
    mem_wdata = 0;
    mem_valid = 1'b0;
    cpu_ready = mem_ready;
    walk_mem_rdata = 0;
    walk_mem_ready = 1'b0;

    case (state)
        S0: begin
            if (mmu_translate_enable && cpu_valid) begin
                cpu_ready = 1'b0;
            end else begin
                mem_addr  = {2'b0, cpu_addr};
                mem_wstrb = cpu_wstrb;
                mem_wdata = cpu_wdata;
                cpu_rdata = mem_rdata;
                mem_valid = cpu_valid;
            end
        end
        S1: begin
            stall = 1'b1;
            mem_addr = {2'b0, walk_mem_addr};
            mem_wstrb = 4'b0000;
            mem_wdata = 0;
            walk_mem_rdata = mem_rdata;
            mem_valid = walk_mem_valid;
            walk_mem_ready = mem_ready;
            cpu_ready = 1'b0;

            if (translation_complete && !is_page_fault) begin
                mem_addr  = selected_phys_addr;
                mem_wstrb = cpu_wstrb;
                mem_wdata = cpu_wdata;
                cpu_rdata = mem_rdata;
                mem_valid = cpu_valid;
            end
        end
        S2: begin
            if (cpu_valid && |cpu_wstrb) begin
                if (write_back) begin
                    mem_addr = selected_phys_addr;
                    mem_wdata = cpu_wdata;
                    mem_wstrb = cpu_wstrb;
                end else begin
                    mem_addr = selected_phys_addr;
                    mem_wdata = cpu_wdata;
                    mem_wstrb = cpu_wstrb;
                end
            end else begin
                mem_addr  = selected_phys_addr;
                mem_wstrb = cpu_wstrb;
                mem_wdata = cpu_wdata;
                cpu_rdata = mem_rdata;
                mem_valid = cpu_valid;
            end
        end
    endcase
end

assign walk_valid = is_instruction ? trans_instr_to_phy_walk_valid : trans_data_to_phy_walk_valid;
assign trans_instr_to_phy_walk_ready = is_instruction && walk_ready;
assign trans_data_to_phy_walk_ready = !is_instruction && walk_ready;

sv32_table_walk #(
    .NUM_ENTRIES_ITLB(NUM_ENTRIES_ITLB),
    .NUM_ENTRIES_DTLB(NUM_ENTRIES_DTLB)
) sv32_table_walk_I (
    .clk    (clk),
    .resetn (resetn),
    .address(cpu_addr),
    .satp   (satp),
    .pte    (pte),

    .is_instruction(is_instruction),
    .tlb_flush(tlb_flush),

    .valid(walk_valid),
    .ready(walk_ready),

    .walk_mem_valid(walk_mem_valid),
    .walk_mem_ready(walk_mem_ready),
    .walk_mem_addr (walk_mem_addr),
    .walk_mem_rdata(walk_mem_rdata)
);

sv32_translate_instruction_to_physical sv32_translate_instruction (
    .clk             (clk),
    .resetn          (resetn),
    .address         (cpu_addr),
    .physical_address(physical_instruction_address),
    .page_fault      (page_fault_instruction),
    .privilege_mode  (privilege_mode),

    .valid(translate_instruction_valid),
    .ready(translate_instruction_ready),

    .walk_valid(trans_instr_to_phy_walk_valid),
    .walk_ready(trans_instr_to_phy_walk_ready),
    .pte(pte)
);

sv32_translate_data_to_physical sv32_translate_data (
    .clk             (clk),
    .resetn          (resetn),
    .address         (cpu_addr),
    .physical_address(physical_data_address),
    .is_write        (|cpu_wstrb),
    .page_fault      (page_fault_data),
    .privilege_mode  (privilege_mode),
    .mstatus         (mstatus),

    .valid(translate_data_valid),
    .ready(translate_data_ready),

    .walk_valid(trans_data_to_phy_walk_valid),
    .walk_ready(trans_data_to_phy_walk_ready),
    .pte_(pte)
);

endmodule