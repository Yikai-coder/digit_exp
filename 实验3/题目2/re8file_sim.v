`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 08:05:40
// Design Name: 
// Module Name: re8file_sim
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


module re8file_sim();
    reg clk_i = 1'b1;
    reg clrn_i = 1'b1;
    reg wen_i = 1'b1;
    reg [2:0] wsel_i;
    reg [2:0] rsel_i;
    wire [7:0] q_o;
    reg [7:0] d_i;
    
    reg8file uut(
        .clk(clk_i),
        .clrn(clrn_i),
        .wen(wen_i),
        .wsel(wsel_i),
        .rsel(rsel_i),
        .q(q_o),
        .d(d_i)
        );
    
    always begin #5 clk_i = ~clk_i; end
    // 依此写入8个位置并检查读取
    initial begin
    wen_i = 1'b0;
    #20 
    begin
        wsel_i = 3'b000;
        d_i = 8'b0000_0000;
    end
    #10 wsel_i = 3'bxxx;
    #20 
    begin
        wsel_i = 3'b001;
        d_i = 8'b0000_0001;
    end
    #10 wsel_i = 3'bxxx;
    #20 
    begin
        wsel_i = 3'b010;
        d_i = 8'b0000_0010;
    end
    #10 wsel_i = 3'bxxx;
    #20 
    begin
        wsel_i = 3'b011;
        d_i = 8'b0000_0011;
    end
    #10 wsel_i = 3'bxxx;
    #20 
    begin
        wsel_i = 3'b100;
        d_i = 8'b0000_0100;
    end
    #10 wsel_i = 3'bxxx;
    #20 
    begin
        wsel_i = 3'b101;
        d_i = 8'b0000_0101;
    end
    #10 wsel_i = 3'bxxx;
    #20
    begin
        wsel_i = 3'b110;
        d_i = 8'b0000_0110;
    end
    #10 wsel_i = 3'bxxx;
    #20
    begin
        wsel_i = 3'b111;
        d_i = 8'b0000_0111;
    end
    #10 wsel_i = 3'bxxx;
    #20         rsel_i = 3'b000;
    #20         rsel_i = 3'b001;
    #20         rsel_i = 3'b010;
    #20         rsel_i = 3'b011;
    #20         rsel_i = 3'b100;
    #20         rsel_i = 3'b101;
    #20         rsel_i = 3'b110;
    #20         rsel_i = 3'b111;

    // 检查跟随
    #5  wen_i = 1'b1;
    #20
    begin
        wsel_i = 3'b111;
        d_i = 8'b1111_1111;
     end
     #10         rsel_i = 3'b111;
     
    // 检查清零
    #20
    begin
        clrn_i = 1'b0;
        #10
        begin
            rsel_i = 3'b000;
            rsel_i = 3'b001;
            rsel_i = 3'b010;
            rsel_i = 3'b011;
            rsel_i = 3'b100;
            rsel_i = 3'b101;
            rsel_i = 3'b110;
            rsel_i = 3'b111;
        end
    end
    #20 $stop;
   end

endmodule
