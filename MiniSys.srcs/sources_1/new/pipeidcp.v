`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/09 13:34:31
// Design Name: 
// Module Name: pipeidcp
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


module pipeidcp(a0,s,y);
    input [31:0] a0;
    input [1:0] s;
    output  y;
    wire z0,z1;
    assign z0 = ~|a0;//a0=0
    assign z1 = ~a0[31];//a0>=0
    assign y = s[1]?(s[0]?(~z1&~z0):(~z1|z0)):(s[0]?(z1&~z0):(z0|z1));

endmodule
