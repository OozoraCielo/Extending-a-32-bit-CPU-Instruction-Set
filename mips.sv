// CS 21 Lab2 -- S2 AY 2021-2022
// Carl David B. Ragunton -- 6/5/2022
// mips.sv -- edited mips.sv
`timescale 1ns / 1ps
module mips(input  logic        clk, reset,
            output logic [31:0] pc,
            input  logic [31:0] instr,
            output logic        memwrite,
            output logic [31:0] aluout, writedata,
            input  logic [31:0] readdata,
            output logic [5:0] opcode);//sb
  
  assign opcode = instr[31:26];//sb

  logic       memtoreg, alusrc, regdst, 
              regwrite, jump, pcsrc, zero,less;//ble
  logic [3:0] alucontrol;

  controller c(instr[31:26], instr[5:0], zero,less,
               memtoreg, memwrite, pcsrc,
               alusrc, regdst, regwrite, jump,
               alucontrol);//ble
  datapath dp(clk, reset, memtoreg, pcsrc,
              alusrc, regdst, regwrite, jump,
              alucontrol,
              zero,less, pc, instr,
              aluout, writedata, readdata);//ble
endmodule