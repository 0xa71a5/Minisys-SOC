`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/18 22:04:00
// Design Name: 
// Module Name: dev_segment
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


module dev_segment(
input Reset,input [2:0] Address,input Cs,input Clk,input Iow,input [15:0] Wdata,output [7:0] Seg,output [7:0] Sel
    );
    
reg [7:0] Seg;
reg [7:0] Sel;//�����ʹ��λ

reg [15:0] low4_data_reg;//����λ��������ݼĴ���
reg [15:0] high4_data_reg;//����λ��������ݼĴ���
reg [15:0] display_ctrl_reg;//�������ʾ���ƼĴ���

always @(posedge Clk or negedge Reset)//���ƼĴ�����д��
begin
    if(Reset==0)//reset
        begin
            low4_data_reg[15:0] = 16'd0;
            high4_data_reg[15:0] = 16'd0;
            display_ctrl_reg[15:0] = 16'd0;
        end
    else if(Cs==1'b1 && Iow==1'b1)//Ƭѡ д��
        begin
            case(Address[2:0])//д��ַ�ж�
                3'b000: low4_data_reg[15:0] = Wdata[15:0];//����λ��������ݼĴ�����ֵ
                3'b010: high4_data_reg[15:0] = Wdata[15:0];//����λ��������ݼĴ�����ֵ
                3'b100: display_ctrl_reg[15:0] = Wdata[15:0];//���ƼĴ�����ֵ
            endcase
        end
end

reg [7:0] state;
always @(posedge Clk or negedge Reset)
begin
    if(Reset==0)//reset
        begin
            Seg[7:0] = 8'd0;
            Sel[7:0] = 8'd0;
            state = 0;
        end
    else
        begin
            case(state)
            8'd0:begin
                
            end

            endcase
        end
end



endmodule
