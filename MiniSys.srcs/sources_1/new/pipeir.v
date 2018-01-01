`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/29 17:03:16
// Design Name: 
// Module Name: pipeir
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


module pipeir(pc4,ins,wir,clk,clrn,dpc4,inst,pcsource);
//ir reg and pc+4
    input [31:0] pc4,ins;
    input wir,clk,clrn;
    input [1:0] pcsource;
    output [31:0] dpc4,inst;
    reg clean = 1'b0;
    always @(negedge clrn or posedge clk)begin
    if(clrn==0)
        clean=1'b0;
    else
      begin
        if(pcsource != 0)
            clean = 1'b1;
        else
            clean = 1'b0;
      end
    end
    dffe32 pc_plus4 (pc4,clk,clrn,wir,dpc4,clean);
    dffe32 instruction (ins,clk,clrn,wir,inst,clean);
endmodule
