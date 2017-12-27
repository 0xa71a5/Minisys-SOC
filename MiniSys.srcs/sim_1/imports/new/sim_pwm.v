`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/13 19:52:47
// Design Name: 
// Module Name: pwm_sim
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


module sim_pwm(
    );
//input Reset,input [2:0] Address,input Cs,input Clk,input Iow,input [15:0] Wdata,output Pwm    
reg Reset;
reg [2:0] Address;
reg Cs;
reg Clk;
reg Iow;
reg [15:0] Wdata;
wire Pwm;
reg [31:0] counter=0;
    dev_pwm uut1(Reset,Address,Cs,Clk,Iow,Wdata,Pwm);
    
    always
    begin
        Reset = 1;
        Address = 0;
        Cs = 0;
        Clk = 0;
        Iow = 0;
        Wdata = 0;
        #5;
        //开始Reset
        Reset = 0;
        Clk = 0;
        #5;
        //开始写参数
        Reset = 1;
        Cs = 1;
        Iow = 1;
        Address = 0;
        Wdata = 12;//给1号maxval寄存器写最大值12
        Clk = 1;//Clk上升沿写入
        #5;
        Clk = 0;
        #5;

        Address = 2;
        Wdata = 4;//给2号compval寄存器写比较值4
        Clk = 1;//Clk上升沿写入
        #5;
        Clk = 0;
        #5;
        
        Address = 4;
        Wdata = 1;//给0号控制寄存器写使能信号1
        Clk = 1;//Clk上升沿写入
        #5;
        Clk = 0;
        #5;
        
        Cs = 0;
        Iow = 0;
        
        for(counter = 0;counter<1000;counter=counter+1)
        begin
            Clk=1;
            #5;
            Clk=0;
            #5;
        end
        
    
    end
    
    
endmodule
