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

    // Tag �� Payload �洢
    reg [TAG_WIDTH-1:0] tags[WAYS-1:0][0:LINES-1];
    reg [PAYLOAD_WIDTH-1:0] payloads[WAYS-1:0][0:LINES-1];

    // ��Чλ��ÿ�� set �� WAYS ����Чλ
    reg [WAYS-1:0] v[0:LINES-1];

    // LRU ״̬��ÿ�� set ʹ�� 1bit ��ʾ���ʹ�õ� way
    reg [0:0] lru[0:LINES-1];  // 1-bit LRU per set

    integer i;
    integer way_to_replace;

    // === ���������м���߼� ===
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

    // === ʱ������� LRU �����߼� ===
    always @(posedge clk) begin
        if (!resetn) begin
            // ��λʱ������� tag��payload����Чλ�� LRU
            for (i = 0; i < LINES; i = i + 1) begin
                v[i] <= 'b0;
                lru[i] <= 'b0;
            end
        end else if (valid_i) begin

            // ������Ϊ������ʱ���� LRU
            if (!we && hit_o) begin
                for (i = 0; i < WAYS; i = i + 1) begin
                    if (tag == tags[i][idx] && v[idx][i]) begin
                        lru[idx] <= ~i;  // ������һ·��LRU ��Ϊ ~i
                    end
                end
            end

            // д�����ʱ�滻 LRU ·���ؼ��޸��㣩
            if (we) begin
                way_to_replace = lru[idx] ? 1 : 0;

                // �����±��滻·�� tag��payload ����Чλ
                tags[way_to_replace][idx] <= tag;
                payloads[way_to_replace][idx] <= payload_i;
                v[idx][way_to_replace] <= 1'b1;  // �����õ�ǰ·��Ч
                lru[idx] <= ~way_to_replace;     // ��Ǹ�·Ϊ���ʹ��
            end
        end
    end

endmodule 