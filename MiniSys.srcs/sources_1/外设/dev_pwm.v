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
    reg Pwm=1;//pwm 输出信号
    reg [15:0] ctrl_reg=0;//控制寄存器
    reg [15:0] cur_val_reg=16'd0;//当前计数值寄存器
    reg [15:0] max_val_reg=16'hffff;//最大值寄存器
    reg [15:0] comp_val_reg=16'h7fff;//比较值寄存器
    wire power_on;
    
    assign power_on = ctrl_reg[0]; //0号位表示是否工作
    
    always @(posedge Clk or negedge Reset)//控制寄存器的读写
    begin
        if(Reset==0)//reset
            begin
                ctrl_reg=0;
                max_val_reg =16'hffff;
                comp_val_reg=16'h7fff;
            end
        else if(Cs==1'b1)//片选
            begin
                if(Iow==1'b1)//写数据
                    begin
                        case(Address[2:0])//写地址判断
                            3'b000: max_val_reg = Wdata;//最大值寄存器赋值
                            3'b010: comp_val_reg = Wdata;//对比值寄存器赋值
                            3'b100: ctrl_reg = Wdata;//使能寄存器赋值
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
