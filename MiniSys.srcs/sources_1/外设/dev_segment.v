`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/18 22:04:00
// Design Name: 
// Module Name: dev_segment
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


module dev_segment(
input Reset,input [2:0] Address,input Cs,input Clk,input Iow,input [15:0] Wdata,output [7:0] digital,output [7:0] ens,input segment_clock
    );
    
reg [3:0] sw=0;
reg[7:0] digital;
reg[7:0] ens;
reg[3:0] count = 0;

reg [15:0] low4_data_reg;//低四位数码管数据寄存器
reg [15:0] high4_data_reg;//高四位数码管数据寄存器
reg [15:0] display_ctrl_reg;//数码管显示控制寄存器
wire [31:0] data;
wire [7:0] show_enable;
wire [7:0] dot_enable;

assign data={high4_data_reg,low4_data_reg};
assign show_enable=display_ctrl_reg[15:8];
assign dot_enable =display_ctrl_reg[7:0];


always @(posedge Clk or negedge Reset)//控制寄存器的写入
begin
    if(Reset==0)//reset
        begin
            low4_data_reg[15:0] = 16'd0;
            high4_data_reg[15:0] = 16'd0;
            display_ctrl_reg[15:0] = 16'd0;
        end
    else if(Cs==1'b1 && Iow==1'b1)//片选 写入
        begin
            case(Address[2:0])//写地址判断
                3'b000: low4_data_reg[15:0] = Wdata[15:0];//低四位数码管数据寄存器赋值
                3'b010: high4_data_reg[15:0] = Wdata[15:0];//高四位数码管数据寄存器赋值
                3'b100: display_ctrl_reg[15:0] = Wdata[15:0];//控制寄存器赋值
            endcase
        end
end

reg dot_enable_current = 0;
always @(posedge segment_clock or negedge Reset)//Beforo,here clock is Clk ,but now i changed it to a slower clock segment_clock
begin
    if(Reset == 0)
        begin
            ens=8'b11111111;
            count<=0;
            sw<=4'd0;
        end
    else
        begin
        if(count == 0)
            begin
                ens={7'b1111111,~show_enable[0]};
                count <= count  + 1;
                sw<=data[3:0];
                dot_enable_current<=dot_enable[0];
            end
        else if(count == 1)
            begin
                ens={6'b111111,~show_enable[1],1'b1};
                count <= count  + 1;
                sw<=data[7:4];
                dot_enable_current<=dot_enable[1];
            end
        else if(count == 2)
            begin
                ens={5'b11111,~show_enable[2],2'b11};
                count <= count  + 1;
                sw<=data[11:8];
                dot_enable_current<=dot_enable[2];
            end
        else if(count == 3)
            begin
                ens={4'b1111,~show_enable[3],3'b111};
                count <= count  + 1;
                sw<=data[15:12];
                dot_enable_current<=dot_enable[3];
            end
        else if(count == 4)
            begin
                ens={3'b111,~show_enable[4],4'b1111};
                count <= count  + 1;
                sw<=data[19:16];
                dot_enable_current<=dot_enable[4];
            end
        else if(count == 5)
            begin
                ens={2'b11,~show_enable[5],5'b11111};
                count <= count  + 1;
                sw<=data[23:20];
                dot_enable_current<=dot_enable[5];
            end                                                                     
        else if(count == 6)
            begin
                ens={1'b1,~show_enable[6],6'b111111};
                count <= count  + 1;
                sw<=data[27:24];
                dot_enable_current<=dot_enable[6];
            end
        else if(count == 7)
            begin
                ens={~show_enable[7],7'b1111111};
                count <= 0;
                sw<=data[31:28];
                dot_enable_current<=dot_enable[7];
            end
        end 
end
 
always @(sw)
begin
        case(sw)
            4'd0:digital=8'b00000011&{7'b1111111,~dot_enable_current};
            4'd1:digital=8'b10011111&{7'b1111111,~dot_enable_current};
            4'd2:digital=8'b00100101&{7'b1111111,~dot_enable_current};
            4'd3:digital=8'b00001101&{7'b1111111,~dot_enable_current};
            4'd4:digital=8'b10011001&{7'b1111111,~dot_enable_current};
            4'd5:digital=8'b01001001&{7'b1111111,~dot_enable_current};
            4'd6:digital=8'b01000001&{7'b1111111,~dot_enable_current};
            4'd7:digital=8'b00011111&{7'b1111111,~dot_enable_current};
            4'd8:digital=8'b00000001&{7'b1111111,~dot_enable_current};
            4'd9:digital=8'b00001001&{7'b1111111,~dot_enable_current};
            4'ha:digital=8'b00010001&{7'b1111111,~dot_enable_current};
            4'hb:digital=8'b11000001&{7'b1111111,~dot_enable_current};
            4'hc:digital=8'b01100011&{7'b1111111,~dot_enable_current};
            4'hd:digital=8'b10000101&{7'b1111111,~dot_enable_current};
            4'he:digital=8'b01100001&{7'b1111111,~dot_enable_current};
            4'hf:digital=8'b01110001&{7'b1111111,~dot_enable_current};
        default:
            digital=8'b0;
        endcase
end

endmodule
