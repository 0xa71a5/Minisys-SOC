`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/20 17:36:37
// Design Name: 
// Module Name: testpc4_sim
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


module testpc4_sim();
    reg clk,clrn,e;
    wire [31:0] pc;
    wire [31:0] pc4;
    TextPC4 test(clk,clrn,e,pc,pc4);
    reg [31:0] i;
    always 
    begin
        clk = 0;
        e = 0;
        clrn=1;
        #5;
        clrn = 0;
        #5;
        clrn=1;
    
        clk=1;
       
        #20;
        
        clk=0;
        #5;
        
        clk=1;
        #5;
        clk=0;
        i=0;
                e=1;
        while(i==32'b0)
       #5 clk = ~clk;

        
    end
endmodule
