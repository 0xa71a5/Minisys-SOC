`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/31 10:35:32
// Design Name: 
// Module Name: dev_switches
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

module dev_switches(
input Reset,input [2:0] Address,input Cs,input Clk,input Iow , input Ior ,input [15:0] Wdata,output [15:0] Rdata,input [15:0] sw
);
reg [15:0] Rdata;
always @(posedge Clk or negedge Reset) //要考虑时钟边沿因素 我这里暂时没有考虑
    begin
        if(Reset==0)
         begin
            Rdata = 0; 
         end
        else 
            Rdata = sw;
     end
endmodule
