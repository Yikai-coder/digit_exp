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


module selector_51(
    input clk,
    input [2:0] option0,
    input [2:0] option1,
    input [2:0] option2,
    input [2:0] option3,
    input [2:0] option4,
    input [4:0] choice,
    output reg [2:0] result
    );
    
    always @ (*)
    begin
    case (choice)
        5'b00001:
            result <= option0;
        5'b00010:
            result <= option1;
        5'b00100:
            result <= option2;
        5'b01000:
            result <= option3;
        5'b10000:
            result <= option4;
        default: result <= 3'b000;
   endcase
   end
endmodule
