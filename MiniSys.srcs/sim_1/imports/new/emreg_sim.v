`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/24 16:03:40
// Design Name: 
// Module Name: emreg_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module emreg_sim();
  reg [31:0] ealu,eb;
  reg [4:0] ern;
  reg ewreg,em2reg,ewmem;
  //for memory
  reg [2:0] elmem;
  reg [1:0] esmem;
  reg clk,clrn;
  wire [31:0] malu,mb;
  wire [4:0] mrn;
  wire mwreg,mm2reg,mwmem;
  //for memory
  wire [2:0] mlmem;
  wire [1:0] msmem;
  pipeemreg emreg(ewreg,em2reg,ewmem,elmem,esmem,ealu,eb,ern,clk,clrn,
  mwreg,mm2reg,mwmem,mlmem,msmem,malu,mb,mrn);
  always 
          begin
              ealu = 32'h12345678;
              eb = 32'h87654321;
              ern = 5'b00001;
              ewreg = 1;
              em2reg = 1;
              ewmem = 1;
              elmem = 3'b010;
              esmem = 2'b10;
              clk = 0;
              clrn=1;
              #5;
              clk = 1;
              #5
              clk = 0;
              #5
              clk = 1;
              clrn = 0;
              #5;
              clk = 0;
              #5
              clk = 1;
              #5
              clk = 0;
              #5
              clk = 1;
              clrn=1;
              #5;
              
              clk=0;
              #5;
              clk=1;
              #2000;
      end
endmodule
