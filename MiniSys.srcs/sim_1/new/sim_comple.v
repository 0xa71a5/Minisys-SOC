`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/19 21:31:37
// Design Name: 
// Module Name: sim_comple
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


module sim_comple(
    );
    reg [31:0] a0;
        wire [31:0] b;

        complement comp(a0,b);
            
            always 
            begin
                    a0=32'h80000001;

            #500;
            end
endmodule
