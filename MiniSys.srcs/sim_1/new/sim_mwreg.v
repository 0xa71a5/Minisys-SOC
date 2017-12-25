`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/24 16:07:35
// Design Name: 
// Module Name: sim_mwreg
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


module sim_mwreg(

    );

reg [31:0] mmo,malu;
reg [4:0] mrn;
reg mwreg,mm2reg;
reg clk,clrn;
wire [31:0] wmo,walu;
wire [4:0] wrn;
wire wwreg,wm2reg;

pipemwreg uut1(mwreg,mm2reg,mmo,malu,mrn,clk,clrn,
wwreg,wm2reg,wmo,walu,wrn);

always
begin
mmo=32'd0;
malu=32'd0;
mrn=5'd0;
mwreg=1'd0;
mm2reg=1'd0;
clk=0;
clrn=1;
#5;
clrn=0;
#5;
clrn=1;

mmo=32'd7;
malu=32'd8;
mrn=5'd9;
mwreg=1'd1;
mm2reg=1'd1;
clk=1;
#5;
clk=0;
#5;

mmo=32'd8;
malu=32'd9;
mrn=5'd10;
mwreg=1'd0;
mm2reg=1'd0;
clk=1;
#5;
clk=0;
#5;

mmo=32'd3;
malu=32'd4;
mrn=5'd5;
mwreg=1'd1;
mm2reg=1'd0;
clk=1;
#5;
clk=0;
#5;

#500;

end
 
endmodule
