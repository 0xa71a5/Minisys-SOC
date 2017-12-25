`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/10 20:28:01
// Design Name: 
// Module Name: mux8x32
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


module mux8x32(a0,a1,a2,a3,a4,a5,a6,a7,s,t);
    input [31:0] a0,a1,a2,a3,a4,a5,a6,a7;
    input [2:0] s;
    output [31:0] t;
    assign t =
    s[2]?(s[1]?(s[0]?a7:a6):(s[0]?a5:a4)):(s[1]?(s[0]?a3:a2):(s[0]?a1:a0));
    /*
    function [31:0] select;
        input [31:0] a0,a1,a2,a3,a4,a5,a6,a7;
        input [2:0] s;
                case (s)
                    3'b000:select = a0;
                    3'b001:select = a1;
                    3'b010:select = a2;
                    3'b011:select = a3;
                    3'b100:select = a4;
                    3'b101:select = a5;
                    3'b110:select = a6;
                    3'b111:select = a7;
                endcase
            endfunction
     assign y = select(a0,a1,a2,a3,a4,a5,a6,a7,s);
   */
endmodule
