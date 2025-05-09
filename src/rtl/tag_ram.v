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
    reg [TAG_WIDTH-1:0] tags[WAYS-1:0][0:LINES-1];
    reg [PAYLOAD_WIDTH-1:0] payloads[WAYS-1:0][0:LINES-1];
    reg [WAYS-1:0] v[0:LINES-1];
    reg [0:0] lru[0:LINES-1];  // 1-bit LRU per set

    integer i;

    // ���м������߼�
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

    // ʱ���߼�������LRU�ʹ洢
    always @(posedge clk) begin
        if (!resetn) begin
            for (i = 0; i < LINES; i = i + 1) begin
                v[i] <= 0;
                lru[i] <= 0;
            end
        end else if (valid_i) begin
            // ����ʱ����LRU
            if (!we && hit_o) begin
                for (i = 0; i < WAYS; i = i + 1) begin
                    if (tag == tags[i][idx] && v[idx][i]) begin
                        lru[idx] <= ~i;  // ����·iʱ��LRU=~i
                    end
                end
            end
            // д��ʱ�滻LRU·
            if (we) begin
                integer way_to_replace = lru[idx] ? 1 : 0;  // ����LRUѡ��·
                tags[way_to_replace][idx] <= tag;
                payloads[way_to_replace][idx] <= payload_i;
                v[idx][way_to_replace] <= 1'b1;
                lru[idx] <= ~way_to_replace;  // ��д���·���Ϊ���ʹ��
            end
        end
    end
endmodule