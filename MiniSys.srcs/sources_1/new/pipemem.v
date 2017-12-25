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


module pipemem(we,smem,lmem,addr,datain,clk,dataout,wea);
    input [31:0] addr,datain;
    input clk,we;
    input [2:0] lmem;
    input [1:0] smem;
    output [31:0] dataout;
    output [3:0] wea;//debug
    wire [3:0] wea;
    wire smem0_0,
          smem1_0,smem1_1,smem1_2,smem1_3,
          smem2_0,smem2_1,smem2_2;
    wire [31:0] douta;
    wire e8,e16;//use to extend the out data
    wire [23:0] ext8;
    wire [15:0] ext16;
    wire [31:0] d_lh,d_lb;
    wire [31:0] debug_d_lh,debug_d_lb;
    wire [1:0] op;

    and(smem0_0,~smem[1],~smem[0],~addr[1],~addr[0]);//0000
    and(smem1_0,~smem[1],smem[0],~addr[1],~addr[0]);//0100
    and(smem1_1,~smem[1],smem[0],~addr[1],addr[0]);//0101
    and(smem1_2,~smem[1],smem[0],addr[1],~addr[0]);//0110
    and(smem1_3,~smem[1],smem[0],addr[1],addr[0]);//0111
    and(smem2_0,smem[1],~smem[0],~addr[1],~addr[0]);//1000
    and(smem2_1,smem[1],~smem[0],~addr[1],addr[0]);//1001
    and(smem2_2,smem[1],~smem[0],addr[1],~addr[0]);//1010
    //lmem

    //assign wea[3] = (smem0_0);//(smem0_0 | smem1_3 | smem2_2);
    assign wea[3] = (smem0_0 | smem1_3 | smem2_2)&we;
    assign wea[2] = (smem0_0 | smem1_2 | smem2_1 | smem2_2)&we;
    assign wea[1] = (smem0_0 | smem1_1 | smem2_0 | smem2_1)&we;
    assign wea[0] = (smem0_0 | smem1_0 | smem2_0)&we;
    wire clk_revert;//reverse the input clk ,so the clk will be negedge to trigger the mem work

    blk_mem_gen_0 your_instance_name (
      .clka(clk),    // input wire clka
      .ena(1'b1),      // input wire ena
      .wea(wea),      // input wire [3 : 0] wea
      .addra(addr[15:2]),  // input wire [13 : 0] addra
      .dina(datain),    // input wire [31 : 0] dina
      .douta(douta)  // output wire [31 : 0] douta
     );


    assign op[1] = lmem[0];
    assign op[0] = lmem[1];
    //assign e8 = (~lmem[2])&douta[7];
    //下面是对地址低2位的补充符号位判断 
    assign e8 = addr[1:0]==2'b00 ? (~lmem[2])&douta[7] : ( addr[1:0]==2'b01 ? (~lmem[2])&douta[15]  : ( addr[1:0]==2'b10 ?  (~lmem[2])&douta[23]  : (~lmem[2])&douta[31]  )  );
    //assign e16 = (~lmem[2])&douta[15];
    assign e16= addr[1:0]==2'b00 ? (~lmem[2])&douta[15] : ( addr[1:0]==2'b01 ? (~lmem[2])&douta[23]  : ( addr[1:0]==2'b10 ?  (~lmem[2])&douta[31]  : (~lmem[2])&douta[31]  )  );
    
    assign ext8 = {24{e8}};
    assign ext16 = {16{e16}};
    
    assign debug_d_lb = {ext8,douta[7:0]};
    assign debug_d_lh = {ext16,douta[15:0]};
    
    wire [31:0] d_4byte_1111;//这里参考excel
    wire [31:0]  d_2byte_0011;
    wire [31:0]  d_1byte_0001;
    assign d_4byte_1111 = douta;
    assign d_2byte_0011 = {ext16,douta[15:0]};
    assign d_1byte_0001 = {ext8 ,douta[7:0]};
    
    wire [31:0]  d_2byte_0110;
    wire [31:0]  d_1byte_0010;
    //xxx
    assign d_2byte_0110 = {ext16,douta[23:8]};//<<error
    assign d_1byte_0010 = {ext8, douta[15:8]};
    
    wire [31:0] d_2byte_1100;
    wire [31:0] d_1byte_0100;
    //xxx
    assign d_2byte_1100 = {ext16,douta[31:16]};
    assign d_1byte_0100 = {ext8 ,douta[23:16]};
    
    wire [31:0] d_1byte_1000;
    //xxx
    //xxx
    assign d_1byte_1000 = {ext8,douta[31:24]};
    //这里代码没有写完
    assign d_lh = addr[1:0]==2'b00 ? d_2byte_0011 : ( addr[1:0]==2'b01 ? d_2byte_0110 : ( addr[1:0]==2'b10 ?  d_2byte_1100 :32'hxxxx )  );
    assign d_lb = addr[1:0]==2'b00 ? d_1byte_0001 : ( addr[1:0]==2'b01 ? d_1byte_0010 : ( addr[1:0]==2'b10 ?  d_1byte_0100 :d_1byte_1000 )  );
    
    mux4x32 select(d_4byte_1111,d_lh,d_lb,,op,dataout);
    //mux4x32 select(d_4byte_1111,debug_d_lh,debug_d_lb,,op,dataout);

endmodule


