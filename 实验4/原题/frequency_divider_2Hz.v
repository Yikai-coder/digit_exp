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
module frequency_divider_2Hz(
    input clk_i,
    input rst_i,
    output reg clk_o
    );
    reg [25:0] cnk = 0;
    reg clk = 1'b0;
    always @ (posedge clk_i or negedge rst_i)
    begin
        if(rst_i == 1'b0)
            cnk <= 0;
        else if( clk_i == 1'b1)
            if(cnk == 24999999) //2Hz  24999999 n = T_want/(2*T_ori) - 1 
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
