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
input pulse0,input pulse1,output cnt0,output cnt1,output pwm,output [7:0] digital,output [7:0] ens,input segment_clock,input keyboard_clock,input [3:0] Line,output [3:0] Col,input [15:0] switches//外设线
);
//debug


//end debug   
    
wire we;
wire [31:0] address;



wire [31:0] datain;
wire clk;
wire reset;
wire pwm;
reg [31:0] dataout;
reg [15:0] cs_bus;//考虑reg可能存在延迟问题

//assign cnt0 = Ior_switches;
//assign cnt1 = cs_switches;

//definitions for timer
wire cs_timer;
wire Iow_timer;
assign Iow_timer = we;
wire Ior_timer;
assign Ior_timer = ~we;
wire [31:0] dataout_timer;
assign dataout_timer[31:16] = 0;
assign cs_timer = enable&cs_bus[2];
    
//definitions for pwm
wire cs_pwm;
wire Iow_pwm;
wire [31:0] dataout_pwm;
assign Iow_pwm = we;
assign dataout_pwm = 0;
assign cs_pwm = enable&cs_bus[3];
    
//definitions for segment
wire cs_seg;
wire Iow_seg;
wire [31:0] dataout_seg;
assign Iow_seg = we;
assign dataout_seg = 0;
assign cs_seg  = enable&cs_bus[0];
    
//definitions for keyboard
wire cs_keyboard;
wire Iow_keyboard;
wire [31:0] dataout_keyboard;
wire Ior_keyboard;
assign Iow_keyboard = we;
assign Ior_keyboard = ~we;
assign dataout_keyboard[31:16]=0;
assign cs_keyboard = enable&cs_bus[1];
    
//definitions for switches
wire cs_switches;
wire [31:0] dataout_switches;
wire Ior_switches;
wire Iow_switches;
assign Iow_switches = we;
assign Ior_switches = ~we;
assign dataout_switches[31:16] = 0;
assign cs_switches = enable&cs_bus[7];    
    
//4-16译码器
always @(address[7:0] or reset)
begin
if(reset==0)
begin
cs_bus<=0;
end
else
begin
case(address[7:4])
4'd0:begin cs_bus<=16'b0000_0000_0000_0001;dataout<=32'd0; end
4'd1:begin cs_bus<=16'b0000_0000_0000_0010;dataout<=dataout_keyboard; end
4'd2:begin cs_bus<=16'b0000_0000_0000_0100;dataout<=dataout_timer; end
4'd3:begin cs_bus<=16'b0000_0000_0000_1000;dataout<=dataout_pwm  ; end
4'd4:begin cs_bus<=16'b0000_0000_0001_0000;dataout<=32'd0; end
4'd5:begin cs_bus<=16'b0000_0000_0010_0000;dataout<=32'd0; end
4'd6:begin cs_bus<=16'b0000_0000_0100_0000;dataout<=32'd0; end
4'd7:begin cs_bus<=16'b0000_0000_1000_0000;dataout<=dataout_switches; end
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


dev_timer timer01(reset,address[2:0],cs_timer,clk,Iow_timer,Ior_timer,datain[15:0],dataout_timer[15:0],pulse0,pulse1,cnt0,cnt1); 
dev_pwm pwm0(reset,address[2:0],cs_pwm,clk,Iow_pwm,datain[15:0],pwm);
dev_segment seg0(reset,address[2:0],cs_seg,clk,Iow_seg,datain[15:0],digital,ens,segment_clock);
dev_keyboard keyboard0(reset,address[1:0],cs_keyboard,clk,Ior_keyboard,dataout_keyboard[15:0],keyboard_clock,Line,Col);
dev_switches switches0(reset,address[2:0],cs_switches,clk,Iow_switches,Ior_switches,datain[15:0],dataout_switches[15:0],switches);//Error
    
endmodule