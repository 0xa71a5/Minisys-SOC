`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/20 16:06:09
// Design Name: 
// Module Name: dffe32_sim
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


module dffe32_sim();

    reg [31:0] datain;
    reg clk,clrn,e;
    wire [31:0] q;
    dffe32 regdffe(datain,clk,clrn,e,q);

    always 
    begin
        clk=0;
        clrn = 1;
        e=0;
        datain=32'h12345678;
        #20;
        clrn = 0;
        #2
        clrn = 1;
        #2

        //在0000h处写数据12345678h
       
        #5;
        clk=0;
                e=0;
                datain=32'h12345678;
        #5;
        
        
        //在0004h处写数据01020304h
        clk=1;

                e=0;
                datain=32'h12345678;
        #5;
        clk=0;
               // clrn = 0;
                e=0;
                datain=32'h12345678;
        #5;
        
        
        //读0000h数据
        clk=1;
                e=1;
                datain=32'h12345678;
        #5;
        clk=0;
                        e=1;
                        datain=32'h12345678;
        #3
                        datain=32'h87654321;
        #2

        clk=1;
                       // e=1;
                        
        #5;
        clk=0;
        #500;
        
    end
endmodule
