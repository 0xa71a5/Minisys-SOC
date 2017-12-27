`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/27 14:00:10
// Design Name: 
// Module Name: sim_seg
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


module sim_seg(

    );
    reg Reset;
    reg [2:0] Address;
    reg Cs;
    reg Clk;
    reg Iow;
    reg [15:0] Wdata;
    wire [7:0] digital;
    wire [7:0] ens;
    
    
    dev_segment uut1(Reset,Address,Cs,Clk,Iow,Wdata,digital,ens);
    integer i;
    
always
begin
i=0;
Reset = 1;
Address = 0;
Cs = 0;
Clk = 0;
Iow = 0;
Wdata = 0;
#5;
//开始Reset
Reset = 0;;
#5;
Reset=1;
#5;

Cs = 1;
Iow = 1;
Address = 0;//低四位数码管
Wdata = 16'h4321;
Clk = 1;//Clk上升沿写入
#5;
Clk = 0;
#5;

Cs = 1;
Iow = 1;
Address = 2;//高四位数码管
Wdata = 16'h8765;
Clk = 1;//Clk上升沿写入
#5;
Clk = 0;
#5;

Cs = 1;
Iow = 1;
Address = 4;//控制寄存器
Wdata = 16'h9900;
Clk = 1;//Clk上升沿写入
#5;
Clk = 0;
#5;

i=0;
while(i==0)
begin
    Clk=1;
    #5;
    Clk=0;
    #5;
end


end
    
    
    
endmodule
