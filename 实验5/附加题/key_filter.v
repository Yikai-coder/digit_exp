`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/17 09:02:26
// Design Name: 
// Module Name: key_filter
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
module key_filter(
    input clk_1KHz,
    input s0,
    output reg flag
    );
    
    reg [4:0] cnt_20ms = 0;
    reg reg_1;
    reg reg_2;
    reg change; 
    reg start_count = 1'b0;
    reg temp = 0;
    
    assign in = s0;
    
    always @ (posedge clk_1KHz) begin
        reg_1 <= s0;
        reg_2 <= reg_1;
        change <= reg_2^s0;      //异或检测前后输入是否相同
        end
        
    always @ (posedge clk_1KHz or posedge change) begin
        if(change == 1'b1) begin
            start_count <= 1'b1;
            cnt_20ms <= 5'b00000;
        end
        else if(clk_1KHz == 1'b1)begin
            if(start_count) begin
                if(cnt_20ms == 5'b01011) begin
                    start_count <= 1'b0;
                    cnt_20ms <= 5'b00000;
                    end
                else
                    cnt_20ms <= cnt_20ms + 1;
            end
        end
        else;
    end

    always @ (posedge clk_1KHz) begin
        if(cnt_20ms == 5'b01011) begin
            temp <= s0;
            flag <= temp;
        end
        else
            flag <= temp;
    end
    
endmodule
