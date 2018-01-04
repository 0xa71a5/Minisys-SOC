`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/01/03 17:14:38
// Design Name: 
// Module Name: dev_leds
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

module dev_leds(
    input Reset,input [2:0] Address,input Cs,input Clk,input Iow,input [15:0] Wdata,output [15:0] leds
    );
    reg [15:0] leds=0;

    always @(posedge Clk or negedge Reset)//控制寄存器的读写
    begin
        if(Reset==0)//reset
            begin
                leds = 0;
            end
        else if(Cs==1'b1)//片选
            begin
                if(Iow==1'b1)//写数据
                    begin
                        case(Address[2:0])//写地址判断
                            3'b000: leds = Wdata;//最大值寄存器赋值
                            default:leds = leds;
                        endcase
                    end
            end
    end
endmodule
