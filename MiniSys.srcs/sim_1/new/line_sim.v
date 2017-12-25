`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/23 19:22:25
// Design Name: 
// Module Name: line_sim
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


module line_sim();
    reg pulse0;
    reg pulse1;
    wire cnt0;
    wire cnt1;
    wire pwm;
    reg [31:0] i;
    
    reg clk,clrn;
    wire [31:0] pc,inst,ealu,malu,walu;
    wire [31:0] da,db,dimm;
    
    wire [2:0] dlmem;
    wire [1:0] dsmem;
    wire [3:0] wea;
    
    pipelinedcpu lline(clk,clrn,pc,inst,ealu,malu,walu,
    pulse0,pulse1,cnt0,cnt1,pwm,
    da,db,dimm,pc4,dlmem,dsmem,wea//for test
    );
    always 
        begin
            pulse0 = 0;
            pulse1 = 0;
            clk = 0;
            clrn=1;
            #1;
            clrn = 0;
            #1;
            clrn=1;
            #5;
            
            clk=1;
            #5;
            clk=0;
            i=0;
            while(i==32'b0)
           #5 clk = ~clk;
    end
endmodule
