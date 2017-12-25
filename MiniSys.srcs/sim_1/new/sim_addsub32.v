`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/19 16:42:40
// Design Name: 
// Module Name: sim_addsub32
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


module sim_addsub32(
    );
    reg [31:0] a,b;
    reg sub;
    wire [31:0] s;
    wire co,ofl,sign;
    addsub32 addsub(a,b,sub,s,co,ofl,sign);
        
        always 
        begin
                a=32'ha0000011;
                b=32'h00000011;
                sub = 1'b1;
        #500;
        end
endmodule
