`timescale 10ns / 10ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/12 09:07:40
// Design Name: 
// Module Name: digit_tube
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


module digit_tube(
    input clk_i,
    input [7:0] sw,
    input s0,
    output reg [7:0] seg_data_0,
    output reg [7:0] seg_data_1,
    output reg [3:0] seg_cs_0,
    output reg [3:0] seg_cs_1  
    );
    
    reg rst = 1'b1;
    wire clk_in_1kHz;
    wire clk_in_2Hz;
    reg [3:0] class_0 = 0;      //�༶��
    reg [3:0] class_1 = 4;
    reg [3:0] number_0 = 1;     //ѧ��
    reg [3:0] number_1 = 9;
    reg [3:0] count_down = 10;   //����ʱ������
    reg [1:0] selected = 0;     //����������
    reg [3:0]input_number_0;
    reg [3:0]input_number_1;
    reg [3:0] led_pin;
    wire flag;   
  
    frequency_divider_1kHz clock_1kHZ(clk_i, rst, clk_in_1kHz);   //��Ƶ����,clk_in_1kHzΪ1kHz
    frequency_divider_2Hz clock_2Hz(clk_i, rst, clk_in_2Hz);      //��Ƶ����,clk_in_2HzΪ2Hz   
    key_filter clean_shake(clk_in_1kHz, s0, flag);    //����
    
    always @ (posedge clk_in_2Hz or posedge flag)                      //���Ƶ���ʱ
    begin
        if(flag == 1'b1)
            count_down <= 10;
        else
            count_down <= (count_down == 0)?10:count_down - 1;
    end
    
    always @ (posedge clk_in_1kHz)       //������ʾ
    begin
        selected <= (selected == 2'b11)? 0: selected + 1;     //ÿ����һ���������������һ�������
        case (selected)
          2'b00: begin 
             if(count_down == 10)     //��λ��ʱ���⿼��
               input_number_0 <= 3'b001;//input_number_0 = 3'b001;  
             else
                input_number_0 <= 3'b000; 
             input_number_1 <= class_0;
             seg_cs_0 <= 4'b0001;
             seg_cs_1 <= 4'b0001;
             end
          2'b01: begin
             if(count_down == 10)    //��λ��ʱ���⿼��
               input_number_0 <= 3'b000;
             else
               input_number_0 <= count_down;
             input_number_1 <= class_1;
             seg_cs_0 <= 4'b0010;
             seg_cs_1 <= 4'b0010;
             end
          2'b10: begin
             input_number_0 <= sw[7:4];
             input_number_1 <= number_0;
             seg_cs_0 <= 4'b0100;
             seg_cs_1 <= 4'b0100;
             end
          2'b11: begin
             input_number_0 <= sw[3:0];
             input_number_1 <= number_1;
             seg_cs_0 <= 4'b1000;
             seg_cs_1 <= 4'b1000;
             end
          default: begin
             seg_cs_0 <= 4'b1111;
             seg_cs_1 <= 4'b1111;
             end
          endcase
      end
    // ��Ҫ��ʾ������ת��Ϊ������ź�
    always@(*)
    begin
        case(input_number_0)
            4'b0000: seg_data_0 <= 8'b0011_1111;
            4'b0001: seg_data_0 <= 8'b0000_0110;
            4'b0010: seg_data_0 <= 8'b0101_1011;
            4'b0011: seg_data_0 <= 8'b0100_1111;
            4'b0100: seg_data_0 <= 8'b0110_0110;
            4'b0101: seg_data_0 <= 8'b0110_1101;
            4'b0110: seg_data_0 <= 8'b0111_1101;
            4'b0111: seg_data_0 <= 8'b0000_0111;
            4'b1000: seg_data_0 <= 8'b0111_1111;
            4'b1001: seg_data_0 <= 8'b0110_1111;
            4'b1010: seg_data_0 <= 8'b0111_0111;
            4'b1011: seg_data_0 <= 8'b1111_1100;
            4'b1100: seg_data_0 <= 8'b0101_1000;
            4'b1101: seg_data_0 <= 8'b0101_1110;
            4'b1110: seg_data_0 <= 8'b0111_1001;
            4'b1111: seg_data_0 <= 8'b0111_0001;
            default: seg_data_0 <= 8'b0000_0000;
            endcase
            
         case(input_number_1)
            4'b0000: seg_data_1 <= 8'b0011_1111;
            4'b0001: seg_data_1 <= 8'b0000_0110;
            4'b0010: seg_data_1 <= 8'b0101_1011;
            4'b0011: seg_data_1 <= 8'b0100_1111;
            4'b0100: seg_data_1 <= 8'b0110_0110;
            4'b0101: seg_data_1 <= 8'b0110_1101;
            4'b0110: seg_data_1 <= 8'b0111_1101;
            4'b0111: seg_data_1 <= 8'b0000_0111;
            4'b1000: seg_data_1 <= 8'b0111_1111;
            4'b1001: seg_data_1 <= 8'b0110_1111;
            4'b1010: seg_data_1 <= 8'b0111_0111;
            4'b1011: seg_data_1 <= 8'b1111_1100;
            4'b1100: seg_data_1 <= 8'b0101_1000;
            4'b1101: seg_data_1 <= 8'b0101_1110;
            4'b1110: seg_data_1 <= 8'b0111_1001;
            4'b1111: seg_data_1 <= 8'b0111_0001;
            default: seg_data_1 <= 8'b0000_0000;
            endcase
        if(seg_cs_1 == 4'b0010)    //��С����
            seg_data_1[7] <= 1'b1;
        else if(seg_cs_1 == 4'b1000)
            seg_data_1[7] <= 1'b1;
        else;
    end

endmodule
