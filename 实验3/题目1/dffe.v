`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/05 09:03:58
// Design Name: 
// Module Name: dffe
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


module dffe(
    input clk_i,
    input clrn_i,
    input wen_i,
    input d_i,
    output reg q_o
    );
    
    always@(posedge clk_i or negedge  clrn_i) begin
    if( clrn_i == 0 )
        q_o <= 0;
    else
    begin
       if( wen_i == 0 )
            q_o <= d_i;
       else;
    end
    end           
endmodule
