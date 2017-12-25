`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/19 10:27:01
// Design Name: 
// Module Name: mux2_1_sim
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


module mux2_1_sim;
    reg [31:0] a1;
    reg [31:0] a2;
    reg s1;
    wire [31:0] t;
    mux2x32 select(.a0(a1),
                   .a1(a2),
                   .s(s1),
                   .y(t));
    initial begin
        a1 = 0;
        a2 = 0;
        s = 0;
    end
endmodule
