`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/19 09:09:30
// Design Name: 
// Module Name: state_machine_meely
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
module state_machine_meely(
    input rst_i,
    input clk_i,
    input set_i,
    input [7:0] data_i,
    output reg detect_o
    );

     // ״̬����
    parameter s0 = 3'b000;
    parameter s1 = 3'b001;
    parameter s2 = 3'b010;
    parameter s3 = 3'b011;
    parameter s4 = 3'b100;
    parameter s5 = 3'b101;
    parameter init = 3'b111;   // ��λ״̬
   // ��̬���̬
    reg[2:0] current_state;
    reg[2:0] next_state;
    reg [2:0] counter;
    reg finish;  // �ж������Ƿ��ȡ���
    wire din;   //����λ��������תΪ��������
    wire rst;  //����λ���÷��Ϲ淶
    
    assign din = data_i[counter]||rst;  //����������data�͸�λrst����
    assign rst = ~rst_i;   //rst����
    // �������
    always @ (current_state, din) begin   // ������̬��ȷ�����
        if(current_state == init)   // ��ʼ״̬
            detect_o = 1'b0;
        else if(current_state == s4)  // ��⵽����״̬Ϊs4
            if(finish == 1'b0)   // �ô��ڼ�����е�״̬
                if(din == 1'b1)
                    detect_o = 1'b1;
                else;
            else;
        else if(detect_o == 1'b1)  // ����Ѿ���⵽��Ҫ�������������
            detect_o = detect_o;
        else
            detect_o = 1'b0;
    end

    // ��8λ����ת��Ϊ1λ�������˽���״̬��
    always @ (posedge clk_i or posedge rst) begin
        if(rst == 1'b1) begin  // rst����
            finish <= 1'b0;
            counter <= 3'b000;
        end
        else if(clk_i == 1'b1) begin  // ʱ�Ӵ���
            if(set_i == 1'b1) begin  //��ʱset����,��������7����û����ɶ�ȡ
                counter <= 3'b111;
                finish <= 1'b0;
            end
            else if(counter == 3'b000) begin  //�Ѿ����������붼��ȡ��һ���ˣ����������֣���ɶ�ȡ
                counter <= 3'b000;
                finish <= 1'b1;
            end
            else                         // ��������������ȡһλ
                counter <= counter - 1'b1;
        end
        else;
    end
    // ״̬ת�� ��next_state��ֵ
    always @ (current_state, din, finish, rst) begin
        if(finish == 1'b1)  // �����������ȫ������,�������ٸĴ�̬
            next_state = next_state;
        else if(rst == 1'b1)
            next_state = init;
        else begin
            case(current_state)
                init: next_state = (din == 1'b0)?s0:s1;  
                s0: next_state = (din == 1'b0)?s0:s2;
                s1: next_state = (din == 1'b0)?s0:s1;
                s2: next_state = (din == 1'b0)?s3:s1;
                s3: next_state = (din == 1'b0)?s0:s4;
                s4: next_state = (din == 1'b0)?s3:s5;
                s5: next_state = (din == 1'b0)?s0:s1;
            default: next_state = init;
            endcase
        end
    end
    // ״̬�仯 ��current_state��ֵ
    always @ (posedge clk_i 
              or posedge rst) begin
        if(rst == 1'b1)
            current_state <= init;
        else if(clk_i == 1'b1) begin
            if(set_i == 1'b1)
                current_state <= init;
            else
                current_state <= next_state;    
        end
    end
endmodule
