`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/01 22:34:35
// Design Name: 
// Module Name: pipeexe
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


module pipeexe(ealuc,ealuimm,ea,eb,eimm,eshift,ern0,epc4,ejal,ejalr,ern,ealu);
    input [31:0] ea,eb,eimm,epc4;
    input [4:0] ern0;
    input [3:0] ealuc;
    input  ealuimm,eshift,ejal,ejalr;
    output [31:0] ealu;
    output [4:0] ern;
    wire [31:0] alua,alub,sa,ealu0,epc8;
    //for jalr
    wire jal_jalr;
    wire z;
    assign sa = {eimm[5:0],eimm[31:6]};//shift amount
    cla32 ret_addr (epc4,32'h4,1'b0,epc8);
    mux2x32 alu_ina (ea,sa,eshift,alua);
    mux2x32 alu_inb (eb,eimm,ealuimm,alub);
    mux2x32 save_pc8 (ealu0,epc4,ejal,ealu);//这里之前是epc8  后来改成了epc4
    assign jal_jalr = ejal & (~ejalr);
    assign ern = ern0 | {5{jal_jalr}};
    alu al_unit (alua,alub,ealuc,ealu0,z);
endmodule
