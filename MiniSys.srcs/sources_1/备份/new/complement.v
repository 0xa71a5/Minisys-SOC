`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/19 19:58:45
// Design Name: 
// Module Name: complement
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


module complement(a0,b);
    input [31:0] a0;
    output [31:0] b;
    wire [31:0] t;
    wire [31:0] a1;
    assign t = ~{{1'b0},a0[30:0]};
    cla32 br_addr (t,32'h1,1'b0,a1);
    assign b = a0[31]?a1:a0;
endmodule 
