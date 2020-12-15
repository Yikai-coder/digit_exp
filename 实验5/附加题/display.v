`timescale 1ns / 1ps
module display 
(
    input clk_i,
    input rst_i,
    input [3:0] counter_0,
    input [3:0] counter_1,
    input [3:0] counter_2,
    input [3:0] counter_3,
    output reg [7:0] led_cx_o,
    output reg [3:0] led_en_o
);

reg [1:0] selected = 2'b00;
wire [7:0] digit_data_0, digit_data_1, digit_data_2, digit_data_3;

// 将数据转换为数码管信号
digit_table transform_0(clk_i, rst_i, counter_0, digit_data_0);
digit_table transform_1(clk_i, rst_i, counter_1, digit_data_1);
digit_table transform_2(clk_i, rst_i, counter_2, digit_data_2);
digit_table transform_3(clk_i, rst_i, counter_3, digit_data_3);
// 依次显示四个位置 rst_i,
always @(posedge clk_i) begin
    if(clk_i == 1'b1) begin
        selected <= selected + 1'b1;   // 刚好用完4个状态，溢出刚好完成循环
        case(selected)
            2'b00: begin
                led_en_o <= 4'b1000;
                led_cx_o <= digit_data_0;
            end
            2'b01: begin
                led_en_o <= 4'b0100; 
                led_cx_o <=digit_data_1;
            end
            2'b10: begin
                led_en_o <= 4'b0010; 
                led_cx_o <= digit_data_2;
            end
            2'b11: begin
                led_en_o <= 4'b0001;
                led_cx_o <= digit_data_3;
            end
            default;
        endcase
    end
    else;
end
endmodule  //display