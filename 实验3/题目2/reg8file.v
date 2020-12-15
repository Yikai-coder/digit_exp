`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 22:26:04
// Design Name: 
// Module Name: reg8file
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


module reg8file(
    input clk,
    input clrn,
    input wen,
    input [7:0] d,
    input [2:0] wsel,
    input [2:0] rsel,
    output [7:0] q
    );
    wire [7:0] address;
    wire [7:0] r0;
    wire [7:0] r1;
    wire [7:0] r2;
    wire [7:0] r3;
    wire [7:0] r4;
    wire [7:0] r5;
    wire [7:0] r6;
    wire [7:0] r7;
    
    
    
    
    decoder_38 decoder(wen, wsel, address);
    reg8 reg8_0(clk, clrn, address[0], d, r0);
    reg8 reg8_1(clk, clrn, address[1], d, r1);
    reg8 reg8_2(clk, clrn, address[2], d, r2);
    reg8 reg8_3(clk, clrn, address[3], d, r3);
    reg8 reg8_4(clk, clrn, address[4], d, r4);
    reg8 reg8_5(clk, clrn, address[5], d, r5);
    reg8 reg8_6(clk, clrn, address[6], d, r6);
    reg8 reg8_7(clk, clrn, address[7], d, r7);    
    
    selector_81 selector ( r0,r1,r2,r3,r4,r5,r6,r7, rsel, q);
    
endmodule
