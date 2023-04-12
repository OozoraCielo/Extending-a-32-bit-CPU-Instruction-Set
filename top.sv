// CS 21 Lab2 -- S2 AY 2021-2022
// Carl David B. Ragunton -- 6/5/2022
// top.sv -- edited top.sv
`timescale 1ns / 1ps
module top(input  logic        clk, reset, 
           output logic [31:0] writedata, dataadr, 
           output logic        memwrite,
           input logic [5:0] opcode);//sb

  logic [31:0] pc, instr, readdata;
  
  // instantiate processor and memories
  mips mips(clk, reset, pc, instr, memwrite, dataadr, 
            writedata, readdata, opcode);//sb
  imem imem(pc[7:2], instr);
  dmem dmem(clk, memwrite, dataadr, writedata, readdata, opcode);//sb
endmodule