`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 08:37:38
// Design Name: 
// Module Name: random_contributor
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


module random_contributor(
    input rst,
    input clk,
    input s0,
    output [2:0] random_data_0,
    output [2:0] random_data_1,
    output [2:0] random_data_2,
    output [2:0] random_data_3,
    output [2:0] random_data_4,
    output [7:0] address_output,
    output done
    );

    reg [2:0] seed_data_0 = 3'b000;  // 用于生成随机数的种子
    reg [2:0] seed_data_1 = 3'b000;
    reg [2:0] seed_data_2 = 3'b000;
    reg [2:0] seed_data_3 = 3'b000;
    reg [2:0] seed_data_4 = 3'b000;
    reg finish;
    reg [7:0] address = 8'b0000_0000;
    assign done = finish;
    assign address_output = address;

    // 处理seed_data的计算使之具有随机性
    always @(posedge clk or posedge rst) begin
        if(rst == 1'b1) begin
            seed_data_0 <= 3'b000;
            seed_data_1 <= 3'b000;
            seed_data_2 <= 3'b000;
            seed_data_3 <= 3'b000;
            seed_data_4 <= 3'b000;
        end
        else if(clk == 1'b1) begin 
            seed_data_0 <= seed_data_0 + 2'b01;
            seed_data_1 <= seed_data_0 + 2'b10;
            seed_data_2 <= seed_data_1 + 2'b11;
            seed_data_3 <= seed_data_2 + 2'b10;
            seed_data_4 <= seed_data_3 + 2'b10;
        end
        else;
    end

    // 处理address赋值，使之能够按照地址顺序产生5个5位8进制数
    always @(posedge clk or posedge rst or posedge s0) begin
        if(rst == 1'b1)
            address <= 8'b0000_0000;
        else if(s0 == 1'b1)
            address <= 8'b0000_0000;
        
        else 
            if(address == 8'b0000_0101)  // address取值0-4
                address <= address;
            else 
                address <= address + 1'b1;
    end

    // 处理finish赋值，控制LFSR工作
    always @(*) begin
        if(rst == 1'b1)
            finish = 1'b1;
        else if(s0 == 1'b1)
            finish = 1'b0;
        else begin
            if(address == 8'b0000_0101)
                finish = 1'b1;
            else
                finish = 1'b0;
        end

    end
    LFSR random_con_0(clk, ~finish, seed_data_0, random_data_0);
    LFSR random_con_1(clk, ~finish, seed_data_1, random_data_1);
    LFSR random_con_2(clk, ~finish, seed_data_2, random_data_2);
    LFSR random_con_3(clk, ~finish, seed_data_3, random_data_3);
    LFSR random_con_4(clk, ~finish, seed_data_4, random_data_4);
endmodule
