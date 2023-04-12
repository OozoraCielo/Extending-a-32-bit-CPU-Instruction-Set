// CS 21 Lab2 -- S2 AY 2021-2022
// Carl David B. Ragunton -- 6/5/2022
// aludec.sv -- edited aludec.sv
////////////
`timescale 1ns / 1ps
module aludec(input  logic [5:0] funct,
              input  logic [1:0] aluop,
              output logic [3:0] alucontrol,
              input[5:0] op); //li

  always_comb
    case(aluop)
      2'b00:
        case(op)
          6'b010001: alucontrol <= 4'b0110; //li
          default: alucontrol <= 4'b0010;  // add (for lw/sw/addi/sb)
        endcase
      2'b01: alucontrol <= 4'b1010;  // sub (for beq and ble)
      default: case(funct)          // R-type instructions
          6'b000000: alucontrol <= 4'b0100; // sll
          6'b100000: alucontrol <= 4'b0010; // add
          6'b100010: alucontrol <= 4'b1010; // sub
          6'b100100: alucontrol <= 4'b0000; // and
          6'b100101: alucontrol <= 4'b0001; // or
          6'b101010: alucontrol <= 4'b1011; // slt
          6'b110011: alucontrol <= 4'b0101; // zfr
          default:   alucontrol <= 4'bxxxx; // ???
        endcase
    endcase
endmodule
