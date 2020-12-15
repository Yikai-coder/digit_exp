`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 15:57:19
// Design Name: 
// Module Name: memory_game
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
module memory_game(
    input s0,
    input s1,
    input s2, 
    input s3,
    input s4, 
    input [7:0] sw,
    input clk,
    output [7:0] led_cx_o_0,
    output [7:0] led_cx_o_1,
    output [3:0] led_en_o_0,
    output [3:0] led_en_o_1,
    output reg[7:0] led_0,
    output reg [7:0] led_1
    );

    parameter init = 3'b000;  // 初始状态
    parameter state_1 = 3'b001; // 生成随机数并展示
    parameter state_2 = 3'b010; // 读取sw的值作为地址
    parameter state_3 = 3'b011;  // 将进入匹配机
    parameter state_4 = 3'b100;  // 匹配成功

    // 三个下设模块的清零端，上电清零
    reg random_rst = 1'b0;  
    reg reg_rst = 1'b1;
    reg match_rst = 1'b1;
    // 连接到输出控制模块
    reg [3:0] output_data_0 = 4'b0000;  
    reg [3:0] output_data_1 = 4'b0000;
    reg [3:0] output_data_2 = 4'b0000;
    reg [3:0] output_data_3 = 4'b0000;
    reg [3:0] output_data_4 = 4'b0000;
    reg [3:0] output_data_5 = 4'b0000;
    reg [3:0] output_data_6 = 4'b0000;
    reg [3:0] output_data_7 = 4'b0000;
    // 暂存生成的随机数
    wire [2:0] temp_in_data_0;   
    wire [2:0] temp_in_data_1;   
    wire [2:0] temp_in_data_2;   
    wire [2:0] temp_in_data_3;   
    wire [2:0] temp_in_data_4; 
    // 暂存从file取出的数
    wire [2:0] temp_out_data_0;   
    wire [2:0] temp_out_data_1;   
    wire [2:0] temp_out_data_2;   
    wire [2:0] temp_out_data_3;   
    wire [2:0] temp_out_data_4; 

    wire random_done;
    reg [2:0] match_input;
    reg start_flow = 1'b0; 
    reg [1:0] counter = 2'b00; //控制流水灯

    reg match_set = 1'b0;
    reg write_en = 1'b0;
    reg read_en = 1'b0;
    wire [7:0] address;
    wire [7:0] address_output;
    reg [7:0] address_input;
    reg[7:0] match_address = 8'b1111_1111;
    wire match;  
    reg can_match = 1'b0;  // 针对state2没有输入合法地址的情况
    wire [2:0] state;
    wire s0_filter;
    wire s1_filter;
    wire s2_filter;
    wire s3_filter;
    wire s4_filter; 
    reg [2:0] choice = 3'b000;  // 用于在state_1展示产生的随机数
    wire clk_1Hz;
    wire clk_2Hz;



    key_filter filter_0(clk, s0, s0_filter);
    key_filter filter_1(clk, s1, s1_filter);
    key_filter filter_2(clk, s2, s2_filter);
    key_filter filter_3(clk, s3, s3_filter);
    key_filter filter_4(clk, s4, s4_filter);
    frequency_divider_1Hz clock_1Hz(clk, 1'b1, clk_1Hz);
    frequency_divider_2Hz clock_2Hz(clk, 1'b1, clk_2Hz);


    // 将按键送入CPU返回状态state
    CPU controler(s0_filter,
                  s1_filter, 
                  s2_filter, 
                  s3_filter, 
                  s4_filter, 
                  match, 
                  clk, 
                  state);  

    random_contributor random(1'b0, 
                              clk, 
                              s0_filter, 
                              temp_in_data_0, 
                              temp_in_data_1, 
                              temp_in_data_2, 
                              temp_in_data_3, 
                              temp_in_data_4, 
                              address_output,
                              random_done);

    reg_file file(address, 
                  temp_in_data_0, 
                  temp_in_data_1, 
                  temp_in_data_2, 
                  temp_in_data_3, 
                  temp_in_data_4, 
                  write_en, 
                  read_en, 
                  reg_rst, 
                  temp_out_data_0, 
                  temp_out_data_1, 
                  temp_out_data_2, 
                  temp_out_data_3, 
                  temp_out_data_4);

    match match_string(match_rst, 
                       match_set, 
                       match_input, 
                       temp_out_data_0, 
                       temp_out_data_1, 
                       temp_out_data_2, 
                       temp_out_data_3, 
                       temp_out_data_4, 
                       match);

    display_control display(clk, 
                            state, 
                            output_data_0, 
                            output_data_1, 
                            output_data_2, 
                            output_data_3, 
                            output_data_4, 
                            output_data_5, 
                            output_data_6, 
                            output_data_7, 
                            led_cx_o_0, 
                            led_en_o_0, 
                            led_cx_o_1, 
                            led_en_o_1);


    // 处理上述变量的赋值
    always @(posedge clk) begin
        case(state)
            init: begin
                reg_rst <= 1'b1;
                match_rst <= 1'b1; 
                output_data_0 <= 4'b0000;  
                output_data_1 <= 4'b0000;
                output_data_2 <= 4'b0000;
                output_data_3 <= 4'b0000;
                output_data_4 <= 4'b0000;
                output_data_5 <= 4'b0000;
                output_data_6 <= 4'b0000;
                output_data_7 <= 4'b0000;
            end
            state_1: begin
                reg_rst <= 1'b0;
                if(random_done == 1'b0);
                else begin
                    address_input <= {5'b00000, choice};                   // 实现1Hz播放5个5位随机数
                    output_data_0 <= 4'b0000;
                    output_data_1 <= 4'b0000;
                    output_data_2 <= 4'b0000;
                    output_data_3 <= {1'b0, temp_out_data_0};
                    output_data_4 <= {1'b0, temp_out_data_1};
                    output_data_5 <= {1'b0, temp_out_data_2};
                    output_data_6 <= {1'b0, temp_out_data_3};
                    output_data_7 <= {1'b0, temp_out_data_4};
                end
            end
            state_2: begin
                if(sw < 8'b0000_0101) begin  // 判断输入的地址是否合法
                    address_input <= sw;
                    match_address <= sw;
                    can_match <= 1'b1;
                    output_data_0 <= {1'b0, 3'b000};
                    output_data_1 <= {1'b0, 3'b000};
                    output_data_2 <= {1'b0, 3'b000};
                    output_data_3 <= {1'b0, 3'b000};
                    output_data_4 <= {1'b0, 3'b000};
                    output_data_5 <= {1'b0, 3'b000};
                    output_data_6 <= {1'b0, 3'b000};
                    output_data_7 <= {1'b0, sw[2:0]};
                end
                else begin
                    can_match <= 1'b0;
                    output_data_7 <= 4'b1111;
                end

            end
            // 匹配机开始工作
            state_3: begin
                if(can_match == 1'b1) begin
                    match_rst <= 1'b0;
                    match_set <= s3;
                    match_input <= sw[2:0];
                end
                else;
            end
            state_4: begin
                output_data_0 <= 4'b0000;
                output_data_1 <= match_address;
                output_data_2 <= 4'b1110;
                output_data_3 <= temp_out_data_0;
                output_data_4 <= temp_out_data_1;
                output_data_5 <= temp_out_data_2;
                output_data_6 <= temp_out_data_3;
                output_data_7 <= temp_out_data_4;
            end
            default;
        endcase
    end

    // 处理address赋值
    assign address = (state == state_1 && random_done == 1'b0)?address_output:address_input;
   
   // 处理option赋值
    always @(posedge clk) begin
        if(random_done == 1'b1) begin
            if(choice == 3'b100)
                choice <= choice;
            else begin
                choice <= choice + 3'b001;
            end
        end
        else
            choice <= 3'b000;
    end
    // 处理file写入和读出
    always @(posedge clk) begin
        if(state == state_1) begin
            if(random_done == 1'b0) begin
            write_en <= 1'b1;
            read_en <= 1'b0;
            end
            else begin
                write_en <= 1'b0;
                read_en <= 1'b1;
            end
        end
        else if(state == state_2) begin
            write_en <= 1'b0;
            read_en <= 1'b1;
        end
        else begin
            write_en <= 1'b0;
            read_en <= 1'b1;      
        end
    end
    // 根据state确定状态提示灯亮起情况
    always @(*) begin
       case(state)
       init: led_1 = 8'b0000_0001;
       state_1: led_1 = 8'b0000_0010;
       state_2: led_1 = 8'b0000_0100;
       state_3: led_1 = 8'b0000_1000;
       state_4: led_1 = 8'b0001_0000;
       default: led_1 = 8'b0000_0000;
       endcase
    end
    //在成功完成匹配之后开始流水灯，标志置1
    always @(match) begin
        if(match == 1'b1)
            start_flow = 1'b1;
        else
            start_flow = 1'b0;
    end
    // 以2Hz的频率实现流水灯，
    always @(posedge clk) begin
        if(clk == 1'b1)
            if(start_flow == 1'b1)
                counter <= counter + 1'b1;
            else begin
                counter <= 2'b00;
            end
        else;
    end
    // 根据拨码开关的输入亮起，成功之后根据counter亮起实现流水灯
    always @(*) begin
        if(match == 1'b0)
            led_0 = sw;
        else begin
            case(counter)
            2'b00: led_0 = 8'b1000_0001;
            2'b01: led_0 = 8'b0100_0010;
            2'b10: led_0 = 8'b0010_0100;
            2'b11: led_0 = 8'b0001_1000;
            default;
            endcase
        end
    end
endmodule
