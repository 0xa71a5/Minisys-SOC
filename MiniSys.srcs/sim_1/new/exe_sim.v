`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/22 19:18:56
// Design Name: 
// Module Name: exe_sim
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


module exe_sim();
    reg [31:0] ea,eb,eimm,epc4;
    reg [4:0] ern0;
    reg [3:0] ealuc;
    reg  ealuimm,eshift,ejal,ejalr;
    wire [31:0] ealu;
    wire [4:0] ern;
    pipeexe exe(ealuc,ealuimm,ea,eb,eimm,eshift,ern0,epc4,ejal,ejalr,ern,ealu);
    always 
    begin
                ea=32'h00000002;
                eb=32'h80000001;
                eimm = 32'h000000c0;
                epc4 = 32'h00000004;
                ern0 = 5'b10101;
                ealuc = 4'b0111;
                ealuimm = 0;
                eshift = 1;
                ejal = 0;
                ejalr = 0;
                #500;
                
    end
endmodule
