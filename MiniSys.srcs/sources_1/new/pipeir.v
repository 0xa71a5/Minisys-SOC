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


module pipeir(pc4,ins,wir,clk,clrn,dpc4,inst);
//ir reg and pc+4
    input [31:0] pc4,ins;
    input wir,clk,clrn;
    output [31:0] dpc4,inst;
    dffe32 pc_plus4 (pc4,clk,clrn,wir,dpc4);
    dffe32 instruction (ins,clk,clrn,wir,inst);
endmodule
