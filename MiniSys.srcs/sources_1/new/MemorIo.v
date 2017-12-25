`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/21 20:24:30
// Design Name: 
// Module Name: MemorIo
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


module MemorIo(
we,smem,lmem,addr,datain,clk,dataout,reset,//注意这里和原来内存相比加了reset
pulse0,pulse1,cnt0,cnt1,pwm, //外设的输入输出gpio线    
    wea//debug
    );
    
    
    input we;
    input [1:0] smem;
    input [2:0] lmem;
    input [31:0] addr;
    input [31:0] datain;
    input clk;
    input reset;
    output [31:0] dataout;
    
    //定义外设的输入输出GPIO
    input pulse0;
    input pulse1;
    output cnt0;
    output cnt1;
    output pwm;
    
    output [3:0] wea;//debug
    
    wire addr_use_dev;
    wire addr_use_mem;
    assign addr_use_dev = addr[31:10]==22'h3fffff;//高22位全部为1的时候使用外设
    assign addr_use_mem = ~addr_use_dev;
    
    wire mem_we;//内存写信号线
    wire dev_we;//外设写信号线
    assign mem_we = we & addr_use_mem;
    assign dev_we = we & addr_use_dev;
    
    wire [31:0] mem_dataout;//内存数据输出线
    pipemem memory0(mem_we,smem,lmem,addr,datain,clk,mem_dataout,wea);
    
    wire [31:0] dev_dataout;
    pipedevices devices(dev_we,addr,datain,clk,reset,dev_dataout,addr_use_dev,
    pulse0,pulse1,cnt0,cnt1,pwm//外设线
    );
    
    assign dataout = addr_use_mem ? mem_dataout : dev_dataout;//数据输出选择
    
endmodule
