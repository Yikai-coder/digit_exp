`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/05 09:03:58
// Design Name: 
// Module Name: reg8
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


module reg8(
    input clk_i,
    input clrn_i,
    input wen_i,
    input [7:0] d_i,
    output [7:0] q_o
    );
    
    dffe dffe_0(clk_i, clrn_i, wen_i, d_i[0], q_o[0]);
    dffe dffe_1(clk_i, clrn_i, wen_i, d_i[1], q_o[1]);
    dffe dffe_2(clk_i, clrn_i, wen_i, d_i[2], q_o[2]);
    dffe dffe_3(clk_i, clrn_i, wen_i, d_i[3], q_o[3]);
    dffe dffe_4(clk_i, clrn_i, wen_i, d_i[4], q_o[4]);
    dffe dffe_5(clk_i, clrn_i, wen_i, d_i[5], q_o[5]);
    dffe dffe_6(clk_i, clrn_i, wen_i, d_i[6], q_o[6]);
    dffe dffe_7(clk_i, clrn_i, wen_i, d_i[7], q_o[7]);

endmodule
