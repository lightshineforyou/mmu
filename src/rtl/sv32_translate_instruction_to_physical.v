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
 *
 */
`default_nettype none

`include "sv32.vh"
module sv32_translate_instruction_to_physical (
    input  wire        clk,
    input  wire        resetn,
    input  wire [31:0] address,
    output reg  [33:0] physical_address,
    output reg         page_fault,
    input  wire [ 1:0] privilege_mode,

    input  wire valid,
    output reg  ready,

    output reg  walk_valid,
    input  wire walk_ready,

    input wire [31:0] pte
);
  localparam S0 = 0, S1 = 1, S_LAST = 2;
  localparam STATE_WIDTH = $clog2(S_LAST);
  reg [STATE_WIDTH-1:0] state, next_state;


  always @(posedge clk) state <= !resetn ? S0 : next_state;

  always @(*) begin
    next_state = state;

    case (state)
      S0: next_state = walk_ready ? S1 : S0;
      S1: next_state = S0;
      default: next_state = S0;
    endcase
  end

  reg [1:0] priv;
  reg page_fault_nxt;
  reg ready_nxt;
  reg [33:0] physical_address_nxt;
  reg [11:0] page_offset;
  reg [33:0] pagebase_addr;

  always @(posedge clk) begin
    if (!resetn) begin
      page_fault <= 1'b0;
      physical_address <= 0;
      ready <= 1'b0;
    end else begin
      page_fault <= page_fault_nxt;
      physical_address <= physical_address_nxt;
      ready <= ready_nxt;
    end
  end

  always @(*) begin

    physical_address_nxt = physical_address;
    priv = privilege_mode;
    page_fault_nxt = 1'b0;
    walk_valid = 1'b0;

    page_offset = 0;
    pagebase_addr = 0;
    ready_nxt = 1'b0;

    /* verilator lint_off WIDTHEXPAND */
    /* verilator lint_off WIDTHTRUNC */

    case (state)
      S0: begin
        if (valid && !ready) begin
          if (`IS_MACHINE(priv)) begin
            physical_address_nxt = {2'b0, address};
            ready_nxt = 1'b1;
          end else begin
            // sv32_table_walk
            walk_valid = 1'b1;
          end
        end
      end

      S1: begin
        walk_valid = 1'b0;

        // Check for reserved configurations
        if ((!
            `GET_PTE_X(pte)
            &&
            `GET_PTE_W(pte)
            && !
            `GET_PTE_R(pte)
            ) || (
            `GET_PTE_X(pte)
            &&
            `GET_PTE_W(pte)
            && !
            `GET_PTE_R(pte)
            )) begin
          page_fault_nxt = 1'b1;
        end else if (`IS_SUPERVISOR(priv)) begin
          // Supervisor want's to execute user page
          if (`GET_PTE_U(pte)) begin
            page_fault_nxt = 1'b1;
          end else if (!`GET_PTE_X(pte)) begin
            page_fault_nxt = 1'b1;
            // User mode
          end
        end else begin
          if (!(`GET_PTE_X(pte) && `GET_PTE_U(pte))) begin
            page_fault_nxt = 1'b1;
          end
        end

        page_offset = address & (`SV32_PAGE_SIZE - 1);
        pagebase_addr = (pte >> `SV32_PTE_ALIGNED_PPN_SHIFT) << `SV32_PTE_ALIGNED_PPN_SHIFT;
        physical_address_nxt = page_fault_nxt ? ~0 : (pagebase_addr | page_offset);
        ready_nxt = 1'b1;
      end
      default: ;
    endcase

    /* verilator lint_on WIDTHEXPAND */
    /* verilator lint_on WIDTHTRUNC */

  end
endmodule


