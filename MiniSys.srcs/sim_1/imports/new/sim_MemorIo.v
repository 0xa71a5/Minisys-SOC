`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/21 21:54:38
// Design Name: 
// Module Name: sim_MemorIo
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


module sim_MemorIo(

    );
reg we;
reg [1:0] smem;
reg [2:0] lmem;
reg [31:0] addr;
reg [31:0] datain;
reg clk;
reg reset;
wire [31:0] dataout;

reg pulse0;
reg pulse1;
wire cnt0;
wire cnt1;
wire pwm;


MemorIo uut1(we,smem,lmem,addr,datain,clk,dataout,reset,
            pulse0,pulse1,cnt0,cnt1,pwm
            );   
reg [31:0] i;
    always 
begin//上升沿之前要准备好数据和控制线
    i=0;
    clk=0;
    we=0;
    smem=2'b00;
    lmem=3'b000;
    addr=32'hfffffc30;//pwm 地址是0xFFFFFC30
    datain=32'h12345678;
    pulse0=0;
    pulse1=0;
    reset=1;
    #5;
    reset=0;
    #5;
    reset=1;
    #5;
    
    //write addr 0 data
    clk=0;  
    we=1;
    addr=32'hfffffc30;
    datain=32'd12;//写最大值12
    #5;
    clk=1;
    #5;
    
    
    clk=0;
    we=1;
    addr=32'hfffffc32;
    datain=32'd4;//写比较寄存器位4
    #5;
    clk=1;
    #5;
    
    clk=0;
    we=1;
    addr=32'hfffffc34;
    datain=32'd1;//写使能寄存器
    #5;
    clk=1;
    #5;
    
    //下面开始写定时器
    clk=0;
    we=1;
    addr=32'hfffffc20;
    datain=32'd2;//定时器0 方式寄存器 循环定时
    #5;
    clk=1;
    #5;
    
    clk=0;
    we=1;
    addr=32'hfffffc24;
    datain=32'd5;//定时器0 初值寄存器 初值为5
    #5;
    clk=1;
    #5;
    
    //read addr 0 data 
    clk=0;
    we=0;
    addr=32'h0;
    #5;
    clk=1;
    #5;
    
    
    
    for(i=0;i<100*4;i=i+4)
    begin
        addr=i;
        clk = 0;
        #5;
        clk = 1;
        #5;
    end
    
    #500;
    
    end
    
endmodule


/*
begin//上升沿之前要准备好数据和控制线
    i=0;
    clk=0;
    we=0;
    smem=2'b00;
    lmem=3'b000;
    addr=32'hfffffc30;//pwm 地址是0xFFFFFC30
    datain=32'h12345678;
    pulse0=0;
    pulse1=0;
    reset=1;
    #5;
    reset=0;
    #5;
    reset=1;
    #5;
    
    //write addr 0 data
    clk=0;  
    we=1;
    addr=32'hfffffc30;
    datain=32'd12;//写最大值12
    #5;
    clk=1;
    #5;
    
    
    clk=0;
    we=1;
    addr=32'hfffffc32;
    datain=32'd4;//写比较寄存器位4
    #5;
    clk=1;
    #5;
    
    clk=0;
    we=1;
    addr=32'hfffffc34;
    datain=32'd1;//写使能寄存器
    #5;
    clk=1;
    #5;
    
    //read addr 0 data 
    clk=0;
    we=0;
    addr=32'h0;
    #5;
    clk=1;
    #5;
    
    for(i=0;i<100*4;i=i+4)
    begin
        addr=i;
        clk = 0;
        #5;
        clk = 1;
        #5;
    end
    
    #500;
    end
*/