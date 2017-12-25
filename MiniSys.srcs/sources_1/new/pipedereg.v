`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/01 20:17:11
// Design Name: 
// Module Name: pipedereg
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


module pipedereg(dwreg,dm2reg,dwmem,daluc,daluimm,da,db,dimm,drn,
dshift,djal,djalr,dlmem,dsmem,dpc4,clk,clrn,ewreg,em2reg,ewmem,
ealuc,ealuimm,ea,eb,eimm,ern,eshift,ejal,ejalr,elmem,esmem,epc4);
    input [31:0] da,db,dimm,dpc4;
    input [4:0] drn;
    input [3:0] daluc;
    input dwreg,dm2reg,dwmem,daluimm,dshift,djal;
    input djalr;
    //for memory
    input [2:0] dlmem;
    input [1:0] dsmem;
    
    input clk,clrn;
    output [31:0] ea,eb,eimm,epc4;
    output [4:0] ern;
    output [3:0] ealuc;
    output ewreg,em2reg,ewmem,ealuimm,eshift,ejal;
    output ejalr;
    //for memory
    output [2:0] elmem;
    output [1:0] esmem;
    reg [31:0] ea,eb,eimm,epc4;
    reg [4:0] ern;
    reg [3:0] ealuc;
    reg ewreg,em2reg,ewmem,ealuimm,eshift,ejal,ejalr;
    reg [2:0] elmem;
    reg [1:0] esmem;
    always @(negedge clrn or posedge clk)
        if (clrn == 0) begin
            ewreg <= 0;            em2reg <= 0;
            ewmem <= 0;            ealuc <= 0;
            ealuimm <= 0;            ea <= 0;
            eb <= 0;            eimm <= 0;
            ern <= 0;            eshift <= 0;
            ejal <= 0;            epc4 <= 0;
            ejalr <=0;
            elmem <= 0;           esmem <= 0;
        end else begin
            ewreg <= dwreg;            em2reg <= dm2reg;
            ewmem <= dwmem;            ealuc <= daluc;
            ealuimm <= daluimm;            ea <= da;
            eb <= db;            eimm <= dimm;
            ern <= drn;            eshift <= dshift;
            ejal <= djal;            epc4 <= dpc4;
            ejalr <= 0;
            elmem <= dlmem;           esmem <= dsmem;
        end
endmodule
