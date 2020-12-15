`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 08:39:30
// Design Name: 
// Module Name: reg_5_3
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

// 记录一个5位8进制数
module reg_5_3(
    input [2:0] data_i_0,
    input [2:0] data_i_1,
    input [2:0] data_i_2,
    input [2:0] data_i_3,
    input [2:0] data_i_4,
    input write_en,
    input read_en,
    input rst,
    output reg [2:0] data_o_0,
    output reg [2:0] data_o_1,
    output reg [2:0] data_o_2,
    output reg [2:0] data_o_3,
    output reg [2:0] data_o_4
    );

    reg [2:0] data_reg_0; // 分别记录5位
    reg [2:0] data_reg_1;
    reg [2:0] data_reg_2;
    reg [2:0] data_reg_3;
    reg [2:0] data_reg_4;

    always @(*) begin
        if(rst == 1'b1) begin  // 清零
            data_reg_0 <= 3'b000;
            data_reg_1 <= 3'b000;
            data_reg_2 <= 3'b000;
            data_reg_3 <= 3'b000;
            data_reg_4 <= 3'b000;
            data_o_0 <= 3'b000; 
            data_o_1 <= 3'b000;
            data_o_2 <= 3'b000;
            data_o_3 <= 3'b000;
            data_o_4 <= 3'b000;
        end 
        else begin
            if(write_en == 1'b1) begin  // 写入使能
                data_reg_0 <= data_i_0;
                data_reg_1 <= data_i_1;
                data_reg_2 <= data_i_2;
                data_reg_3 <= data_i_3;
                data_reg_4 <= data_i_4;
            end
            else;
            if(read_en == 1'b1) begin  // 读取使能
                data_o_0 <= data_reg_0;
                data_o_1 <= data_reg_1;
                data_o_2 <= data_reg_2;
                data_o_3 <= data_reg_3;
                data_o_4 <= data_reg_4;
            end
            else;
        end
    end
endmodule
