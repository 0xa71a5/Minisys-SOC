`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/29 16:23:30
// Design Name: 
// Module Name: dffe32
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


module dffe32(d,clk,clrn,e,q);
//32 reg
    input [31:0] d;
    input clk,clrn,e;
    output [31:0] q;
    reg [31:0] q;
    always @(negedge clrn or posedge clk)
        if (clrn == 0)begin
            q <= 0;
        end else begin
            if (e) q <= d;
        end
endmodule
