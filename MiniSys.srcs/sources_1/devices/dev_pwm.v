`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/13 19:28:55
// Design Name: 
// Module Name: dev_pwm
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


module dev_pwm(
    input Reset,input [2:0] Address,input Cs,input Clk,input Iow,input [15:0] Wdata,output Pwm
);
    reg Pwm=1;//pwm ����ź�
    reg [15:0] ctrl_reg=0;//���ƼĴ���
    reg [15:0] cur_val_reg=16'd0;//��ǰ����ֵ�Ĵ���
    reg [15:0] max_val_reg=16'hffff;//���ֵ�Ĵ���
    reg [15:0] comp_val_reg=16'h7fff;//�Ƚ�ֵ�Ĵ���
    wire power_on;
    
    assign power_on = ctrl_reg[0]; //0��λ��ʾ�Ƿ���
    
    always @(posedge Clk or negedge Reset)//���ƼĴ����Ķ�д
    begin
        if(Reset==0)//reset
            begin
                ctrl_reg=0;
                max_val_reg =16'hffff;
                comp_val_reg=16'h7fff;
            end
        else if(Cs==1'b1)//Ƭѡ
            begin
                if(Iow==1'b1)//д����
                    begin
                        case(Address[2:0])//д��ַ�ж�
                            3'b000: max_val_reg = Wdata;//���ֵ�Ĵ�����ֵ
                            3'b010: comp_val_reg = Wdata;//�Ա�ֵ�Ĵ�����ֵ
                            3'b100: ctrl_reg = Wdata;//ʹ�ܼĴ�����ֵ
                        endcase
                    end
            end
    end
    
    always @(posedge Clk or negedge Reset)
    begin
        if(Reset==1'b0 || power_on==0)
            begin
                Pwm = 1;
                cur_val_reg =0;
            end
        else if(cur_val_reg < comp_val_reg)
            begin
                Pwm = 1;
                cur_val_reg = cur_val_reg + 1;
            end
        else if(cur_val_reg >= comp_val_reg && cur_val_reg < max_val_reg )
            begin
                Pwm = 0;
                cur_val_reg = cur_val_reg + 1;
            end
        else 
            begin 
                Pwm = 1;
                cur_val_reg =0;
            end
        
    end
    



endmodule
