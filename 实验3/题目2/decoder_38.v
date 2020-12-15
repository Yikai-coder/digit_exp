`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 22:31:32
// Design Name: 
// Module Name: decoder_38
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


module decoder_38(
    input en_i,
    input [2:0] data_i,
    output reg [7:0] data_o
    );
    
always @(data_i or en_i) begin
    if(en_i == 0)
        case (data_i)
            3'b000: data_o = 8'b1111_1110;
            3'b001: data_o = 8'b1111_1101;
            3'b010: data_o = 8'b1111_1011;
            3'b011: data_o = 8'b1111_0111;
            3'b100: data_o = 8'b1110_1111;
            3'b101: data_o = 8'b1101_1111;
            3'b110: data_o = 8'b1011_1111;
            3'b111: data_o = 8'b0111_1111;
            default: data_o = 8'b1111_1111;
       endcase
    else
        data_o = 8'b1111_1111; 
  end
endmodule
