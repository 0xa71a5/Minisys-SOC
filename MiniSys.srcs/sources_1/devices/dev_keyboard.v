`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/15 20:11:44
// Design Name: 
// Module Name: dev_keyboard
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


module dev_keyboard(
input Reset,input [1:0] Address,input Cs,input Clk,input Ior ,output [15:0] Rdata,input Keyclk,input [3:0] Line,output [3:0] Col//,output [7:0] state
    );

    reg [15:0] key_reg;
    reg [15:0] status_reg;
    reg [15:0] Rdata;
    reg [3:0] Col;
    reg key_stroke;
    always @(posedge Clk or negedge Reset or posedge key_stroke)
    begin
        if(key_stroke==1'b1)
            status_reg[0]=1;

        if(Reset==1'b0)//reset
            begin
                status_reg[15:0] =0;   
            end    
        else if(Cs==1'b1 && Ior==1'b1)                
            begin
                case(Address[1:0])
                    2'b00: Rdata[15:0] = key_reg[15:0] ;  
                    2'b10: begin
                                Rdata[15:0] = status_reg[15:0];
                                status_reg[0] = 0;
                           end
                    default:Rdata = 16'dx;
                endcase
            end
        
            
    end
    
    reg [7:0] state;
 
    always @(posedge Keyclk or negedge Reset) 
    begin
        if (Reset==1'b0) begin
            // reset
                key_reg[15:0] = 0;
                state[7:0] = 0;
                key_stroke = 0;
            end
        else
        begin
            case(state)
                8'd0:begin
                        Col[3:0]=4'b1111;
                        if(Line[3:0]!=4'b0000)
                            state=1;    
                        else
                            key_stroke = 1'b0;
                end
                
                8'd1:begin
                        Col[3:0]=4'b1000;
                        key_stroke = 1'b1;
                        case(Line[3:0])
                            4'b1000:key_reg[15:0] = 1;
                            4'b0100:key_reg[15:0] = 2;
                            4'b0010:key_reg[15:0] = 3;
                            4'b0001:key_reg[15:0] = 4;
                            default:key_stroke=1'b0;
                        endcase
                        if(key_stroke==1'b0)
                            state=2;
                        else
                            state=1;
                end

                8'd2:begin
                        Col[3:0]=4'b0100;
                        key_stroke = 1'b1;
                        case(Line[3:0])
                            4'b1000:key_reg[15:0] = 5;
                            4'b0100:key_reg[15:0] = 6;
                            4'b0010:key_reg[15:0] = 7;
                            4'b0001:key_reg[15:0] = 8;
                            default:key_stroke=1'b0;
                        endcase
                        if(key_stroke==1'b0)
                            state=3;
                        else
                            state=2;
                end

                8'd3:begin
                        Col[3:0]=4'b0010;
                        key_stroke = 1'b1;
                        case(Line[3:0])
                            4'b1000:key_reg[15:0] = 9;
                            4'b0100:key_reg[15:0] = 10;
                            4'b0010:key_reg[15:0] = 11;
                            4'b0001:key_reg[15:0] = 12;
                            default:key_stroke=1'b0;
                        endcase
                        if(key_stroke==1'b0)
                            state=4;
                        else
                            state=3;
                end

                8'd4:begin
                        Col[3:0]=4'b0001;
                        key_stroke = 1'b1;
                        case(Line[3:0])
                            4'b1000:key_reg[15:0] = 13;
                            4'b0100:key_reg[15:0] = 14;
                            4'b0010:key_reg[15:0] = 15;
                            4'b0001:key_reg[15:0] = 16;
                            default:key_stroke=1'b0;
                        endcase
                        if(key_stroke==1'b0)
                            state=0;
                        else
                            state=4;
                end
                
            endcase
        end
    end
endmodule
