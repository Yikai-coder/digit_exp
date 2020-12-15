`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 16:23:57
// Design Name: 
// Module Name: match
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
module match(
    input rst_i,
    input set_i,
    input [2:0] data_i,
    input [2:0] pattern_0,   
    input [2:0] pattern_1,   
    input [2:0] pattern_2,
    input [2:0] pattern_3,
    input [2:0] pattern_4,
    output reg success
    );

    wire match;
    reg [2:0] already = 3'b000;  // 记录当前输入了多少位，防止出错
    reg [14:0] shift_reg = 15'b000_0000_0000_0000;
    reg [14:0] expect_string = 15'b111_1111_1111;

    // 按下清零时修改目标串
    always @(negedge rst_i) begin
        expect_string <= {pattern_4, pattern_3, pattern_2, pattern_1, pattern_0}; 
    end

    // 修改文本串
    always @(posedge rst_i or posedge set_i) begin
        if(rst_i == 1'b1) begin
            shift_reg <= 15'b000_0000_0000_0000;
            already = 3'b000;
        end
        else if(set_i == 1'b1) begin
            shift_reg <= {data_i, shift_reg[14:3]};  // 字符串由rrrrriii组成，每次输入字符串向左移动
            already = (already == 3'b101)?already:already+1'b1;
        end
        else;
    end

    assign match = ((expect_string == shift_reg) & (already == 3'b101))?1'b1:1'b0; // 需要同时满足输入数量大于等于5和串相同

    // 给success赋值
    always @ (posedge match or posedge rst_i) begin
        if(rst_i == 1'b1)
            success = 1'b0;
        else if(match == 1'b1)
            success = 1'b1;
        else;
    end
endmodule
