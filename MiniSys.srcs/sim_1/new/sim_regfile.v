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
reg [4:0] rna;//a�Ĵ������ź�
reg [4:0] rnb;//b�Ĵ������ź�
reg [4:0] wn;//д�Ĵ�����
reg [31:0] d;//��������
reg we,clk,clrn;//дʹ��  ʱ��  ����
wire [31:0] qa;//���a�Ĵ���
wire [31:0] qb;//���b�Ĵ���
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

//д1�żĴ���
wn=1;
d=32'h12345678;
we=1;
clk=1;
#5;
we=0;
clk=0;
#5;

//д2�żĴ���
wn=2;
d=32'h87654321;
we=1;
clk=1;
#5;
clk=0;
#5;

//��1�ź�2�żĴ���
we=0;
rna=1;
rnb=2;
clk=1;
#5;
clk=0;
#5;

//д1�żĴ���
wn=1;
d=32'h55aabbcc;
we=1;
clk=1;
#5;
we=0;
clk=0;
#5;

//��1�ź�2�żĴ���
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
