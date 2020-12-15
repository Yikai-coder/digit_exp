`timescale 10ns / 10ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/11 18:51:10
// Design Name: 
// Module Name: counter
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
module frequency_divider_1kHz(
    input clk_i,
    input rst_i,
    output reg clk_o
    );
    reg [16:0] cnk = 0;
    reg clk = 1'b0;
    always @ (posedge clk_i or negedge rst_i)
    begin
        if(rst_i == 1'b0)
            cnk = 0;
        else if( clk_i == 1'b1)
            if(cnk == 49999)   //1kHz  49999
                begin
                    cnk = 0;
                    clk = !clk;
                    clk_o = clk;
                end
            else
                cnk = cnk + 1;
         else;
     end

endmodule
