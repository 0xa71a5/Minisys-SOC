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
    wire cnt0;
    wire cnt1;
    wire pwm;
    wire [7:0] digital;
    wire [7:0] ens;
    reg [15:0] switches;
    wire [15:0] leds;
    wire beep;
    reg [3:0] Line;
    wire [3:0] Col;
    reg [31:0] i;
    
    reg clk,clr;
    wire [31:0] pc,inst,ealu,malu,walu;
    wire [31:0] da,db,dimm;
    
    wire [2:0] dlmem;
    wire [1:0] msmem;
    wire [3:0] wea;
    wire dwmem,ewmem,mwmem;
    wire [1:0] esmem;
    wire [31:0] wdi;
    wire [31:0] mb;
    wire [4:0] wrn;
    wire [1:0] compare;
    
    wire cpdone;
    wire clock;
    
    
    pipelinedcpu lline(clk,clr,pc,inst,ealu,malu,walu,
    cnt0,cnt1,pwm,digital,ens,switches,Line,Col,leds,beep,
    da,db,dimm,pc4,dlmem,msmem,wea,dwmem,ewmem,mwmem,esmem,wdi,mb,wrn,compare,cpdone,clock//for test
    );
    always 
        begin
            switches = 16'h0123;
            Line = 4'b1011;
            clk = 0;
            clr=0;
            #1;
            clr = 1;
            #1;
            clr=0;
            #5;
            
            clk=1;
            #5;
            clk=0;
            i=0;
            while(i==32'b0)
           #5 clk = ~clk;
    end
endmodule
