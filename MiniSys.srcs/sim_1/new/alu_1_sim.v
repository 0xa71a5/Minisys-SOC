`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/19 16:28:42
// Design Name: 
// Module Name: alu_1_sim
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


module alu_1_sim(
    );
    reg [31:0] a,b;
    reg [3:0] aluc;
    wire [31:0] r;
    wire z;
    alu alutest(a,b,aluc,r,z);
    
    always 
    begin
            a=32'h00000002;
            b=32'h00000003;
            aluc = 4'b0011;
            #500;
            
        end
endmodule
