`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 20:03:59
// Design Name: 
// Module Name: pipeimem
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


module pipeimem(a,inst,clk);
    input [31:0] a;
    input clk;
    //input ena;
    output [31:0] inst;
    
    blk_mem_gen_1 your_instance_name (
      .clka(clk),    // input wire clka
      .ena(1'b1),      // input wire ena
      .addra(a[15:2]),  // input wire [13 : 0] addra
      .douta(inst)  // output wire [31 : 0] douta
    );
    
    /*
    dist_mem_gen_0 your_instance_name (
      .a(a[15:2]),      // input wire [13 : 0] a
      .spo(inst)  // output wire [31 : 0] spo
    );  
    */       
endmodule
