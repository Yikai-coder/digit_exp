`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/02 10:37:24
// Design Name: 
// Module Name: display_control
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
module display_control(
    input clk,
    input [2:0] state,
    input [3:0]data_0,
    input [3:0]data_1,    
    input [3:0]data_2,
    input [3:0]data_3,
    input [3:0]data_4,
    input [3:0]data_5,
    input [3:0]data_6,
    input [3:0]data_7,
    output [7:0] led_cx_o_0,
    output [3:0] led_en_o_0,
    output [7:0] led_cx_o_1,
    output [3:0] led_en_o_1
    );

    reg [3:0] display_data_0 = 4'b0000;
    reg [3:0] display_data_1 = 4'b0000;
    reg [3:0] display_data_2 = 4'b0000;
    reg [3:0] display_data_3 = 4'b0000;
    reg [3:0] display_data_4 = 4'b0000;
    reg [3:0] display_data_5 = 4'b0000;
    reg [3:0] display_data_6 = 4'b0000;
    reg [3:0] display_data_7 = 4'b0000;
    wire clk_2Hz;
    wire clk_1Hz;
    wire clk_4Hz;

    reg en_0 = 1'b0;  // 控制八个数码管是否显示
    reg en_1 = 1'b0;
    reg en_2 = 1'b0;
    reg en_3 = 1'b0;
    reg en_4 = 1'b0;
    reg en_5 = 1'b0;
    reg en_6 = 1'b0;
    reg en_7 = 1'b0;    

    parameter init = 3'b000;  // 初始状态
    parameter state_1 = 3'b001; // 生成随机数并展示
    parameter state_2 = 3'b010; // 读取sw的值作为地址
    parameter state_3 = 3'b011;  // 将进入匹配机
    parameter state_4 = 3'b100;  // 匹配成功
    reg on = 1'b0;  // 控制8个0闪烁

    display show_0(clk_1kHz, display_data_0, display_data_1, display_data_2, display_data_3, en_0, en_1, en_2, en_3, led_cx_o_0, led_en_o_0);  
    display show_1(clk_1kHz, display_data_4, display_data_5, display_data_6, display_data_7, en_4, en_5, en_6, en_7, led_cx_o_1, led_en_o_1);
    frequency_divider_4Hz clock_4Hz(clk, 1'b1, clk_4Hz);
    frequency_divider_1KHz clock_1kHz(clk, 1'b1, clk_1kHz);

    // 根据当前所处的不同状态来选择不同的显示模式
    always @(posedge clk) begin
        case(state)
            init: begin  // 初始状态全部显示0
                display_data_0 <= 4'b0000;
                display_data_1 <= 4'b0000;
                display_data_2 <= 4'b0000;
                display_data_3 <= 4'b0000;
                display_data_4 <= 4'b0000;
                display_data_5 <= 4'b0000;
                display_data_6 <= 4'b0000;
                display_data_7 <= 4'b0000;
                en_0 <= 1'b1;
                en_1 <= 1'b1;
                en_2 <= 1'b1;
                en_3 <= 1'b1;
                en_4 <= 1'b1;
                en_5 <= 1'b1;
                en_6 <= 1'b1;
                en_7 <= 1'b1;
            end
            state_1: begin
                display_data_0 <= data_0; 
                display_data_1 <= data_1;
                display_data_2 <= data_2;
                display_data_3 <= data_3;
                display_data_4 <= data_4;
                display_data_5 <= data_5;
                display_data_6 <= data_6;
                display_data_7 <= data_7;
                en_0 <= 1'b0;
                en_1 <= 1'b0;
                en_2 <= 1'b0;
                en_3 <= 1'b1;
                en_4 <= 1'b1;
                en_5 <= 1'b1;
                en_6 <= 1'b1;
                en_7 <= 1'b1;
            end
            state_2: begin
                if(data_7 > 4'b0100) begin   // 如果输入的地址大于4
                    display_data_0 <= 4'b1111;
                    display_data_1 <= 4'b1111;
                    display_data_2 <= 4'b1111;
                    display_data_3 <= 4'b1111;
                    display_data_4 <= 4'b1111;
                    display_data_5 <= 4'b1111;
                    display_data_6 <= 4'b1111;
                    display_data_7 <= 4'b1111;
                end
                else begin
                    display_data_0 <= 4'b0000;
                    display_data_1 <= 4'b0000;
                    display_data_2 <= 4'b0000;
                    display_data_3 <= 4'b0000;
                    display_data_4 <= 4'b0000;
                    display_data_5 <= 4'b0000;
                    display_data_6 <= 4'b0000;
                    display_data_7 <= data_7;
                end
                en_0 <= 1'b1;
                en_1 <= 1'b1;
                en_2 <= 1'b1;
                en_3 <= 1'b1;
                en_4 <= 1'b1;
                en_5 <= 1'b1;
                en_6 <= 1'b1;
                en_7 <= 1'b1;
            end
            state_3: begin
                display_data_0 <= 4'b0000;
                display_data_1 <= 4'b0000;
                display_data_2 <= 4'b0000;
                display_data_3 <= 4'b0000;
                display_data_4 <= 4'b0000;
                display_data_5 <= 4'b0000;
                display_data_6 <= 4'b0000;
                display_data_7 <= 4'b0000;
                if(on == 1'b1) begin
                    en_0 <= 1'b1;
                    en_1 <= 1'b1;
                    en_2 <= 1'b1;
                    en_3 <= 1'b1;
                    en_4 <= 1'b1;
                    en_5 <= 1'b1;
                    en_6 <= 1'b1;
                    en_7 <= 1'b1;
                end
                else begin
                    en_0 <= 1'b0;
                    en_1 <= 1'b0;
                    en_2 <= 1'b0;
                    en_3 <= 1'b0;
                    en_4 <= 1'b0;
                    en_5 <= 1'b0;
                    en_6 <= 1'b0;
                    en_7 <= 1'b0;
                end
            end
            state_4: begin
                display_data_0 <= data_0; 
                display_data_1 <= data_1;
                display_data_2 <= 4'b1110;
                display_data_3 <= data_3;
                display_data_4 <= data_4;
                display_data_5 <= data_5;
                display_data_6 <= data_6;
                display_data_7 <= data_7;
                en_0 <= 1'b0;
                en_1 <= 1'b1;
                en_2 <= 1'b1;
                en_3 <= 1'b1;
                en_4 <= 1'b1;
                en_5 <= 1'b1;
                en_6 <= 1'b1;
                en_7 <= 1'b1;    
            end
            default;
        endcase
    end

    // 专门用于实现4Hz不断闪烁的0
    always @(posedge clk_4Hz) begin
        on = ~on;
    end
endmodule
