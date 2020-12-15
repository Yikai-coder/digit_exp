`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/19 17:53:10
// Design Name: 
// Module Name: state_machine_moor
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
module state_machine_2(
    input rst_i,
    input clk_i,
    input set_i,
    input data_i,
    output [7:0] ledcx_o,
    output [3:0] leden_o
    );
    
    // 添加一位状态编码用于触发输出变化
    parameter s0 = 4'b0000;
    parameter s1 = 4'b0001;
    parameter s2 = 4'b010;
    parameter s3 = 4'b0011;
    parameter s4 = 4'b0100;
    parameter s5 = 4'b1101;   // 仅s5最高位为1，用于触发输出变化
    parameter init = 4'b0111;   // 复位状态
    // 现态与次态
    reg[3:0] current_state;
    reg[3:0] next_state;
    reg [3:0] counter_0;  // 记录读取到多少次,个位
    reg [3:0] counter_1;  //十位
    reg [3:0] counter_2; //百位
    reg [3:0] counter_3;  //千位
    reg din;   //将八位并行输入转为串行输入
    wire rst_i_filter;
    wire set_i_filter;
    wire rst;  //将复位倒置符合规范
    
    assign rst = ~rst_i;   //rst倒置

    frequency_divider_1KHz clock(clk_i, 1'b1, clk);
    display showdata(clk_i, rst_i_filter, counter_0, counter_1, counter_2, counter_3, ledcx_o, leden_o);  // 仿真需要，改回clk_i
    key_filter filter_1(clk_i, rst, rst_i_filter);
    key_filter filter_2(clk_i, set_i, set_i_filter); 
    // 处理输入
    always @(posedge set_i_filter or posedge rst_i_filter) begin
        if(rst_i_filter == 1'b1)  // 清零
            din = 1'b1;
        else if(set_i_filter == 1'b1)  // 按下set读取一位
            din = data_i;
        else;
    end

    always @ (posedge rst_i_filter, posedge next_state[3]) begin   // 根据复位上升沿和next_state最高位触发，使用next_state触发防止慢一拍
        if(rst_i_filter == 1'b1) begin
            counter_0 = 4'b0000;
            counter_1 = 4'b0000;
            counter_2 = 4'b0000;
            counter_3 = 4'b0000;   
        end
        else if(next_state[3] == 1'b1)  // moor型
            if(counter_0 == 4'b1001)  //从后往前进位 xxx9
                if(counter_1 == 4'b1001)   //xx99
                    if(counter_2 == 4'b1001)  //x999
                        if(counter_3 == 4'b1001) begin //9999
                            counter_0 = 4'b0000;
                            counter_1 = 4'b0000;
                            counter_2 = 4'b0000;
                            counter_3 = 4'b0000;
                        end
                        else begin //x999
                            counter_0 = 4'b0000;
                            counter_1 = 4'b0000;  
                            counter_2 = 4'b0000;
                            counter_3 = counter_3 + 4'b0001;
                        end
                    else begin //xx99
                        counter_3 = counter_3;
                        counter_2 = counter_2 + 4'b0001;
                        counter_1 = 4'b0000;
                        counter_0 = 4'b0000;
                    end
                else begin //xxx9
                    counter_3 = counter_3;
                    counter_2 = counter_2;
                    counter_1 = counter_1 + 4'b0001;
                    counter_0 = 4'b0000;
                end
            else begin
                counter_3 = counter_3;
                counter_2 = counter_2;
                counter_1 = counter_1; 
                counter_0 = counter_0 + 4'b0001;              
            end
        else begin  // 不处于s5
            counter_3 = counter_3;
            counter_2 = counter_2;
            counter_1 = counter_1;
            counter_0 = counter_0; 
        end
    end

    // 状态转移 给next_state赋值
    always @ (*) begin
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

    // 状态变化 给current_state赋值
    always @ (posedge set_i_filter or posedge rst_i_filter) begin
        if(rst_i_filter == 1'b1)
            current_state <= init;
        else if(set_i_filter == 1'b1)
            current_state <= next_state;   
        else;
    end
endmodule
