`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/19 15:16:15
// Design Name: 
// Module Name: sim_mem
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


module sim_mem(
    );
    reg  we;
    reg [1:0] smem;//store mem
    reg [2:0] lmem;//load mem
    reg [31:0] addr;
    reg [31:0] datain;
    reg clk;
    wire [31:0] dataout;
    wire [3:0] wea;
   // wire we_2;
   // wire [3:0] wea;
    pipemem uut_mem0(we,smem,lmem,addr,datain,clk,dataout,wea);
    reg [31:0] i;
    always 
begin//上升沿之前要准备好数据和控制线
i=0;
clk=0;
we=0;
smem=2'b00;
lmem=3'b000;
addr=32'd0;
datain=32'h12345678;
#5;

//write addr 0 data  
clk=0;
we=1;
addr=32'd0;
datain=32'h82848678;
#5;
clk=1;
#5;


//read addr 0 data 
clk=0;
we=0;
lmem=3'b001;
addr=32'd2;
#5;
clk=1;
#5;

//read addr 4 data 
clk=0;
we=0;
lmem=3'b010;
addr=32'd2;
#5;
clk=1;
#5;

//read addr 0 data 
clk=0;
we=0;
lmem=3'b110;
addr=32'd2;
#5;
clk=1;
#5;

//read addr 0 data  
clk=0;
we=0;
lmem=3'b101;
addr=32'd2;
#5;
clk=1;
#5;



we=0;
for(i=0;i<100*4;i=i+4)
begin
    addr=i;
    clk = 0;
    #5;
    clk = 1;
    #5;
end

#500;

end

/*
    always 
    begin
        clk=1;
        we=0;
        smem=2'b00;
        lmem=3'b000;
        addr=32'd0;
        datain=32'h12345678;
        #20;

        //在0000h处写数据12345678h
        we=1;
        smem=2'b00;//存4byte
        addr=32'h00000000;
        datain=32'h12345678;
        clk=0;
        #5;
        we=0;
        clk=1;
        #5;
        
        
        //在0004h处写数据01020304h
        we=1;
        smem=2'b00;//存4byte
        addr=32'h00000004;
        datain=32'h01020304;
        clk=0;
        #5;
        we=0;
        clk=1;
        #5;
        
        
        //读0000h数据
        we=0;
        smem=2'b00;
        lmem=2'b00;
        clk=0;
        #5;
        clk=1;
        #5
        
        //读0004h数据
        we=0;
        smem=2'b00;
        lmem=2'b00;
        clk=0;
        #5;
        clk=1;
        #500;
        
    end
*/


endmodule
