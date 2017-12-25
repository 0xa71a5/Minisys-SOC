`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/08 15:36:19
// Design Name: 
// Module Name: addsub32
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


module addsub32(a,b,sub,s,co,ofl,sign);
    input [31:0] a,b;
    input sub;
    output [31:0] s;
    output co,ofl,sign;
    reg ofl = 1'b0;
    assign sign = s[31];
    always @(a or b or sub)begin
        if(a[31] == b[31])begin
            if(s[31] != a[31])begin
                ofl = 1'b1;
            end
        end
    end
    cla32 as32 (a,b^{32{sub}},sub,s,co);
endmodule
