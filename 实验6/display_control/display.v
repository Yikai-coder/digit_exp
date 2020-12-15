`timescale 1ns / 1ps
module display 
(
    input clk_i,
    input [3:0] data_0,
    input [3:0] data_1,
    input [3:0] data_2,
    input [3:0] data_3,
    input en_0, 
    input en_1,
    input en_2,
    input en_3,
    output reg [7:0] led_cx_o,
    output reg [3:0] led_en_o
);

reg [1:0] selected = 2'b00;
wire [7:0] digit_data_0, digit_data_1, digit_data_2, digit_data_3;

// 将数据转换为数码管信号
digit_table transform_0(clk_i, en_0, data_0, digit_data_0);
digit_table transform_1(clk_i, en_1, data_1, digit_data_1);
digit_table transform_2(clk_i, en_2, data_2, digit_data_2);
digit_table transform_3(clk_i, en_3, data_3, digit_data_3);
// 依次显示四个位置 rst_i,
always @(posedge clk_i) begin
    if(clk_i == 1'b1) begin
        selected <= selected + 1'b1;   // 刚好用完4个状态，溢出刚好完成循环
        case(selected)
            2'b00: begin
                led_en_o <= {en_0, 3'b000};
                led_cx_o <= digit_data_0;
            end
            2'b01: begin
                led_en_o <= {1'b0, en_1, 2'b00}; 
                led_cx_o <=digit_data_1;
            end
            2'b10: begin
                led_en_o <= {2'b00, en_2, 1'b0}; 
                led_cx_o <= digit_data_2;
            end
            2'b11: begin
                led_en_o <= {3'b000, en_3};
                led_cx_o <= digit_data_3;
            end
            default;
        endcase
    end
    else;
end
endmodule  //display