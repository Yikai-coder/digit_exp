`timescale 1ns / 1ps
module digit_table 
(
    input clk_i,
    input en_i,
    input [3:0] input_data,
    output reg [7:0] seg_data
);
    wire en = ~en_i;
    always@(posedge clk_i, posedge en)begin
        if(en == 1'b1)   // 清零不显示
            seg_data <= 8'b0000_0000;
        else if(clk_i == 1'b1) begin
            case(input_data)
                4'b0000: seg_data <= 8'b0011_1111;
                4'b0001: seg_data <= 8'b0000_0110;
                4'b0010: seg_data <= 8'b0101_1011;
                4'b0011: seg_data <= 8'b0100_1111;
                4'b0100: seg_data <= 8'b0110_0110;
                4'b0101: seg_data <= 8'b0110_1101;
                4'b0110: seg_data <= 8'b0111_1101;
                4'b0111: seg_data <= 8'b0000_0111;
                4'b1000: seg_data <= 8'b0111_1111;
                4'b1001: seg_data <= 8'b0110_1111;
                4'b1010: seg_data <= 8'b0111_0111;
                4'b1011: seg_data <= 8'b1111_1100;
                4'b1100: seg_data <= 8'b0101_1000;
                4'b1101: seg_data <= 8'b0101_1110;
                4'b1110: seg_data <= 8'b0100_0000;  // E表示-
                4'b1111: seg_data <= 8'b0111_0001;
                default: seg_data <= 8'b0000_0000;
                endcase
        end
        else;
    end
endmodule  //digit_table