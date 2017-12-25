`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 20:40:25
// Design Name: 
// Module Name: pipemem
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


module pipemem(we,smem,lmem,addr,datain,clk,dataout);
    input [31:0] addr,datain;
    input clk,we;
    input [2:0] lmem;
    input [1:0] smem;
    output [31:0] dataout;
    wire [3:0] wea;
    //wire write_enable = we & ~clk;
    wire smem0_0,
          smem1_0,smem1_1,smem1_2,smem1_3,
          smem2_0,smem2_1,smem2_2;
    wire [31:0] douta;
    wire e8,e16;//use to extend the out data
    wire [23:0] ext8;
    wire [15:0] ext16;
    wire [31:0] d_lh,d_lb;
    wire [1:0] op;

    //smem
    and(smem0_0,~smem[1],~smem[0],~addr[1],~addr[0]);//0000
    and(smem1_0,~smem[1],smem[0],~addr[1],~addr[0]);//0100
    and(smem1_1,~smem[1],smem[0],~addr[1],addr[0]);//0101
    and(smem1_2,~smem[1],smem[0],addr[1],~addr[0]);//0110
    and(smem1_3,~smem[1],smem[0],addr[1],addr[0]);//0111
    and(smem2_0,smem[1],~smem[0],~addr[1],~addr[0]);//1000
    and(smem2_1,smem[1],~smem[0],~addr[1],addr[0]);//1001
    and(smem2_2,smem[1],~smem[0],addr[1],~addr[0]);//1010
    
    assign wea[3] = (smem0_0 | smem1_3 | smem2_2)&we;
    assign wea[2] = (smem0_0 | smem1_2 | smem2_1 | smem2_2)&we;
    assign wea[1] = (smem0_0 | smem1_1 | smem2_0 | smem2_1)&we;
    assign wea[0] = (smem0_0 | smem1_0 | smem2_0)&we;
    blk_mem_gen_0 your_instance_name (
      .clka(clk),    // input wire clka
      .ena(1'b1),      // input wire ena
      .wea(wea),      // input wire [3 : 0] wea
      .addra(addr[15:2]),  // input wire [13 : 0] addra
      .dina(datain),    // input wire [31 : 0] dina
      .douta(douta)  // output wire [31 : 0] douta
     );
     /*
    always @ (lmem)begin
         dataout = douta;//default forward y: no hazards
         if(lmem[1] == 1'b1) begin
                e =(~lmem[2])&douta[15];
                dataout = {16{e},inst[15:0]};
         end
         else if(lmem[0] == 1'b1) begin
                e =(~lmem[2])&douta[7];
                dataout = {24{e},inst[7:0]};
         end
    end
    */
    assign op[1] = lmem[0];
    assign op[0] = lmem[1];
    assign e8 = (~lmem[2])&douta[7];
    assign e16 = (~lmem[2])&douta[15];
    assign ext8 = {24{e8}};
    assign ext16 = {16{e16}};
    assign d_lb = {ext8,douta[7:0]};
    assign d_lh = {ext16,douta[15:0]};
    mux4x32 select(douta,d_lh,d_lb,,op,dataout);
endmodule
