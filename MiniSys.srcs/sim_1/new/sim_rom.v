`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/27 19:02:33
// Design Name: 
// Module Name: sim_rom
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


module sim_rom(

    );
    reg [31:0] addr;
    reg clk;
    wire [31:0] data;
    
    pipeimem mem_uut1(addr,data,clk);
    
always
begin
addr=0;
clk=0;
for(addr=0;addr<40;addr=addr+4)
begin
    clk=1;
    #5;
    clk=0;
    #5;
end

end    
    
endmodule
