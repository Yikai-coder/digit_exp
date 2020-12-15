`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/19 10:01:47
// Design Name: 
// Module Name: state_machine_sim
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


module state_machine_sim();
    reg rst;
    reg clk;
    reg set;
    reg [7:0] data;
    wire detect;
    
    state_machine_moor uut(rst, clk, set, data, detect);
    
    always #5 clk = ~clk;
    initial begin 
        clk = 1'b0;
        rst = 1'b0;
        set = 1'b0;
        data = 8'b0000_01011;
        
        #20 begin  //输入符合条件数据但使能置0
        set = 1'b0;
        end
        #10 rst = 1'b1;
        #20 set = 1'b1;  //迅速按下set并松开
        #10 set = 1'b0;
        
        #100 rst = 1'b0;  //测试清零
        
        #20 rst = 1'b1;
        
        #20 data=8'b0101_0111;  //测试序列在最后
        #10 set = 1'b1;
        #10 set = 1'b0;  

        #50 data=8'b0001_0101;  //使用不符合条件的数据测试
        #10 set = 1'b1;
        #10 set = 1'b0; 
        
        #100 $stop;
    end

endmodule
