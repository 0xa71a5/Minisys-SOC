`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/20 19:21:14
// Design Name: 
// Module Name: pc_sim
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


module pc_sim(

    );
    reg clk;
    reg reset;
    reg enable;
    wire [31:0] pc;
    wire [31:0] pc_plus_4;
    wire [31:0] ins;
    
    TextPC4 uut1(clk,reset,enable,pc,pc_plus_4,ins);
    reg useless;
    always
    begin
        clk=0;
        useless=0;
        reset=1;
        enable=1;
        #5;
        reset=0;
        #5;
        reset=1;
        #5;
        
        while(useless==1'b0)
        begin
        clk=1;
        #5;
        clk=0;
        #5;
        end
    end
    
    
endmodule
