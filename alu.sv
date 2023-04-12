// CS 21 Lab2 -- S2 AY 2021-2022
// Carl David B. Ragunton -- 6/5/2022
// alu.sv -- edited alu.sv
module alu(input  logic [31:0] a, b,
           input  logic [3:0]  alucontrol,
           output logic [31:0] result,
           output logic        zero,less);//ble
  
  logic [31:0] condinvb, sum;

  assign condinvb = alucontrol[3] ? ~b : b;
  assign sum = a + condinvb + alucontrol[3];
 
  always_comb
    case (alucontrol[2:0])
      3'b000: result = a & b;
      3'b001: result = a | b;
      3'b010: result = sum;
      3'b011: result = sum[31];
      3'b110: result = 0 | b[15:0]; //li
      3'b100: result = a << b; //sll
      3'b101:  //zfr
        case(b[4:0])
          5'b00000: result = {a[31:1],1'b0};
          5'b00001: result = {a[31:2],2'b0};
          5'b00010: result = {a[31:3],3'b0};
          5'b00011: result = {a[31:4],4'b0};
          5'b00100: result = {a[31:5],5'b0};
          5'b00101: result = {a[31:6],6'b0};
          5'b00110: result = {a[31:7],7'b0};
          5'b00111: result = {a[31:8],8'b0};
          5'b01000: result = {a[31:9],9'b0};
          5'b01001: result = {a[31:10],10'b0};
          5'b01010: result = {a[31:11],11'b0};
          5'b01011: result = {a[31:12],12'b0};
          5'b01100: result = {a[31:13],13'b0};
          5'b01101: result = {a[31:14],14'b0};
          5'b01110: result = {a[31:15],15'b0};
          5'b10000: result = {a[31:17],17'b0};
          5'b10001: result = {a[31:18],18'b0};
          5'b10010: result = {a[31:19],19'b0};
          5'b10011: result = {a[31:20],20'b0};
          5'b10100: result = {a[31:21],21'b0};
          5'b10101: result = {a[31:22],22'b0};
          5'b10110: result = {a[31:23],23'b0};
          5'b10111: result = {a[31:24],24'b0};
          5'b11000: result = {a[31:25],25'b0};
          5'b11001: result = {a[31:26],26'b0};
          5'b11010: result = {a[31:27],27'b0};
          5'b11011: result = {a[31:28],28'b0};
          5'b11100: result = {a[31:29],29'b0};
          5'b11101: result = {a[31:30],30'b0};
          5'b11110: result = {a[31],31'b0};
          5'b11111: result = a;
        endcase
    endcase

  assign zero = ((alucontrol=='b1010) & (a==b)) | (result==0);
  assign less = (alucontrol=='b1010) & (a < b);
endmodule