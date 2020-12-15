`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 08:39:02
// Design Name: 
// Module Name: reg_file
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

// 一次记录或读取1个5位八进制数
module reg_file(
    input [7:0] address,
    input [2:0] data_i_0,
    input [2:0] data_i_1,
    input [2:0] data_i_2,
    input [2:0] data_i_3,
    input [2:0] data_i_4,
    input write_en,
    input read_en,
    input rst,
    output [2:0] data_o_0,
    output [2:0] data_o_1,
    output [2:0] data_o_2,
    output [2:0] data_o_3,
    output [2:0] data_o_4
    );

    reg [4:0] write = 5'b00000;
    reg [4:0] read = 5'b00000;

    // 接受从寄存器模块传出的数据
    wire [2:0] data_o_0_0;
    wire [2:0] data_o_0_1;
    wire [2:0] data_o_0_2;
    wire [2:0] data_o_0_3;
    wire [2:0] data_o_0_4;
    wire [2:0] data_o_1_0;
    wire [2:0] data_o_1_1;
    wire [2:0] data_o_1_2;
    wire [2:0] data_o_1_3;
    wire [2:0] data_o_1_4;
    wire [2:0] data_o_2_0;
    wire [2:0] data_o_2_1;
    wire [2:0] data_o_2_2;
    wire [2:0] data_o_2_3;
    wire [2:0] data_o_2_4;
    wire [2:0] data_o_3_0;
    wire [2:0] data_o_3_1;
    wire [2:0] data_o_3_2;
    wire [2:0] data_o_3_3;
    wire [2:0] data_o_3_4;
    wire [2:0] data_o_4_0;
    wire [2:0] data_o_4_1;
    wire [2:0] data_o_4_2;
    wire [2:0] data_o_4_3;
    wire [2:0] data_o_4_4;

    // 5个下级存储器，分别存储5个数字
    reg_5_3 reg_0(data_i_0, data_i_1, data_i_2, data_i_3, data_i_4, write[0], read[0], rst, data_o_0_0, data_o_0_1, data_o_0_2, data_o_0_3, data_o_0_4);
    reg_5_3 reg_1(data_i_0, data_i_1, data_i_2, data_i_3, data_i_4, write[1], read[1], rst, data_o_1_0, data_o_1_1, data_o_1_2, data_o_1_3, data_o_1_4);
    reg_5_3 reg_2(data_i_0, data_i_1, data_i_2, data_i_3, data_i_4, write[2], read[2], rst, data_o_2_0, data_o_2_1, data_o_2_2, data_o_2_3, data_o_2_4);
    reg_5_3 reg_3(data_i_0, data_i_1, data_i_2, data_i_3, data_i_4, write[3], read[3], rst, data_o_3_0, data_o_3_1, data_o_3_2, data_o_3_3, data_o_3_4);
    reg_5_3 reg_4(data_i_0, data_i_1, data_i_2, data_i_3, data_i_4, write[4], read[4], rst, data_o_4_0, data_o_4_1, data_o_4_2, data_o_4_3, data_o_4_4);

    // 选择以读取
    selector_51 selector0(clk, data_o_0_0, data_o_1_0, data_o_2_0, data_o_3_0, data_o_4_0, read, data_o_0);
    selector_51 selector1(clk, data_o_0_1, data_o_1_1, data_o_2_1, data_o_3_1, data_o_4_1, read, data_o_1);
    selector_51 selector2(clk, data_o_0_2, data_o_1_2, data_o_2_2, data_o_3_2, data_o_4_2, read, data_o_2);
    selector_51 selector3(clk, data_o_0_3, data_o_1_3, data_o_2_3, data_o_3_3, data_o_4_3, read, data_o_3);
    selector_51 selector4(clk, data_o_0_4, data_o_1_4, data_o_2_4, data_o_3_4, data_o_4_4, read, data_o_4);    
    
    always @(*) begin
        if(rst == 1'b1) begin // 清零复位
            write = 5'b00000;
            read = 5'b00000;
        end  
        else begin
            if(write_en == 1'b1)  // 写入状态
                case(address)
                    8'b0000_0000: write = 5'b00001;
                    8'b0000_0001: write = 5'b00010;
                    8'b0000_0010: write = 5'b00100;
                    8'b0000_0011: write = 5'b01000;
                    8'b0000_0100: write = 5'b10000;
                    default: write = 5'b00000;
                endcase
            else write = 5'b00000;  // 写入读取不能同时进行
                if(read_en == 1'b1) begin
                    case(address)
                    8'b0000_0000: read = 5'b00001;
                    8'b0000_0001: read = 5'b00010;
                    8'b0000_0010: read = 5'b00100;
                    8'b0000_0011: read = 5'b01000;
                    8'b0000_0100: read = 5'b10000;
                    default: read = 5'b00000;
                    endcase
                end
            else read = 5'b00000;
        end
    end

endmodule
