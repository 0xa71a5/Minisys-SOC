`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/23 20:19:31
// Design Name: 
// Module Name: mreg_sim
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


module mreg_sim();
    
    reg [31:0] mmo,malu;
    reg [4:0] mrn;
    reg mwreg,mm2reg;
    reg clk,clrn;
    wire [31:0] wmo,walu;
    wire [4:0] wrn;
    wire wwreg,wm2reg;
    pipemwreg mmwreg(mwreg,mm2reg,mmo,malu,mrn,clk,clrn,wwreg,wm2reg,wmo,walu,wrn);
    always 
        begin
            clk=0;
            clrn = 1;
            mmo=32'h00000001;
            malu = 32'h00000002;
            mrn = 5'b00001;
            mwreg = 1;
            mm2reg = 1;
            #20;
            clrn = 0;
            #2
            clrn = 1;
            #2
    
            //在0000h处写数据12345678h
           
            #5;
            clk=0;
            #5;
            clk=1;
            #5;
            clk=0;
             
            #5;
            
            
            //读0000h数据
            clk=1;
           
            #5;
            clk=0;
             
            #500;
            
        end
endmodule
