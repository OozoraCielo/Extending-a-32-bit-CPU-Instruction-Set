// CS 21 Lab2 -- S2 AY 2021-2022
// Carl David B. Ragunton -- 6/5/2022
// controller.sv -- edited controller.sv
`timescale 1ns / 1ps
module controller(input  logic [5:0] op, funct,
                  input  logic       zero,less,
                  output logic       memtoreg, memwrite,
                  output logic       pcsrc, alusrc,
                  output logic       regdst, regwrite,
                  output logic       jump,
                  output logic [3:0] alucontrol);//ble

  logic [1:0] aluop;
  logic       branch;

  maindec md(op, memtoreg, memwrite, branch,
             alusrc, regdst, regwrite, jump, aluop);
  aludec  ad(funct, aluop, alucontrol,op);	//li
  
  always_comb//ble
    case(op)
      6'b011111: pcsrc = (branch & zero) | (branch & less);
      default:pcsrc = branch & zero;
  	endcase
  
endmodule