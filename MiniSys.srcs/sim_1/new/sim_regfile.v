`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/21 16:25:43
// Design Name: 
// Module Name: sim_regfile
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


module sim_regfile(
    );
reg [4:0] rna;//a¼Ä´æÆ÷Òý½ÅºÅ
reg [4:0] rnb;//b¼Ä´æÆ÷Òý½ÅºÅ
reg [4:0] wn;//Ð´¼Ä´æÆ÷ºÅ
reg [31:0] d;//ÊäÈëÊý¾Ý
reg we,clk,clrn;//Ð´Ê¹ÄÜ  Ê±ÖÓ  ÖØÖÃ
wire [31:0] qa;//Êä³öa¼Ä´æÆ÷
wire [31:0] qb;//Êä³öb¼Ä´æÆ÷
regfile uut_regfile(rna,rnb,d,wn,we,clk,clrn,qa,qb);
always
begin
rna=5'd0;
rnb=5'd0;
wn=5'd1;
d=32'h12345678;
we=0;
clk=0;
clrn=1;
#5;
clrn=0;
#5;
clrn=1;
#5;

//Ð´1ºÅ¼Ä´æÆ÷
wn=1;
d=32'h12345678;
we=1;
clk=1;
#5;
we=0;
clk=0;
#5;

//Ð´2ºÅ¼Ä´æÆ÷
wn=2;
d=32'h87654321;
we=1;
clk=1;
#5;
clk=0;
#5;

//¶Á1ºÅºÍ2ºÅ¼Ä´æÆ÷
we=0;
rna=1;
rnb=2;
clk=1;
#5;
clk=0;
#5;

//Ð´1ºÅ¼Ä´æÆ÷
wn=1;
d=32'h55aabbcc;
we=1;
clk=1;
#5;
we=0;
clk=0;
#5;

//¶Á1ºÅºÍ2ºÅ¼Ä´æÆ÷
we=0;
rna=1;
rnb=2;
clk=1;
#5;
clk=0;
#5;

#200;

end
    
endmodule
