`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 

// Create Date: 2020/12/01 17:22:09
// Design Name: 
// Module Name: CPU
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
module CPU(
    input s0,
    input s1,
    input s2,
    input s3,
    input s4,
    input match,
    input clk,
    output [2:0] current_state
    );

    parameter init = 3'b000;  // 初始状态
    parameter state_1 = 3'b001; // 生成随机数并展示
    parameter state_2 = 3'b010; // 读取sw的值作为地址
    parameter state_3 = 3'b011;  // 将进入匹配机
    parameter state_4 = 3'b100;  // 匹配成功

    reg [2:0] state = init;

    assign current_state = state;

    // 状态转移
    always @(posedge clk) begin
        case(state)
            init: begin
                if(s4 == 1'b1)
                    state <= init;
                else if(s0 == 1'b1)
                    state <= state_1;
                else;
            end
            state_1: begin
                if(s4 == 1'b1)
                    state <= init;
                else if(s1 == 1'b1)
                    state <= state_2;
                else;
            end
            state_2: begin
                if(s4 == 1'b1)
                    state <= init;
                else if(s2 == 1'b1)
                    state <= state_3;
                else;
            end
            state_3: begin
                if(s4 == 1'b1)
                    state <= init;
                else if(match == 1'b1)
                    state <= state_4;
                else;
            end
            default;
        endcase
        if(s4 == 1'b1) state <= init;
    end
endmodule
