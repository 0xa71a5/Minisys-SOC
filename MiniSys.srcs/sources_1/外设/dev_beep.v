`timescale 1ns / 1ps


module dev_beep(
    input Reset,input [2:0] Address,input Cs,input Clk,input Iow,input [15:0] Wdata,output beep
    );

    reg poweron=0;
    reg [15:0] frequence=0;
    wire beepClock;
    wire [31:0] inputFrequence;
    assign  inputFrequence = {15'b0, frequence } ;

    clockDiv beepUsedClock(Clk,beepClock,Reset,inputFrequence);

    assign  beep = poweron&beepClock ;

    always @(posedge Clk or negedge Reset)//控制寄存器的读写
    begin
        if(Reset==0)//reset
            begin
                poweron = 0;
            end
        else if(Cs==1'b1)//片选
            begin
                if(Iow==1'b1)//写数据
                    begin
                        case(Address[2:0])//写地址判断
                            3'b000: poweron = Wdata[0];//是否工作寄存器
                            3'b010: frequence = Wdata;//频率寄存器
                            default:poweron = 0;
                        endcase
                    end
            end
    end


endmodule