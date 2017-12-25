`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/13 21:32:11
// Design Name: 
// Module Name: dev_timer
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


module dev_timer(
input Reset,input [2:0] Address,input Cs,input Clk,input Iow,input Ior ,input [15:0] Wdata, output [15:0] Rdata,input Pulse0 ,input Pulse1,output Cout0,output Cout1
/*output [15:0] state_reg0,output [15:0] function_reg0,output [15:0] cur_value_reg0,output [15:0] cur_cnt_value_reg0,output run_one_period0,output refresh_reg0*/
);

    reg [15:0] Rdata;
    reg Cout0;
    reg Cout1;
    
    //0�Ŷ�ʱ������
    reg [15:0] target_counter_reg0;//0�Ŷ�ʱ�� ��ֵ�Ĵ���
    wire [15:0] state_reg0;//0�Ŷ�ʱ�� ״̬�Ĵ���
    reg [15:0] function_reg0;//0�Ŷ�ʱ�� ��ʽ�Ĵ���
    reg [15:0] cur_value_reg0;//0�Ŷ�ʱ�� ��ǰ����ֵ
    reg timer0_mode;//��ʾ0�Ŷ�ʱ����ǰ������ʽ 0��ʾ����  1��ʾ��ʱ
    reg [15:0] cur_cnt_value_reg0; // 0�Ŷ�ʱ���ļ����Ĵ���
    reg run_one_period0 = 1; //����һ��ѭ�����ʱ�Ƿ���� ���һ��ѭ���������Ļ� ��bitΪ0
    reg state0_wire_15Cnt=0;
    reg state0_wire_15Timer=0;
    wire state0_wire_15;
    reg state0_wire_1=0;
    reg state0_wire_0=0;
    assign state0_wire_15 = state0_wire_15Cnt | state0_wire_15Timer; //15�Ź���״ָ̬ʾλ
    assign state_reg0[15:0] = {state0_wire_15,13'd0,state0_wire_1,state0_wire_0};
    reg refresh_reg0;
    reg keep_on_cnt_reg0 = 1;
    //����0�Ŷ�ʱ������
    
    
    //1�Ŷ�ʱ������
    reg [15:0] target_counter_reg1;//0�Ŷ�ʱ�� ��ֵ�Ĵ���
    wire [15:0] state_reg1;//0�Ŷ�ʱ�� ״̬�Ĵ���
    reg [15:0] function_reg1;//0�Ŷ�ʱ�� ��ʽ�Ĵ���
    reg [15:0] cur_value_reg1;//0�Ŷ�ʱ�� ��ǰ����ֵ
    reg timer1_mode;//��ʾ0�Ŷ�ʱ����ǰ������ʽ 0��ʾ����  1��ʾ��ʱ
    reg [15:0] cur_cnt_value_reg1; // 0�Ŷ�ʱ���ļ����Ĵ���
    reg run_one_period1 = 1; //����һ��ѭ�����ʱ�Ƿ���� ���һ��ѭ���������Ļ� ��bitΪ0
    reg state1_wire_15Cnt=0;
    reg state1_wire_15Timer=0;
    wire state1_wire_15;
    reg state1_wire_1=0;
    reg state1_wire_0=0;
    assign state1_wire_15 = state1_wire_15Cnt | state1_wire_15Timer; //15�Ź���״ָ̬ʾλ
    assign state_reg1[15:0] = {state1_wire_15,13'd0,state1_wire_1,state1_wire_0};
    reg refresh_reg1;
    reg keep_on_cnt_reg1 = 1;
    //����1�Ŷ�ʱ������
    
    always @(posedge Clk) //Ҫ����ʱ�ӱ������� ��������ʱû�п���
    begin
        if(Cs==1'b1)//ѡ������
        begin
            if(Iow==1'b1)//д�Ĵ�������
                begin
                    case(Address[2:0])
                        3'b000: begin
                                    function_reg0[15:0] = Wdata[15:0]; //д0�Ŷ�ʱ���ķ�ʽ�Ĵ���
                                    refresh_reg0 = 1;
                                    //�������Ǳ�ڵ�bug  ����趨Ϊ��ѭ��ģʽ ��ôһ�ι�����ɺ󽫻��޷������ڶ��ι���
                                    //��Ҫ������ÿ�μ�⵽д��ʽ�Ĵ�����ʱ����� ʹ�ܹ���λ keep_on_xx_reg0 Ϊ1 ������һ������
                                    //��Ҫ������ÿ�μ�⵽д��ʽ�Ĵ�����ʱ����� ʹ�ܹ���λ keep_on_xx_reg0 Ϊ1 ������һ������
                                end
                        3'b010: begin
                                    function_reg1[15:0] = Wdata[15:0]; //д1�Ŷ�ʱ���ķ�ʽ�Ĵ���
                                    refresh_reg1 = 1;
                                end
                        3'b100: begin
                                    target_counter_reg0[15:0] = Wdata[15:0] ; //д0�Ŷ�ʱ���ĳ�ֵ�Ĵ���
                                    refresh_reg0 = 1;
                                end
                        3'b110: begin
                                    target_counter_reg1[15:0] = Wdata[15:0] ; //д1�Ŷ�ʱ���ĳ�ֵ�Ĵ���
                                    refresh_reg1 = 1;
                                end
                    endcase
                end
            else if(Ior == 1'b1)//���Ĵ�������
                begin
                    case(Address[2:0])//�жϼĴ�����ַ
                        3'b000: begin //����ʱ��0��״̬�Ĵ���
                                      Rdata[15:0] = state_reg0[15:0] ; //��0�Ŷ�ʱ����״̬�Ĵ���
                                      state0_wire_1 = 0; state0_wire_0=0;//state_reg0[14:0] = 0;//��������Ĵ��� ���������λ�鿴�Ƿ�ʼ����
                                end
                        3'b010: begin //����ʱ��1��״̬�Ĵ���
                                      Rdata[15:0] = state_reg1[15:0] ; //��1�Ŷ�ʱ����״̬�Ĵ���
                                      state1_wire_1 = 0; state1_wire_0=0;//��������Ĵ��� ���������λ�鿴�Ƿ�ʼ����
                                end
                        3'b100:begin //����ʱ��0�ĵ�ǰֵ�Ĵ���
                                      Rdata[15:0] = cur_value_reg0[15:0];
                               end
                        3'b110:begin //����ʱ��1�ĵ�ǰֵ�Ĵ���
                                      Rdata[15:0] = cur_value_reg1[15:0];
                               end
                    endcase
                end
        end
    end

   
    always @(posedge Pulse0 or negedge Reset)//��ʱ��0����ģʽ
    begin
        if(Reset == 1'b0)
            begin
                state0_wire_15Cnt = 1'b0;//��������ָʾλ  
                cur_cnt_value_reg0[15:0] = 0;  
                keep_on_cnt_reg0 = 1;          
            end
        else//Pulse0 == 1'b1 
            begin
                if(function_reg0[0]==1'b1 && keep_on_cnt_reg0==1'b1)//����һ������ ���ҵ�ǰ�Ǽ���ģʽ
                begin
                    if( cur_cnt_value_reg0[15:0] < target_counter_reg0[15:0] )
                        begin
                            cur_cnt_value_reg0 = cur_cnt_value_reg0 + 1; //ÿ��һ������ ��������
                            state0_wire_15Cnt = 1'b1;    //������״̬λ��ֵ1
                            state0_wire_1 = 0; //����δ��
                        end
                    else
                        begin
                            cur_cnt_value_reg0 = 0;
                            state0_wire_1 = 1; //������
                            if(function_reg0[1] == 1'b0)//�жϵ�ǰ�Ƿ���ѭ��ģʽ
                                begin
                                    keep_on_cnt_reg0 = 0;
                                    state0_wire_15Cnt = 1'b0;//һ��ѭ������ û���´�ѭ�� �趨����״̬��Ϊ0
                                end
                            else
                                begin
                                    keep_on_cnt_reg0 = 1;
                                    state0_wire_15Cnt = 1'b1;//һ��ѭ������ �����´�ѭ�� �趨����״̬Ϊ1
                                end
                        end
                end
            end
     end

    
    always @(posedge Clk or negedge Reset)//��ʱ��0 ��ʱ����
    begin
        if(Reset == 1'b0)
            begin
                Cout0 = 1;//������ʱ��ȱʡ���Ϊ�ߵ�ƽ �����ֶ�ʱ�ж�ʱ�͵�ƽ
                state0_wire_15Timer = 1'b0;//��������ָʾλ
                state0_wire_0 = 1'b0;//��ʱ��ָʾλ
                run_one_period0 = 1;
                cur_value_reg0[15:0]=0;
            end
        else if(refresh_reg0 ==  1'b1)//ˢ�µ�ǰ��ʱ����ֵ
            begin
                cur_value_reg0[15:0]=target_counter_reg0[15:0];
                run_one_period0 = 1;
                refresh_reg0 = 0;
            end
        else
            begin
                if(function_reg0[0]==1'b0 && run_one_period0==1'b1) //��ʽ�Ĵ���0��ʾ��ʱ 1��ʾ����
                    begin
                        //��ʱ��ģʽ  ��������һһֱ��1 Ȼ������״̬λΪ1 cout���һ���͵�ƽ����
                        if(cur_value_reg0[15:0]>16'd1)
                            begin
                                Cout0 = 1;
                                cur_value_reg0[15:0] = cur_value_reg0[15:0] - 1;
                                state0_wire_15Timer = 1'b1;//���λΪ1 ��ʾ���ڼ������߶�ʱ
                            end
                        else if(cur_value_reg0[15:0] == 16'd1)
                            begin
                                Cout0 = 0;//���һ���͵�ƽ
                                cur_value_reg0[15:0] = cur_value_reg0[15:0] - 1;
                                state0_wire_0 = 1'b1;//���λ����Ϊ1 ��ʾ��ʱ��
                            end
                        else
                            begin
                                Cout0 = 1;
                                cur_value_reg0[15:0] = target_counter_reg0[15:0];//����ֵ�Ĵ�����ֵ����ǰֵ�Ĵ���
                                //state0_wire_0 = 1'b0;//����0bitΪ1 ��ʾ��һ�μ������
                                if(function_reg0[1]==1'b0)
                                    run_one_period0 = 1'b0;//ֻ����һ�ξ�ֹͣ
                                else
                                    run_one_period0 = 1'b1;//����ѭ������
                            end
                    end
                 else if(run_one_period0 == 1'b0)//run_one_period0 == 0 ��ʾ����������
                    begin
                        state0_wire_15Timer = 1'b0;//��ʾĿǰ��������
                    end
            end
    end

    always @(posedge Pulse1 or negedge Reset)//��ʱ��0����ģʽ
    begin
        if(Reset == 1'b0)
            begin
                state1_wire_15Cnt = 1'b0;//��������ָʾλ  
                cur_cnt_value_reg1[15:0] = 0;  
                keep_on_cnt_reg1 = 1;          
            end
        else//Pulse0 == 1'b1 
            begin
                if(function_reg1[0]==1'b1 && keep_on_cnt_reg1==1'b1)//����һ������ ���ҵ�ǰ�Ǽ���ģʽ
                begin
                    if( cur_cnt_value_reg1[15:0] < target_counter_reg1[15:0] )
                        begin
                            cur_cnt_value_reg1 = cur_cnt_value_reg1 + 1; //ÿ��һ������ ��������
                            state1_wire_15Cnt = 1'b1;    //������״̬λ��ֵ1
                            state1_wire_1 = 0; //����δ��
                        end
                    else
                        begin
                            cur_cnt_value_reg1 = 0;
                            state1_wire_1 = 1; //������
                            if(function_reg1[1] == 1'b0)//�жϵ�ǰ�Ƿ���ѭ��ģʽ
                                begin
                                    keep_on_cnt_reg1 = 0;
                                    state1_wire_15Cnt = 1'b0;//һ��ѭ������ û���´�ѭ�� �趨����״̬��Ϊ0
                                end
                            else
                                begin
                                    keep_on_cnt_reg1 = 1;
                                    state1_wire_15Cnt = 1'b1;//һ��ѭ������ �����´�ѭ�� �趨����״̬Ϊ1
                                end
                        end
                end
            end
     end

    
    always @(posedge Clk or negedge Reset)//��ʱ��0 ��ʱ����
    begin
        if(Reset == 1'b0)
            begin
                Cout1 = 1;//������ʱ��ȱʡ���Ϊ�ߵ�ƽ �����ֶ�ʱ�ж�ʱ�͵�ƽ
                state1_wire_15Timer = 1'b0;//��������ָʾλ
                state1_wire_0 = 1'b0;//��ʱ��ָʾλ
                run_one_period1 = 1;
                cur_value_reg1[15:0]=0;
            end
        else if(refresh_reg1 ==  1'b1)//ˢ�µ�ǰ��ʱ����ֵ
            begin
                cur_value_reg1[15:0]=target_counter_reg1[15:0];
                run_one_period1 = 1;
                refresh_reg1 = 0;
            end
        else
            begin
                if(function_reg1[0]==1'b0 && run_one_period1==1'b1) //��ʽ�Ĵ���0��ʾ��ʱ 1��ʾ����
                    begin
                        //��ʱ��ģʽ  ��������һһֱ��1 Ȼ������״̬λΪ1 cout���һ���͵�ƽ����
                        if(cur_value_reg1[15:0]>16'd1)
                            begin
                                Cout1 = 1;
                                cur_value_reg1[15:0] = cur_value_reg1[15:0] - 1;
                                state1_wire_15Timer = 1'b1;//���λΪ1 ��ʾ���ڼ������߶�ʱ
                            end
                        else if(cur_value_reg1[15:0] == 16'd1)
                            begin
                                Cout1 = 0;//���һ���͵�ƽ
                                cur_value_reg1[15:0] = cur_value_reg1[15:0] - 1;
                                state1_wire_0 = 1'b1;//���λ����Ϊ1 ��ʾ��ʱ��
                            end
                        else
                            begin
                                Cout1 = 1;
                                cur_value_reg1[15:0] = target_counter_reg1[15:0];//����ֵ�Ĵ�����ֵ����ǰֵ�Ĵ���
                                //state0_wire_0 = 1'b0;//����0bitΪ1 ��ʾ��һ�μ������
                                if(function_reg1[1]==1'b0)
                                    run_one_period1 = 1'b0;//ֻ����һ�ξ�ֹͣ
                                else
                                    run_one_period1 = 1'b1;//����ѭ������
                            end
                    end
                 else if(run_one_period1 == 1'b0)//run_one_period0 == 0 ��ʾ����������
                    begin
                        state1_wire_15Timer = 1'b0;//��ʾĿǰ��������
                    end
            end
    end



endmodule
