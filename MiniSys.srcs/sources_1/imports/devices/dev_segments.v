`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/17 17:20:35
// Design Name: 
// Module Name: SEG_7
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// ensdditional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dev_segments(clk,reset,data,digital,ens);
    input clk;
    input reset;
    input [31:0] data; 
    reg [3:0] sw=0;
    output [7:0] digital;
    output [7:0] ens;
    reg[7:0] digital;
    reg[7:0] ens;
    reg[3:0] count = 0;
    always @(sw)
        case(sw)
            4'b0000:digital=8'b00000011;
            4'b0001:digital=8'b10011111;
            4'b0010:digital=8'b00100101;
            4'b0011:digital=8'b00001101;
            4'b0100:digital=8'b10011001;
            4'b0101:digital=8'b01001001;
            4'b0110:digital=8'b01000001;
            4'b0111:digital=8'b00011111;
            4'b1000:digital=8'b00000001;
            4'b1001:digital=8'b00011001;
            4'b1010:digital=8'b00010001;
            4'b1011:digital=8'b11000001;
            4'b1100:digital=8'b01100011;
            4'b1101:digital=8'b10000101;
            4'b1110:digital=8'b01100001;
            4'b1111:digital=8'b01110001;
        default:
            digital=8'bx;
        endcase
        
        
    always @(posedge clk or negedge reset)
        if(reset == 0)
            begin
                ens=8'b11111111;
                count<=0;
                sw<=4'd0;
            end
        else
            begin
            if(count == 0)
                begin
                    ens=8'b11111110;
                    count <= count  + 1;
                    sw<=data[3:0];
                end
            else if(count == 1)
                begin
                    ens=8'b11111101;
                    count <= count  + 1;
                    sw<=data[7:4];
                end
            else if(count == 2)
                begin
                    ens=8'b11111011;
                    count <= count  + 1;
                    sw<=data[11:8];
                end
            else if(count == 3)
                begin
                    ens=8'b11110111;
                    count <= count  + 1;
                    sw<=data[15:12];
                end
            else if(count == 4)
                begin
                    ens=8'b11101111;
                    count <= count  + 1;
                    sw<=data[19:16];
                end
            else if(count == 5)
                begin
                    ens=8'b11011111;
                    count <= count  + 1;
                    sw<=data[23:20];
                end                                                                     
            else if(count == 6)
                begin
                    ens=8'b10111111;
                    count <= count  + 1;
                    sw<=data[27:24];
                end
            else if(count == 7)
                begin
                    ens=8'b01111111; 
                    count <= 0;
                    sw<=data[31:28];
                end
            end 
endmodule
