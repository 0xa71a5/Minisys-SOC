`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/29 17:05:59
// Design Name: 
// Module Name: pipepc
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


module pipepc(npc,wpc,clk,clrn,pc);
//pc reg
    input [31:0] npc;
    input wpc,clk,clrn;
    output [31:0] pc;
    dffe32 program_counter(npc,clk,clrn,wpc,pc);
endmodule
