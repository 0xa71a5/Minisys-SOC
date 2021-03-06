`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/14 22:13:43
// Design Name: 
// Module Name: pipelinedcpu
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


module pipelinedcpu(clock,memclock,resetn,pc,inst,ealu,malu,walu);
    input clock,memclock,resetn;
    output [31:0] pc,inst,ealu,malu,walu;
    wire [31:0] bpc,jpc,npc,pc4,ins,dpc4,inst,da,db,dimm,ea,eb,eimm;
    wire [31:0] epc4,mb,mmo,wmo,wdi;
    wire [4:0] drn,ern0,ern,mrn,wrn;
    wire [3:0] daluc,ealuc; //daluc = aluc
    wire [1:0] pcsource;
    wire wpcir;
    wire dwreg,dm2reg,dwmem,daluimm,dshift,djal;
    wire djalr,dlmem,dsmem;
    wire ewreg,em2reg,ewmem,ealuimm,eshift,ejal;
    wire ejalr,elmem,esmem;
    wire mwreg,mm2reg,mwmem;
    wire mlmem,msmem;
    wire wwreg,wm2reg;
    pipepc progcnt (npc,wpcir,clock,resetn,pc);
    pipeif if_stage (pcsource,pc,bpc,da,jpc,npc,pc4,ins);
    pipeir inst_reg (pc4,ins,wpcir,clock,resetn,dpc4,inst);
    pipeid id_stage (mwreg,mrn,ern,ewreg,em2reg,mm2reg,dpc4,inst,
                     wrn,wdi,ealu,malu,mmo,wwreg,clock,resetn,
                     bpc,jpc,pcsource,wpcir,dwreg,dm2reg,dwmem,
                     daluc,daluimm,da,db,dimm,drn,dshift,djal,djalr,dlmem,dsmem);
    pipedereg de_reg (dwreg,dm2reg,dwmem,daluc,daluimm,da,db,dimm,
                      drn,dshift,djal,djalr,dlmem,dsmem,dpc4,clock,resetn,
                      ewreg,em2reg,ewmem,ealuc,ealuimm,ea,eb,eimm,
                      ern0,eshift,ejal,ejalr,elmem,esmem,epc4);
    pipeexe exe_stage (ealuc,ealuimm,ea,eb,eimm,eshift,ern0,epc4,
                       ejal,ejalr,ern,ealu);
    pipeemreg em_reg (ewreg,em2reg,ewmem,ealu,eb,ern,clock,resetn,
                      mwreg,mm2reg,mwmem,mlmem,msmem,malu,mb,mrn);
    pipemem mem_stage (mwmem,msmem,mlmem,malu,mb,clock,mmo);
    pipemwreg mw_reg (mwreg,mm2reg,mmo,malu,mrn,clock,resetn,
                      wwreg,wm2regwmo,walu,wrn);
    mux2x32 wb_stage (walu,wmo,wm2reg,wdi);
endmodule 
