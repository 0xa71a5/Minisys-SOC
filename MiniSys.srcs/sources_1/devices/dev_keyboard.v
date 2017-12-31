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
    reg [7:0] state;
    
    always @(posedge Clk or negedge Reset/* or posedge key_stroke*/)//error here ,this is a problem to solve.
    begin
        //if(key_stroke==1'b1)
          //  status_reg[0]=1;

        if(Reset==1'b0)//reset
            begin
                status_reg[15:0] =0;   
            end    
        else //if(Cs==1'b1 && Ior==1'b1)                
            begin
                Rdata[15:0] = key_reg[15:0] ; 
                /*
                case(Address[1:0])
                    2'b00: Rdata[15:0] = key_reg[15:0] ; 
                    2'b01: Rdata[15:0] = 16'habcd;//²âÊÔÓÃ 
                    2'b10: begin
                                Rdata[15:0] = status_reg[15:0];
                                status_reg[0] = 0;
                           end
                    2'b11: Rdata[15:0] = {8'hff,state};
                    default:Rdata = 16'dx;
                endcase
                */
            end
    end
    
    
 
    always @(posedge Keyclk or negedge Reset) 
    begin
        if (Reset==1'b0) begin
            // reset
                key_reg[15:0] = 16'hffff;
                state[7:0] = 0;
                Col[3:0]=4'b0000;
            end
        else
        begin
            case(state)
                8'd0:begin
                        Col[3:0]=4'b0000;
                        
                        if(Line[3:0]!=4'b1111)
                            begin
                                state=1;    
                            end
                        else
                            begin
                                state=0;
                                key_reg[15:0] = 16'hffff;
                            end
                end

                8'd1:begin
                        Col[3:0]=4'b0111;
                        state = 2;
                end
                
                
                8'd2:begin
                        case(Line[3:0])
                            4'b0111:begin key_reg[15:0] = 1;state=1;    end
                            4'b1011:begin key_reg[15:0] = 2;state=1;    end
                            4'b1101:begin key_reg[15:0] = 3;state=1;    end
                            4'b1110:begin key_reg[15:0] = 4;state=1;    end
                            default:begin                   state=3;    end
                        endcase
                end

                8'd3:begin
                        Col[3:0]=4'b1011;
                        state = 4;
                end

                8'd4:begin
                        case(Line[3:0])
                            4'b0111:begin key_reg[15:0] = 5;state=3;    end
                            4'b1011:begin key_reg[15:0] = 6;state=3;    end
                            4'b1101:begin key_reg[15:0] = 7;state=3;    end
                            4'b1110:begin key_reg[15:0] = 8;state=3;    end
                            default:begin                   state=5;    end
                        endcase
                end

                8'd5:begin
                        Col[3:0]=4'b1101;
                        state = 6;
                end

                8'd6:begin
                        case(Line[3:0])
                            4'b0111:begin key_reg[15:0] = 9 ;state=5;    end
                            4'b1011:begin key_reg[15:0] = 10;state=5;    end
                            4'b1101:begin key_reg[15:0] = 11;state=5;    end
                            4'b1110:begin key_reg[15:0] = 12;state=5;    end
                            default:begin                    state=7;    end
                        endcase
                end

                8'd7:begin
                        Col[3:0]=4'b1110;
                        state = 8;
                end

                8'd8:begin
                        case(Line[3:0])
                            4'b0111:begin key_reg[15:0] = 13;state=7;    end
                            4'b1011:begin key_reg[15:0] = 14;state=7;    end
                            4'b1101:begin key_reg[15:0] = 15;state=7;    end
                            4'b1110:begin key_reg[15:0] = 16;state=7;    end
                            default:begin                    state=0;    end
                        endcase
                end
                
            endcase
        end
    end
endmodule
