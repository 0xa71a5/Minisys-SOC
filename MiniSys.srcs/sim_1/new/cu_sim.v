`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/21 20:44:16
// Design Name: 
// Module Name: cu_sim
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


module cu_sim();
    reg mwreg,ewreg,em2reg,mm2reg,rsrtequ;
    reg [4:0] mrn,ern,rs,rt;
    reg [5:0] func,op;
    
    reg cpdone;//use to judge whether the compare is successful

    wire jalr;
    wire [3:0] aluc;
    wire [1:0] pcsource;
    wire [1:0] fwda,fwdb;//foewarding
    wire nostall; //stall pipeline due to lw dependent
    wire wreg,m2reg,wmem,regrt,aluimm,sext,shift,jal;
    wire [1:0] compare;//use to compare the value

    wire [2:0] lmem;// get bit
    wire [1:0] smem;//save bit
    pipeidcu cu(mwreg,mrn,ern,ewreg,em2reg,mm2reg,rsrtequ,func,op,rs,rt,
    wreg,m2reg,wmem,aluc,regrt,aluimm,fwda,fwdb,nostall,sext,pcsource,shift,jal,jalr,
    compare,cpdone,lmem,smem);
    always 
    begin
        mwreg = 1;
        ewreg = 1;
        em2reg = 1;
        mm2reg = 0;
        rsrtequ = 0;
        mrn = 5'b00001;
        ern = 5'b00001;
        rs = 5'b00001;
        rt = 5'b00000;
        
        func = 6'b100001;
        op = 6'b000000;
        cpdone = 0;
    #500;
    end
endmodule
