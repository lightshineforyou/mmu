module tag_ram #(
    parameter TAG_RAM_ADDR_WIDTH = 6,
    parameter TAG_WIDTH = 20,
    parameter PAYLOAD_WIDTH = 32,
    parameter WAYS = 2 // 支持两路组相联
) (
    input wire clk,
    input wire resetn,
    input wire [TAG_RAM_ADDR_WIDTH -1:0] idx,
    input wire [TAG_WIDTH -1:0] tag,
    input wire [PAYLOAD_WIDTH -1:0] payload_i,
    input wire we,
    input wire valid_i,
    output reg hit_o,
    output reg [PAYLOAD_WIDTH -1:0] payload_o
);
  localparam LINES = 2 ** TAG_RAM_ADDR_WIDTH;
  reg [TAG_WIDTH -1:0] tags[WAYS-1:0][0:LINES -1];
  reg [PAYLOAD_WIDTH -1:0] payloads[WAYS-1:0][0:LINES -1];
  reg [WAYS-1:0] v[0:LINES -1];
  reg [WAYS-1:0] lru[0:LINES -1]; // LRU 位

  integer i; // 将变量声明移到模块顶部
  integer way_to_replace; // 将变量声明移到模块顶部

  always @(*) begin
    hit_o = 0;
    payload_o = 0;
    for (i = 0; i < WAYS; i = i + 1) begin
      if (tag == tags[i][idx] && v[idx][i]) begin
        hit_o = 1;
        payload_o = payloads[i][idx];
      end
    end
  end

  always @(posedge clk) begin
    if (!resetn) begin
      for (i = 0; i < LINES; i = i + 1) begin
        v[i] <= 0;
        lru[i] <= 0;
      end
    end else if (valid_i) begin
      if (we) begin
        // 替换逻辑：选择 LRU 的路
        way_to_replace = lru[idx][0] ? 0 : 1; // 使用模块顶部声明的变量
        tags[way_to_replace][idx] <= tag;
        payloads[way_to_replace][idx] <= payload_i;
        v[idx][way_to_replace] <= 1'b1;
        lru[idx][way_to_replace] <= ~lru[idx][way_to_replace]; // 更新 LRU
      end
    end
  end
endmodule