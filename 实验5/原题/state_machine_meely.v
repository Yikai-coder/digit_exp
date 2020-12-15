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

     // 状态编码
    parameter s0 = 3'b000;
    parameter s1 = 3'b001;
    parameter s2 = 3'b010;
    parameter s3 = 3'b011;
    parameter s4 = 3'b100;
    parameter s5 = 3'b101;
    parameter init = 3'b111;   // 复位状态
   // 现态与次态
    reg[2:0] current_state;
    reg[2:0] next_state;
    reg [2:0] counter;
    reg finish;  // 判断输入是否读取完毕
    wire din;   //将八位并行输入转为串行输入
    wire rst;  //将复位倒置符合规范
    
    assign din = data_i[counter]||rst;  //输入有数据data和复位rst决定
    assign rst = ~rst_i;   //rst倒置
    // 处理输出
    always @ (current_state, din) begin   // 根据现态来确定输出
        if(current_state == init)   // 初始状态
            detect_o = 1'b0;
        else if(current_state == s4)  // 检测到序列状态为s4
            if(finish == 1'b0)   // 得处于检测序列的状态
                if(din == 1'b1)
                    detect_o = 1'b1;
                else;
            else;
        else if(detect_o == 1'b1)  // 如果已经检测到想要的序列输出保持
            detect_o = detect_o;
        else
            detect_o = 1'b0;
    end

    // 将8位输入转换为1位输入依此进入状态机
    always @ (posedge clk_i or posedge rst) begin
        if(rst == 1'b1) begin  // rst触发
            finish <= 1'b0;
            counter <= 3'b000;
        end
        else if(clk_i == 1'b1) begin  // 时钟触发
            if(set_i == 1'b1) begin  //此时set按下,计数器置7，还没有完成读取
                counter <= 3'b111;
                finish <= 1'b0;
            end
            else if(counter == 3'b000) begin  //已经把所有输入都读取过一次了，计数器保持，完成读取
                counter <= 3'b000;
                finish <= 1'b1;
            end
            else                         // 正常情况下往后读取一位
                counter <= counter - 1'b1;
        end
        else;
    end
    // 状态转移 给next_state赋值
    always @ (current_state, din, finish, rst) begin
        if(finish == 1'b1)  // 如果输入序列全部读完,则无需再改次态
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
    // 状态变化 给current_state赋值
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
