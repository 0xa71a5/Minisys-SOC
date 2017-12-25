`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/15 13:56:55
// Design Name: 
// Module Name: timer_sim
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


module timer_sim(
    );
//input Reset,input [2:0] Address,input Cs,input Clk,input Iow,input Ior ,input [15:0] Wdata, output [15:0] Rdata,
//input Pulse0 ,input Pulse1,output Cout0,output Cout1 
//Debug wires:output [15:0] state_reg0,output [15:0] function_reg0,output [15:0] cur_value_reg0,output [15:0] cur_cnt_value_reg0   ,output run_one_period0,output refresh_reg0
    //input -> reg ; output->wire
    reg Reset;
    reg [2:0] Address;
    reg Cs;
    reg Clk;
    reg Iow;
    reg Ior;
    reg [15:0] Wdata;
    wire [15:0] Rdata;
    reg Pulse0;
    reg Pulse1;
    wire Cout0;
    wire Cout1;  
    //Below are debug wires
    wire [15:0] state_reg0; wire [15:0] function_reg0; wire [15:0] cur_value_reg0; wire [15:0] cur_cnt_value_reg0;
    wire run_one_period0;wire refresh_reg0;
    
    dev_timer uut_timer(Reset,Address,Cs,Clk,Iow,Ior,Wdata,Rdata,Pulse0,Pulse1,Cout0,Cout1/*,state_reg0,function_reg0,cur_value_reg0,cur_cnt_value_reg0,run_one_period0,refresh_reg0*/);
    reg [31:0] counter;
   
   //�����ǲ��Լ����Ĵ���
   always
        begin
            Reset = 1; Address[2:0]=0; Cs=0; Clk=0; Iow=0; Ior=0; Wdata[15:0]=0; Pulse0=0; Pulse1=0; counter=0;
            #5;
            Reset = 0;//����
            #5;
            Reset = 1;
            Address[2:0]=3'd0;//��ʽ�Ĵ���0
            Cs=1;Iow=1;Ior=0;
            Wdata[15:0]=16'h0001;//д��ѭ�� ����
            Clk=1;
            #5;
            Cs=0;Iow=0;Ior=0;
            Clk=0;
            #5;
    
            Address[2:0]=3'd4;//��ֵ�Ĵ���0
            Cs=1;Iow=1;Ior=0;
            Wdata[15:0]=16'd5;//д��6����ֵ�Ĵ���0
            Clk=1;
            #5;
            Clk=0;
            #5;
            Cs=0;Iow=0;Ior=0;
            
            for(counter=0;counter<29;counter=counter+1)
            begin
                Pulse0=1;
                Clk=1;
                #5;
                Pulse0=0;
                Clk=0;
                #5;
                if(counter==15)
                    begin//���Զ�״̬�Ĵ���
                           Address[2:0]=3'd0;//״̬�Ĵ���0
                           Cs=1;Iow=0;Ior=1;
                           Clk=1;
                           #5;
                           Clk=0;
                           #5;
                           Cs=0;Iow=0;Ior=0;
                    end
            end
    end
   
   
   
   
   
   /* 
   //�����ǲ��Զ�ʱ�Ĵ���
    always
    begin
        Reset = 1; Address[2:0]=0; Cs=0; Clk=0; Iow=0; Ior=0; Wdata[15:0]=0; Pulse0=0; Pulse1=0; counter=0;
        #5;
        Reset = 0;//����
        #5;
        Reset = 1;
        Address[2:0]=3'd0;//��ʽ�Ĵ���0
        Cs=1;Iow=1;Ior=0;
        Wdata[15:0]=16'h0000;//д��ѭ�� ��ʱ
        Clk=1;
        #5;
        Cs=0;Iow=0;Ior=0;
        Clk=0;
        #5;

        Address[2:0]=3'd4;//��ֵ�Ĵ���0
        Cs=1;Iow=1;Ior=0;
        Wdata[15:0]=16'd7;//д��6����ֵ�Ĵ���0
        Clk=1;
        #5;
        Clk=0;
        #5;
        Cs=0;Iow=0;Ior=0;
        
        for(counter=0;counter<29;counter=counter+1)
        begin
            Clk=1;
            #5;
            Clk=0;
            #5;
            if(counter==4 || counter==15)
            begin//���Զ�״̬�Ĵ���
                   Address[2:0]=3'd0;//״̬�Ĵ���0
                   Cs=1;Iow=0;Ior=1;
                   Clk=1;
                   #5;
                   Clk=0;
                   #5;
                   Cs=0;Iow=0;Ior=0;
            end
        end

       
        for(counter=0;counter<100;counter=counter+1)
        begin
            Clk=1;
            #5;
            Clk=0;
            #5;
        end
    end
    */
    
endmodule
