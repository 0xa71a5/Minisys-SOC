`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/01 23:21:18
// Design Name: 
// Module Name: pipeemreg
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


module pipeemreg(ewreg,em2reg,ewmem,elmem,esmem,ealu,eb,ern,clk,clrn,
mwreg,mm2reg,mwmem,mlmem,msmem,malu,mb,mrn);
   input [31:0] ealu,eb;
   input [4:0] ern;
   input ewreg,em2reg,ewmem;
   //for memory
   input [2:0] elmem;
   input [1:0] esmem;
   input clk,clrn;
   output [31:0] malu,mb;
   output [4:0] mrn;
   output mwreg,mm2reg,mwmem;
   //for memory
   output [2:0] mlmem;
   output [1:0] msmem;
   reg [31:0] malu,mb;
   reg [4:0] mrn;
   reg mwreg,mm2reg,mwmem,mlmem,msmem;
   always @(negedge clrn or posedge clk)
       if (clrn == 0) begin
           mwreg <= 0;
           mm2reg <=0;
           mwmem <= 0;
           malu <= 0;
           mb <= 0;
           mrn <= 0;
           mlmem <= 0;
           msmem <= 0;
       end else begin
           mwreg <= ewreg;
           mm2reg <= em2reg;
           mwmem <= ewmem;
           malu <= ealu;
           mb <= eb;
           mrn <= ern;
           mlmem <= elmem;
           msmem <= esmem;
       end
endmodule
