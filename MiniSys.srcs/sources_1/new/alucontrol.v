`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/10 19:38:25
// Design Name: 
// Module Name: alucontrol
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


module alucontrol(aluc,op,right,arith,sub,sig);
    input [3:0] aluc;
    output [2:0] op;
    output right,arith,sub,sig;
    wire i_sub,i_add,i_addu,i_subu,i_and,i_or,i_xor,i_nor,i_lui,i_sra,
    i_srl,i_sll,i_slt,i_sltu;
    //order
    and (i_add,~aluc[3],~aluc[2],~aluc[1],~aluc[0]);//0000
    and (i_sub,~aluc[3],aluc[2],~aluc[1],~aluc[0]);//0100
    and (i_addu,aluc[3],~aluc[2],~aluc[1],~aluc[0]);//1000
    and (i_subu,aluc[3],aluc[2],~aluc[1],~aluc[0]);//1100
    and (i_and,~aluc[3],~aluc[2],~aluc[1],aluc[0]);//0001
    and (i_or,~aluc[3],aluc[2],~aluc[1],aluc[0]);//0101
    and (i_xor,~aluc[3],~aluc[2],aluc[1],~aluc[0]);//0010
    and (i_nor,aluc[3],~aluc[2],aluc[1],~aluc[0]);//1010
    and (i_lui,~aluc[3],aluc[2],aluc[1],~aluc[0]);//0110
    and (i_sra,aluc[3],aluc[2],aluc[1],aluc[0]);//1111
    and (i_srl,~aluc[3],aluc[2],aluc[1],aluc[0]);//0111
    and (i_sll,~aluc[3],~aluc[2],aluc[1],aluc[0]);//0011
    and (i_slt,aluc[3],~aluc[2],~aluc[1],aluc[0]);//1001
    and (i_sltu,aluc[3],~aluc[2],aluc[1],aluc[0]);//1011
    //signal
    assign op[2] = i_nor | i_lui | i_sra | i_srl | i_sll | i_slt | i_sltu;
    assign op[1] = i_or | i_xor | i_sra | i_srl | i_sll | i_slt | i_sltu;
    assign op[0] = i_and | i_xor | i_lui | i_slt | i_sltu;
    assign right = i_sra | i_srl;
    assign arith = i_sra;
    assign sub = i_sub | i_subu | i_slt | i_sltu;
 //   assign ov = i_sub | i_add;
    assign sig = i_slt;
    
endmodule
