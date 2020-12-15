`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/04 20:20:15
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
    input [2:0] en_i,
    input [2:0] data_i,
    output reg [7:0] data_o
    );
    
always @(data_i or en_i) begin
    if(en_i == 3'b100)
        case (data_i)
            3'b000: data_o = 8'b0000_0001;
            3'b001: data_o = 8'b0000_0010;
            3'b010: data_o = 8'b0000_0100;
            3'b011: data_o = 8'b0000_1000;
            3'b100: data_o = 8'b0001_0000;
            3'b101: data_o = 8'b0010_0000;
            3'b110: data_o = 8'b0100_0000;
            3'b111: data_o = 8'b1000_0000;
            default: data_o = 8'bxxxx_xxxx;
       endcase
    else
        data_o = 8'b0000_0000; 
  end
endmodule
