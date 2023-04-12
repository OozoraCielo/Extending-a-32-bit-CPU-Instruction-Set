// CS 21 Lab2 -- S2 AY 2021-2022
// Carl David B. Ragunton -- 6/5/2022
// datapath.sv -- edited datapath.sv
////////////
`timescale 1ns / 1ps
module datapath(input  logic        clk, reset,
                input  logic        memtoreg, pcsrc,
                input  logic        alusrc, regdst,
                input  logic        regwrite, jump,
                input  logic [3:0]  alucontrol,
                output logic        zero,less,
                output logic [31:0] pc,
                input  logic [31:0] instr,
                output logic [31:0] aluout, writedata,
                input  logic [31:0] readdata);//ble

  logic [4:0]  writereg;
  logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
  logic [31:0] signimm, signimmsh;
  logic [31:0] srca, srcb,srcB,shamt; //sll
  logic [31:0] result;
  logic alusrcb;//sll
  logic [4:0] instr2521;//sll
  
  
  assign alusrcb = (alucontrol[3:0]==4'b0100) ? 1 : 0;//sll
  assign shamt = {27'b0,instr[10:6]};//sll

  // next PC logic
  flopr #(32) pcreg(clk, reset, pcnext, pc);
  adder #(32) pcadd1(pc, 32'b100, 'b0, pcplus4); //So we adjust this to use the more complex adder; wmt-modification
  sl2         immsh(signimm, signimmsh);
  adder #(32) pcadd2(pcplus4, signimmsh, 'b0, pcbranch); //See comment above
  mux2 #(32)  pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
  mux2 #(32)  pcmux(pcnextbr, {pcplus4[31:28], 
                    instr[25:0], 2'b00}, jump, pcnext);

  // register file logic
  mux2 #(32)  instr2521sll(instr[25:21],instr[20:16],alusrcb,instr2521);//sll
  regfile     rf(clk, regwrite, instr2521, instr[20:16], 
                 writereg, result, srca, writedata);//sll
  mux2 #(5)   wrmux(instr[20:16], instr[15:11],
                    regdst, writereg);
  mux2 #(32)  resmux(aluout, readdata, memtoreg, result);
  signext     se(instr[15:0], signimm);

  // ALU logic
  mux2 #(32)  srcbmux(writedata, signimm, alusrc, srcb);
  mux2 #(32)  srcBmux(srcb,shamt,alusrcb,srcB);//sll
  alu         alu(srca, srcB, alucontrol, aluout, zero,less);//sll,ble
endmodule