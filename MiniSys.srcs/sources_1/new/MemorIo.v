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
we,smem,lmem,addr,datain,clk,dataout,reset,//ע�������ԭ���ڴ���ȼ���reset
pulse0,pulse1,cnt0,cnt1,pwm, //������������gpio��    
    wea,digital,ens//debug
    );
    
    
    input we;
    input [1:0] smem;
    input [2:0] lmem;
    input [31:0] addr;
    input [31:0] datain;
    input clk;
    input reset;
    output [31:0] dataout;
    output [7:0] digital;
    output [7:0] ens;
    //����������������GPIO
    input pulse0;
    input pulse1;
    output cnt0;
    output cnt1;
    output pwm;
    
    output [3:0] wea;//debug
    
    wire addr_use_dev;
    wire addr_use_mem;
    assign addr_use_dev = addr[31:10]==22'h3fffff;//��22λȫ��Ϊ1��ʱ��ʹ������
    assign addr_use_mem = ~addr_use_dev;
    
    wire mem_we;//�ڴ�д�ź���
    wire dev_we;//����д�ź���
    assign mem_we = we & addr_use_mem;
    assign dev_we = we & addr_use_dev;
    
    wire [31:0] mem_dataout;//�ڴ����������
    pipemem memory0(mem_we,smem,lmem,addr,datain,clk,mem_dataout,wea);
    
    wire [31:0] dev_dataout;
    pipedevices devices(dev_we,addr,datain,clk,reset,dev_dataout,addr_use_dev,
    pulse0,pulse1,cnt0,cnt1,pwm,digital,ens//������
    );
    
    assign dataout = addr_use_mem ? mem_dataout : dev_dataout;//�������ѡ��
    
endmodule
