`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/23 20:49:58
// Design Name: 
// Module Name: rom_sim
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


module rom_sim();
    
    reg [31:0] a;
   
    wire [31:0] outdata;
    pipeimem rom(a,outdata);
    always 
    begin
    a = 32'h0;
    
    
    #5;
    
    a = a+4;
    #5;
    
    a = a+4;
    #2000;
    end
endmodule
