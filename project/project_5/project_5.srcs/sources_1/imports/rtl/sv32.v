`timescale 1ns/1ps
`include "sv32.vh"

module sv32 #(
    parameter NUM_ENTRIES_ITLB = 64,
    parameter NUM_ENTRIES_DTLB = 64
) (
    input  wire        clk,
    input  wire        resetn,

    // CPU interface
    input  wire        cpu_valid,
    output reg         cpu_ready,
    input  wire [ 3:0] cpu_wstrb,
    input  wire [31:0] cpu_addr,
    input  wire [31:0] cpu_wdata,
    output reg  [31:0] cpu_rdata,

    // Memory interface
    output reg         mem_valid,
    input  wire        mem_ready,
    output reg  [ 3:0] mem_wstrb,
    output reg  [33:0] mem_addr,
    output reg  [31:0] mem_wdata,
    input  wire [31:0] mem_rdata,

    // Stats
    output wire [31:0] cache_miss_count,

    // Unused MMU signals for this cache example
    input  wire        is_instruction,
    input  wire        tlb_flush,
    output reg         stall,
    input  wire        write_back,
    input  wire [31:0] satp,
    input  wire [31:0] mstatus,
    input  wire [ 1:0] privilege_mode,
    output reg  [31:0] fault_address,
    output reg         page_fault
);

  // --------------------------------------------------
  // Simplified 2-way write-allocate cache logic
  // --------------------------------------------------

  // Index and tag from CPU address
  wire [5:0]  cache_idx = cpu_addr[17:12];
  wire [19:0] cache_tag = cpu_addr[31:12];
  wire        is_write  = |cpu_wstrb;

  // Cache datapath signals
  wire        hit;
  wire [31:0] hit_data;
  reg         cache_we;
  reg  [31:0] cache_wdata;

  // Miss counter
  reg [31:0] miss_count;
  always @(posedge clk) begin
    if (!resetn) miss_count <= 0;
    else if (cpu_valid && !hit) miss_count <= miss_count + 1;
  end
  assign cache_miss_count = miss_count;

  // Write state machine for write-back path
  localparam WR_IDLE  = 2'd0,
             WR_WAIT  = 2'd1;
  reg [1:0] wr_state;

  always @(posedge clk) begin
    if (!resetn) wr_state <= WR_IDLE;
    else begin
      case (wr_state)
        WR_IDLE: if (cpu_valid && is_write && !hit) wr_state <= WR_WAIT;
        WR_WAIT: if (mem_ready)                     wr_state <= WR_IDLE;
      endcase
    end
  end

  // Allocate state machine for read- or write-miss fill
  localparam AL_IDLE = 1'b0,
             AL_FILL = 1'b1;
  reg alloc_state;
  reg [5:0]   alloc_idx;
  reg [19:0]  alloc_tag;
  reg [31:0]  alloc_data;

  always @(posedge clk) begin
    if (!resetn) alloc_state <= AL_IDLE;
    else alloc_state <= (alloc_state == AL_FILL ? AL_IDLE :
             (cpu_valid && !hit && ((is_write && wr_state==WR_WAIT && mem_ready) ||
              (!is_write && mem_valid && mem_ready))) ? AL_FILL : AL_IDLE);

    // capture for AL_FILL
    if (alloc_state == AL_IDLE && cpu_valid && !hit && mem_ready) begin
      alloc_idx  <= cache_idx;
      alloc_tag  <= cache_tag;
      alloc_data <= is_write ? cpu_wdata : mem_rdata;
    end
  end

  // Drive memory interface
  always @(*) begin
    // defaults
    mem_valid = 0;
    mem_addr  = {2'b00, cpu_addr};
    mem_wstrb = cpu_wstrb;
    mem_wdata = cpu_wdata;
    // on read miss: issue read
    if (cpu_valid && !is_write && !hit) mem_valid = 1;
    // on write miss: issue write
    if (cpu_valid && is_write && !hit)  mem_valid = (wr_state==WR_WAIT);
  end

  // Cache write enable and data
  always @(*) begin
    cache_we    = 0;
    cache_wdata = 0;
    // write hit: write-through into cache
    if (cpu_valid && is_write && hit) begin
      cache_we    = 1;
      cache_wdata = cpu_wdata;
    end
    // miss allocate fill
    else if (alloc_state == AL_FILL) begin
      cache_we    = 1;
      cache_wdata = alloc_data;
    end
  end

  // CPU ready and read data registered
  always @(posedge clk) begin
    if (!resetn) begin
      cpu_ready <= 0;
      cpu_rdata <= 0;
    end else begin
      // hit: ready next cycle
      if (cpu_valid && hit) begin
        cpu_ready <= 1;
        cpu_rdata <= hit_data;
      end
      // miss fill: ready with alloc_data
      else if (alloc_state == AL_FILL) begin
        cpu_ready <= 1;
        cpu_rdata <= alloc_data;
      end else begin
        cpu_ready <= 0;
      end
    end
  end

  // Instantiate 2-way tag_ram
  tag_ram #(
    .TAG_RAM_ADDR_WIDTH(6),
    .TAG_WIDTH(20),
    .PAYLOAD_WIDTH(32),
    .WAYS(2)
  ) u_tag_ram (
    .clk      (clk),
    .resetn   (resetn),
    .idx      (alloc_state==AL_FILL ? alloc_idx : cache_idx),
    .tag      (alloc_state==AL_FILL ? alloc_tag : cache_tag),
    .payload_i(cache_wdata),
    .we       (cache_we),
    .valid_i  (cpu_valid),
    .hit_o    (hit),
    .payload_o(hit_data)
  );

endmodule