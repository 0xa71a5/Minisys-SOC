`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/27 13:22:49
// Design Name: 
// Module Name: sim_segments
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


module sim_segments(
    );
reg clk;
reg reset;
reg [31:0] data;
wire [7:0] digital;
wire [7:0] ens;
integer i;
integer j;

dev_segments seg(clk,reset,data,digital,ens); 
always
begin
clk=0;
reset=1;
data = 32'h00000000;
#5;
reset=0;
#5;
reset=1;

//for(j=0;j<16;j=j+1)

data = 32'h12345678;
for(i=0;i<10;i=i+1)
begin
clk=1;
#5;
clk=0;
#5;
end

data = 32'h90abcdef;
for(i=0;i<10;i=i+1)
begin
clk=1;
#5;
clk=0;
#5;
end

data = 32'h11223344;
for(i=0;i<10;i=i+1)
begin
clk=1;
#5;
clk=0;
#5;
end

data = 32'h55667788;
for(i=0;i<10;i=i+1)
begin
clk=1;
#5;
clk=0;
#5;
end

#200;
end
    
endmodule
