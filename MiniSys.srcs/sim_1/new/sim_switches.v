`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/31 16:12:46
// Design Name: 
// Module Name: sim_switches
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


module sim_switches(

    );
reg Reset;
reg [2:0] Address;
reg Cs;
reg Clk;
reg Ior;
wire [15:0] Rdata;
reg [15:0] sw;
wire cstest;
wire iortest;
wire [15:0] Rdata2;

dev_switches uut(Reset, Address, Cs, Clk ,Ior , Rdata, sw, cstest, iortest, Rdata2);

always begin
Reset=1;
Address=0;
Cs=0;
Ior=0;
sw=16'h1234;
Clk=0;
#5;
Reset=0;
#5;
Reset=1;
#5;


Clk=1;
Address=0;
Cs=1;Ior=1;
sw=16'h1234;
#5;
Clk=0;
#5;

Clk=1;
Address=4;
Cs=1;Ior=1;
sw=16'h1234;
#5;
Clk=0;
#5;
#500;

end
    
    
    
endmodule
