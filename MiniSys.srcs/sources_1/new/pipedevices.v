`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/21 19:19:51
// Design Name: 
// Module Name: pipedevices
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


module pipedevices(
input we,input [31:0] address,input [31:0] datain,input clk,input reset,output [31:0] dataout,input enable,
input pulse0,input pulse1,output cnt0,output cnt1,output pwm//外设线
    );
   
    
    wire we;
    wire [31:0] address;
    wire [31:0] datain;
    wire clk;
    wire reset;
    wire pwm;
    reg [31:0] dataout;
    
    wire cs_timer;
    wire Iow_timer;
    assign Iow_timer = we;
    wire Ior_timer;
    assign Ior_timer = ~we;
    wire [31:0] dataout_timer;
    assign dataout_timer[31:16] = 0;
    
    wire cs_pwm;
    wire Iow_pwm;
    wire [31:0] dataout_pwm;
    assign Iow_pwm = we;
    assign dataout_pwm = 0;
    
    reg [15:0] cs_bus;//考虑reg可能存在延迟问题
    assign cs_pwm = enable&cs_bus[3];
    assign cs_timer = enable&cs_bus[2];
    //4-16译码器
    always @(address[7:4] or reset)
    begin
        if(reset==0)
            begin
                cs_bus<=0;
            end
        else
            begin
                case(address[7:4])
                    4'd0:begin cs_bus<=16'b0000_0000_0000_0001;dataout<=32'd0; end
                    4'd1:begin cs_bus<=16'b0000_0000_0000_0010;dataout<=32'd0; end
                    4'd2:begin cs_bus<=16'b0000_0000_0000_0100;dataout<=dataout_timer; end
                    4'd3:begin cs_bus<=16'b0000_0000_0000_1000;dataout<=dataout_pwm  ; end
                    4'd4:begin cs_bus<=16'b0000_0000_0001_0000;dataout<=32'd0; end
                    4'd5:begin cs_bus<=16'b0000_0000_0010_0000;dataout<=32'd0; end
                    4'd6:begin cs_bus<=16'b0000_0000_0100_0000;dataout<=32'd0; end
                    4'd7:begin cs_bus<=16'b0000_0000_1000_0000;dataout<=32'd0; end
                    4'd8:begin cs_bus<=16'b0000_0001_0000_0000;dataout<=32'd0; end
                    4'd9:begin cs_bus<=16'b0000_0010_0000_0000;dataout<=32'd0; end
                   4'd10:begin cs_bus<=16'b0000_0100_0000_0000;dataout<=32'd0; end
                   4'd11:begin cs_bus<=16'b0000_1000_0000_0000;dataout<=32'd0; end
                   4'd12:begin cs_bus<=16'b0001_0000_0000_0000;dataout<=32'd0; end
                   4'd13:begin cs_bus<=16'b0010_0000_0000_0000;dataout<=32'd0; end
                   4'd14:begin cs_bus<=16'b0100_0000_0000_0000;dataout<=32'd0; end
                   4'd15:begin cs_bus<=16'b1000_0000_0000_0000;dataout<=32'd0; end
                endcase
            end
    end
    
    
    //input Reset,input [2:0] Address,input Cs,input Clk,input Iow,input Ior ,input [15:0] Wdata, output [15:0] Rdata,input Pulse0 ,input Pulse1,output Cout0,output Cout1
    dev_timer timer01(reset,address[2:0],cs_timer,clk,Iow_timer,Ior_timer,datain[15:0],dataout_timer[15:0],pulse0,pulse1,cnt0,cnt1);
    
    
    
    //input Reset,input [2:0] Address,input Cs,input Clk,input Iow,input [15:0] Wdata,output Pwm    
    dev_pwm pwm0(reset,address[2:0],cs_pwm,clk,Iow_pwm,datain[15:0],pwm);
    
    
endmodule
