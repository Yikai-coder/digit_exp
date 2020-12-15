`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/12 16:42:41
// Design Name: 
// Module Name: greyCounter
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


module greyCounter(
    input clk_i,
    input rst_n_i,
    input en_i,
    output [3:0] grey_o
    );
    
    reg [3:0] counter = 4'b0000;
    always @ (posedge clk_i or negedge rst_n_i) begin
        if(rst_n_i == 0)        //清零
            counter = 4'b0000; 
        else if (clk_i == 1) begin
            if(en_i == 1)
                counter = (counter == 15)?0:counter+1;
            else
                counter = counter;
            end
        else;
    end
    assign grey_o = (counter>>1) ^ counter;    //将计数转换为格雷码
    
endmodule
