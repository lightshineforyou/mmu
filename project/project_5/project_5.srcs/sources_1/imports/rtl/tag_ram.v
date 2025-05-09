module tag_ram #(
    parameter TAG_RAM_ADDR_WIDTH = 6,
    parameter TAG_WIDTH = 20,
    parameter PAYLOAD_WIDTH = 32,
    parameter WAYS = 2
) (
    input wire clk,
    input wire resetn,
    input wire [TAG_RAM_ADDR_WIDTH-1:0] idx,
    input wire [TAG_WIDTH-1:0] tag,
    input wire [PAYLOAD_WIDTH-1:0] payload_i,
    input wire we,
    input wire valid_i,
    output reg hit_o,
    output reg [PAYLOAD_WIDTH-1:0] payload_o
);

    localparam LINES = 2 ** TAG_RAM_ADDR_WIDTH;

    // Tag 和 Payload 存储
    reg [TAG_WIDTH-1:0] tags[WAYS-1:0][0:LINES-1];
    reg [PAYLOAD_WIDTH-1:0] payloads[WAYS-1:0][0:LINES-1];

    // 有效位：每个 set 有 WAYS 个有效位
    reg [WAYS-1:0] v[0:LINES-1];

    // LRU 状态：每个 set 使用 1bit 表示最近使用的 way
    reg [0:0] lru[0:LINES-1];  // 1-bit LRU per set

    integer i;
    integer way_to_replace;

    // === 组相联命中检测逻辑 ===
    always @(*) begin
        hit_o = 1'b0;
        payload_o = 'd0;

        for (i = 0; i < WAYS; i = i + 1) begin
            if (tag == tags[i][idx] && v[idx][i]) begin
                hit_o = 1'b1;
                payload_o = payloads[i][idx];
            end
        end
    end

    // === 时序控制与 LRU 更新逻辑 ===
    always @(posedge clk) begin
        if (!resetn) begin
            // 复位时清空所有 tag、payload、有效位和 LRU
            for (i = 0; i < LINES; i = i + 1) begin
                v[i] <= 'b0;
                lru[i] <= 'b0;
            end
        end else if (valid_i) begin

            // 命中且为读操作时更新 LRU
            if (!we && hit_o) begin
                for (i = 0; i < WAYS; i = i + 1) begin
                    if (tag == tags[i][idx] && v[idx][i]) begin
                        lru[idx] <= ~i;  // 命中哪一路，LRU 设为 ~i
                    end
                end
            end

            // 写入操作时替换 LRU 路（关键修复点）
            if (we) begin
                way_to_replace = lru[idx] ? 1 : 0;

                // 仅更新被替换路的 tag、payload 和有效位
                tags[way_to_replace][idx] <= tag;
                payloads[way_to_replace][idx] <= payload_i;
                v[idx][way_to_replace] <= 1'b1;  // 仅设置当前路有效
                lru[idx] <= ~way_to_replace;     // 标记该路为最近使用
            end
        end
    end

endmodule 