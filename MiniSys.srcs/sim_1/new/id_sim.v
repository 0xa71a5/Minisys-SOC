`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/22 10:18:03
// Design Name: 
// Module Name: id_sim
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


module id_sim();
    reg [31:0] dpc4,inst,wdi,ealu,malu,mmo;
    reg [4:0] ern,mrn,wrn;
    reg mwreg,ewreg,em2reg,mm2reg,wwreg;
    reg clk,clrn;
    wire [31:0] bpc,jpc,a,b,imm;
    wire [4:0] rn;
    wire [3:0] aluc;
    wire [1:0] pcsource;
    wire nostall,wreg,m2reg,wmem,aluimm,shift,jal,jalr;
    //for memory
    wire [2:0] lmem;
    wire [1:0] smem;
    pipeid id(mwreg,mrn,ern,ewreg,em2reg,mm2reg,dpc4,inst,wrn,
    wdi,ealu,malu,mmo,wwreg,clk,clrn,bpc,jpc,pcsource,nostall,wreg,
    m2reg,wmem,aluc,aluimm,a,b,imm,rn,shift,jal,jalr,lmem,smem);
    always 
    begin
    clk = 0;
    clrn=1;
    #1;
    clrn = 0;
    #1;
    clrn=1;
    #1
    clk=1;
    #5;
    clk=0;
    #5;
    clk=1;
    inst = 32'h0023C020;
    dpc4 = 32'h00000004;
    wdi = 32'h82345678;
    ealu = 32'h00000001;
    malu = 32'h00000010;
    mmo = 32'h00000100;
    ern = 5'b00000;
    mrn = 5'b00000;
    wrn = 5'b00001;
    
    mwreg = 0;
    ewreg = 0;
    em2reg = 0;
    mm2reg = 0;
    wwreg = 1;
    
            #5;
            clk=0;
    #5
    clk = 1;
     inst = 32'h0430C022;
       dpc4 = 32'h00000008;
       wdi = 32'h87654321;
       ealu = 32'h00000001;
       malu = 32'h00000010;
       ern = 5'b00000;
       mrn = 5'b00000;
       wrn = 5'b00010;
       
       mwreg = 1;
       ewreg = 1;
       em2reg = 0;
       mm2reg = 0;
       wwreg = 0;
       #2000;
       end
         //   while(i==32'b0)
          // #5 clk = ~clk;
endmodule
