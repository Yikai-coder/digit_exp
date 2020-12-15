`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 22:39:14
// Design Name: 
// Module Name: selector_81
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


module selector_81(
    input [7:0] option0,
    input [7:0] option1,
    input [7:0] option2,
    input [7:0] option3,
    input [7:0] option4,
    input [7:0] option5,
    input [7:0] option6,
    input [7:0] option7,
    input [2:0] choice,
    output reg [7:0] result
    );
    
    always @ (*)
    begin
    case (choice)
        8'b000:
            result = option0;
        8'b001:
            result = option1;
        8'b010:
            result = option2;
        8'b011:
            result = option3;
        8'b100:
            result = option4;
        8'b101:
            result = option5;
        8'b110:
            result = option6;
        8'b111:
            result = option7;
   endcase
   end
endmodule
