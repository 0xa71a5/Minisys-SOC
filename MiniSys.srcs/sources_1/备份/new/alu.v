`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/08 15:38:45
// Design Name: 
// Module Name: alu
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


module alu(a,b,aluc,r,z);
    input [31:0] a,b;                              //aluc[3:0]
    input [3:0] aluc;
    output [31:0] r;                                //0 0 0 0 add
    output z;                                       //0 1 0 0 sub 
    wire [31:0] d_and = a & b;                     //0 0 0 1 and
    wire [31:0] d_or = a | b;                      //0 1 0 1 or
    wire [31:0] d_xor = a ^ b;                     //0 0 1 0 xor
    wire [31:0] d_lui = {b[15:0],16'h0};           //0 1 1 0 lui
    wire [31:0] d_nor = ~d_or;
    wire muxsign;
    wire [31:0] d_slt = muxsign? 32'h0 : 32'h1;
    wire [31:0] d_as,d_sh;                         //1 1 1 1 sra
    //adsu32 signal
    wire add_co,add_ofl,add_sign;
    //aluctrl signal
    wire right,arith,sub,sig;
    wire [2:0] op;
    alucontrol aluctrl(aluc,op,right,arith,sub,sig);
    addsub32 as32 (a,b,sub,d_as,add_co,add_ofl,add_sign);
    shift shifter (b,a[4:0],right,arith,d_sh);
    wire muxa = ~(sub ^ add_co);
    wire muxb = add_sign ^ add_ofl;
    assign muxsign = sig? muxa : muxb;
    mux8x32 select(d_as,d_and,d_or,d_xor,d_nor,d_lui,d_sh,d_slt,op,r);
    assign z = ~| r;
endmodule
