`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/18 17:03:51
// Design Name: 
// Module Name: keyboard_sim
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


module sim_keyboard(
    );
//input Reset,input [1:0] Address,input Cs,input Clk,input Ior ,output [15:0] Rdata,input Keyclk,input [3:0] Line,output [3:0] Col
reg Reset;
reg [1:0] Address;
reg Cs;
reg Clk;
reg Ior;
wire [15:0] Rdata;
reg Keyclk;
reg [3:0] Line;
wire [3:0] Col;
//wire [7:0] state;
dev_keyboard uut_keyboard(Reset,Address,Cs,Clk,Ior,Rdata,Keyclk,Line,Col);

always
begin
    Keyclk = 0;
    #1;
    Keyclk = 1;
    #1;
end

always 
begin
    Reset = 1;
    Address = 0;
    Cs = 0;
    Clk = 0;
    Ior = 0;
    Line = 0;
    #5;

    Reset = 0;
    #5;

    Reset =1;
    Address = 0;

    while(Reset==1'b1)
    begin
        Cs=1;
        Ior = 1;
        Address =2;
        Clk = 1;
        #5;
        Clk = 0;
        Cs=0;
        Ior = 0;
        #5;

        if(Rdata[0]==1'b1)//¶ÁÈ¡¼üÖµ
        begin
            Cs=1;
            Ior = 1;
            Address =0;
            Clk = 1;
            #5;
            Clk = 0;
            Cs=0;
            Ior = 0;
            #5;
        end
    end

end

reg [31:0] cnt;
always @(posedge Col[3] or negedge Reset or posedge Keyclk)
begin
    if(Reset==0)
        begin
            cnt=0;
            Line[3:0] = 4'b0000;
        end
    else if(Col==4'b1111 || Col==4'b1000)begin
            cnt=cnt+1;
        if(cnt>40)
            Line[3:0] = 4'b0100;
    end
end

endmodule
