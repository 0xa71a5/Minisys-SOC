`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/17 16:26:13
// Design Name: 
// Module Name: clock_div
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


module clockDiv(
clk, //100MHz
clk_sys ,resetn//1Hz
    );
   input clk;
   input resetn;
   output clk_sys;
    reg clk_sys = 0;
    reg [25:0] div_counter = 0;
   always @(posedge clk or negedge resetn) 
   begin
   if(resetn==1'b0)
    begin
        clk_sys<=0;
        div_counter<=0;
    end
   else if(div_counter>=50000)
    begin //1Hz 50000000
        clk_sys<=~clk_sys;
        div_counter<=0;
    end 
    else begin
        div_counter <= div_counter + 1;
   end
  end
endmodule
