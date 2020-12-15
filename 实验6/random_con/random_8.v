`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/30 16:37:08
// Design Name: 
// Module Name: random_8
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
 module LFSR
   (  
    input clk,  
    input enable,  
    input [2:0] seed_data,  
    output [2:0] LFSR_data 
    );  
   
   reg [2:0] LFSR = 3'b000;  
   wire XNOR;  
   
    // 根据enable和时钟信号对LFSR进行初始化与循环状态转移
    always @(posedge clk or posedge enable)  
      begin  
        if(enable == 1'b1) 
          LFSR <= seed_data; 
        else if(clk == 1'b1)
          LFSR <= {LFSR[1:0], XNOR};
        else;
      end 
    
    assign XNOR = LFSR[2] ^~ LFSR[1];  // 异或操作
    assign LFSR_data = LFSR;   // 将当前状态赋值输出
 
 endmodule // LFSR 
