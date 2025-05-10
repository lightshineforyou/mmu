module tag_ram #(
  parameter TAG_RAM_ADDR_WIDTH = 6,
            TAG_WIDTH          = 20,
            PAYLOAD_WIDTH      = 32,
            WAYS               = 2
)(
  input  wire                    clk,
  input  wire                    resetn,
  input  wire [TAG_RAM_ADDR_WIDTH-1:0] idx,
  input  wire [TAG_WIDTH-1:0]    tag,
  input  wire [PAYLOAD_WIDTH-1:0] payload_i,
  input  wire                    we,
  input  wire                    valid_i,
  output reg                     hit_o,
  output reg [PAYLOAD_WIDTH-1:0] payload_o
);
  localparam LINES = 2**TAG_RAM_ADDR_WIDTH;
 (* ram_style = "block" *) reg [TAG_WIDTH-1:0]    tags   [WAYS-1:0][0:LINES-1];
 (* ram_style = "block" *) reg [PAYLOAD_WIDTH-1:0] payloads [WAYS-1:0][0:LINES-1];
 (* ram_style = "block" *) reg [WAYS-1:0]          v      [0:LINES-1];
 (* ram_style = "block" *) reg [0:0]               lru    [0:LINES-1];
  reg [0:0]               replace_way;
  integer i;

  // pick replace way
  always @(*) begin
    if (!v[idx][0])       replace_way = 0;
    else if (!v[idx][1])  replace_way = 1;
    else                  replace_way = lru[idx];
  end

  // read port
  always @(*) begin
    hit_o      = 0;
    payload_o  = 0;
    for (i=0; i<WAYS; i=i+1) begin
      if (v[idx][i] && tags[i][idx] == tag) begin
        hit_o     = 1;
        payload_o = payloads[i][idx];
      end
    end
  end

  // write port
  always @(posedge clk) begin
    if (!resetn) begin
      for (i=0; i<LINES; i=i+1) begin
        v[i]   <= 0;
        lru[i] <= 0;
      end
    end else if (we && valid_i) begin
      tags   [replace_way][idx] <= tag;
      payloads[replace_way][idx] <= payload_i;
      v      [idx][replace_way] <= 1;
      lru    [idx]             <= ~replace_way;
      $display("[TAGRAM] WWay%0d[%0d] T=%h D=%h",
               replace_way, idx, tag, payload_i);
    end
  end
endmodule