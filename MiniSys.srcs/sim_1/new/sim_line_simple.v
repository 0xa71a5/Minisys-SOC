`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/27 15:31:22
// Design Name: 
// Module Name: sim_line_simple
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


module sim_line_simple();
    //reg pulse0;
    //reg pulse1;
    wire cnt0;
    wire cnt1;
    wire pwm;
    wire [7:0] digital;
    wire [7:0] ens;
    reg [3:0] Line;
    wire [3:0] Col;
    reg [15:0] switches;
    wire [15:0] leds;
    wire beep;
    
        
    reg [31:0] i;
    reg clk,clrn;
    
    pipelinedcpu line0(clk,clrn,cnt0,cnt1,pwm,digital,ens,Line,Col,switches,leds,beep);
        always 
        begin
            //pulse0 = 0;
            //pulse1 = 0;
            Line=0;
            switches=16'h1234;
            
            clk = 0;
            clrn=0;
            #1;
            clrn = 1;
            #1;
            clrn=0;
            #5;
            
            clk=1;
            #5;
            clk=0;
            i=0;
            while(i==32'b0)
           #1 clk = ~clk;
    end
endmodule

