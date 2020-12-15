`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/12 18:45:19
// Design Name: 
// Module Name: frequency_divider_2Hz
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
module frequency_divider_1Hz(
    input clk_i,
    input rst_i,
    output reg clk_o
    );
    reg [27:0] cnk = 0;
    reg clk = 1'b0;
    always @ (posedge clk_i or negedge rst_i)
    begin
        if(rst_i == 1'b0) begin
            cnk <= 0;
            clk <= 1'b0;
        end
        else if( clk_i == 1'b1)
            if(cnk == 28'b0010_1111_1010_1111_0000_1000_0000) //2Hz  24999999 n = T_want/(2*T_ori) - 1  28'b0010_1111_1010_1111_0000_1000_0000
                begin
                    cnk <= 0;
                    clk <= !clk;
                end
            else
                cnk <= cnk + 1;
         else;
     clk_o <= clk;
     end
    
endmodule
