/*
 * DO NOT EDIT THIS FILE, your changes will be overwritten
 * This is an automatically generated file.
 * It was generated with uasm, the microassembler, on
 * Tue Jul 04 10:30:21 2017
 */

/*
 * This case statement was generated with the following
 *   fields:

   wire [31:0]  DATA_out;
   wire [ 2:0]  ASEL;
   wire [ 2:0]  BSEL;
   wire [ 2:0]  DSEL;
   wire [ 3:0]  SSEL;
   wire [ 2:0]  HSEL;
   wire         MUX1;
   wire [ 2:0]  MUX2;
   wire [ 7:0]  ADRS;
   wire [ 3:0]  MISC;


   assign                 ASEL = DATA_out[31:29];    // bit size:3
   assign                 BSEL = DATA_out[28:26];    // bit size:3
   assign                 DSEL = DATA_out[25:23];    // bit size:3
   assign                 SSEL = DATA_out[22:19];    // bit size:4
   assign                 HSEL = DATA_out[18:16];    // bit size:3
   assign                 MUX1 = DATA_out[15];       // bit size:1
   assign                 MUX2 = DATA_out[14:12];    // bit size:3
   assign                 ADRS = DATA_out[11: 4];    // bit size:8
   assign                 MISC = DATA_out[ 3: 0];    // bit size:4
 *
 * Yeilding a total data width of 32 bits for 9 fields.
 * The maximum address encountered was 0xff, needing 8 bits
 */
`timescale 1ns/1ns
module microcode_rom (ADDR_in,DATA_out);
   input  [ 7:0] ADDR_in;
   output [31:0] DATA_out;

   reg    [31:0] DATA_out_r;

   assign DATA_out = DATA_out_r;
   always @(ADDR_in)
     begin
        case(ADDR_in)
          /* START: */
          8'h0: DATA_out_r = 32'b000_000_001_0000_000_0_000_00000000_0000;
          8'h1: DATA_out_r = 32'b001_000_010_0001_000_0_000_00000000_0000;
          8'h2: DATA_out_r = 32'b100_101_010_0010_000_0_000_00000000_0000;
          8'h3: DATA_out_r = 32'b100_101_010_0101_000_0_000_00000000_0000;
          8'h4: DATA_out_r = 32'b010_000_010_0110_000_0_000_00000000_0000;
          8'h5: DATA_out_r = 32'b010_000_001_0111_000_0_000_00000000_0000;
          8'h6: DATA_out_r = 32'b101_100_010_1000_000_0_000_00000000_0000;
          8'h7: DATA_out_r = 32'b101_100_010_1010_000_0_000_00000000_0000;
          8'h8: DATA_out_r = 32'b101_100_010_1100_000_0_000_00000000_0000;
          8'h9: DATA_out_r = 32'b110_000_010_1110_000_0_000_00000000_0000;
          8'ha: DATA_out_r = 32'b111_000_010_0000_000_0_000_00000000_0000;
          8'hb: DATA_out_r = 32'b111_000_010_0000_001_0_000_00000000_0000;
          8'hc: DATA_out_r = 32'b111_000_010_0000_010_0_000_00000000_0000;
          8'hd: DATA_out_r = 32'b010_000_010_0000_011_0_000_00000000_0000;
          8'he: DATA_out_r = 32'b100_101_010_0010_100_0_000_00000000_0000;
          8'hf: DATA_out_r = 32'b010_101_010_0000_100_0_000_00000000_0000;
          8'h10: DATA_out_r = 32'b010_000_010_0000_101_0_000_00000000_0000;
          8'h11: DATA_out_r = 32'b111_000_010_0000_110_0_000_00000000_0000;
          8'h12: DATA_out_r = 32'b100_101_010_0010_111_0_000_00000000_0000;
          8'h13: DATA_out_r = 32'b010_000_010_0000_111_0_001_00000000_0000;
          8'hff: DATA_out_r = 32'b000_000_000_0000_000_0_000_00000000_0000;
          default: DATA_out_r = 32'b0;
       endcase
     end
endmodule
