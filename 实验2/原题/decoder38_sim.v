`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/05 08:05:04
// Design Name: 
// Module Name: decoder38_sim
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

/*
module decoder_38_sim();

reg [7:0] data_in;
reg en;
wire [7:0] data_out;

decoder_38 uut(
    .data_i (data_in),
    .data_o (data_out),
    .en_i (en)
    );
    
 initial begin
    data_in = 0;
    en = 1;
    
    #100
    data_in <= 3'b000;
    
    #100;
    data_in <= 3'b001;
    
    #100
    data_in <= 3'b010;
    
    #100
    data_in <= 3'b011;
    
    #100
    data_in <= 3'b100;
    
    #100
    data_in <= 3'b101;
    
    #100
    data_in <=3'b110;
    
    #100
    data_in <= 3'b111;
    
    #100
    en <= 0;
    
    #100
    en <= 1;
    
  end    
endmodule*/

`timescale 1ns/1ps          // 1ns 表示延时单位, 1ps 表示时间精度 
 
module decoder_38_sim (); 
 
    // 输入端口     
    reg [2:0] data_in;     reg [2:0] en; 
 
    // 输出端口     
    wire [7:0] data_out; 
 
    // 结合自己的实现完成实例化     
    decoder_38 U_dec38_0 (        
     .data_i     (data_in),        
     .en_i       (en),        
     .data_o     (data_out)     
     ); 
 
    initial begin         // 构造输入激励信号
             #5 begin en = 3'b100; data_in = 3'b000; end         #5 begin en = 3'b100; data_in = 3'b001; end  
 
        #5 begin en = 3'b100; data_in = 3'b010; end         
        #5 begin en = 3'b100; data_in = 3'b011; end         #5 begin en = 3'b100; data_in = 3'b100; end         #5 begin en = 3'b100; data_in = 3'b101; end         #5 begin en = 3'b100; data_in = 3'b110; end         #5 begin en = 3'b100; data_in = 3'b111; end         // 使能端无效
                 #5 begin en = 3'b101; data_in = 3'b000; end         // 结束仿真         
                 #5 $stop;     end 
 
endmodule
