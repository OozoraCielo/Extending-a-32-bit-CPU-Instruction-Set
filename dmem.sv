// CS 21 Lab2 -- S2 AY 2021-2022
// Carl David B. Ragunton -- 6/5/2022
// dmem.sv -- edited dmem.sv
`timescale 1ns / 1ps
module dmem(input  logic        clk, we,
            input  logic [31:0] a, wd,
            output logic [31:0] rd,
            input logic [5:0] opcode);

  logic [31:0] RAM[63:0];

  assign rd = RAM[a[31:2]]; // word aligned

  always_ff @(posedge clk)
    case(opcode)//sb
      6'b101000: 
        if (we)
          case(a%4)
            'b0: RAM[a[31:2]][31:24] <= wd[7:0];
            'b1: RAM[a[31:2]][23:16] <= wd[7:0];
            'b10: RAM[a[31:2]][15:8] <= wd[7:0];
            'b11: RAM[a[31:2]][7:0] <= wd[7:0];
          endcase
      default: if (we) RAM[a[31:2]] <= wd;
    endcase
endmodule