`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/20 17:29:33
// Design Name: 
// Module Name: TextPC4
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


module TextPC4(clk,clrn,wpcir,pc,pc4);
    input clk,clrn,wpcir;
    output [31:0] pc;
    output  [31:0] pc4;
    //reg [31:0] pc4;
    pipepc pcreg(pc4,wpcir,clk,clrn,pc);
    cla32 pc_plus4 (pc,32'h4,1'b0,pc4);
endmodule
