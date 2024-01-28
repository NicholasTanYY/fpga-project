`timescale 1ns / 1ps
`include "char_dimensions.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 22:25:15
// Design Name: 
// Module Name: draw_character
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


module draw_character(
    input enable,
    input basys_clock,
    input clk6p25m,
    input [12:0] pixel_index,
    input [7:0] character_id, // Specify which character to display
    input btnU, btnD, btnL, btnR,
    input [3:0] sw,
    output reg [15:0] oled_data,
    output [15:0] debug,
    output reg [3:0] size = 1,     // there are 5 different sizes of the characters
    output reg [3:0] char_colour = 0,   // seven different colours corresponding to colours of the rainbow
    output reg [3:0] bg_colour = 0
);

    wire [31:0] x, y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
    reg [31:0] char_x, char_y, char_width, char_height;
    
    // Map character_id to the respective parameters
    always @(*) begin
        case(character_id)
             32: begin
               char_x = (size == 1 ? SIZE1_CHAR32_X : (size == 2 ? SIZE2_CHAR32_X : (size == 3 ? SIZE3_CHAR32_X : (size == 4 ? SIZE4_CHAR32_X : SIZE5_CHAR32_X))));
               char_y = (size == 1 ? SIZE1_CHAR32_Y : (size == 2 ? SIZE2_CHAR32_Y : (size == 3 ? SIZE3_CHAR32_Y : (size == 4 ? SIZE4_CHAR32_Y : SIZE5_CHAR32_Y))));
               char_width = (size == 1 ? SIZE1_CHAR32_WIDTH : (size == 2 ? SIZE2_CHAR32_WIDTH : (size == 3 ? SIZE3_CHAR32_WIDTH : (size == 4 ? SIZE4_CHAR32_WIDTH : SIZE5_CHAR32_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR32_HEIGHT : (size == 2 ? SIZE2_CHAR32_HEIGHT : (size == 3 ? SIZE3_CHAR32_HEIGHT : (size == 4 ? SIZE4_CHAR32_HEIGHT : SIZE5_CHAR32_HEIGHT))));
            end
            33: begin
               char_x = (size == 1 ? SIZE1_CHAR33_X : (size == 2 ? SIZE2_CHAR33_X : (size == 3 ? SIZE3_CHAR33_X : (size == 4 ? SIZE4_CHAR33_X : SIZE5_CHAR33_X))));
               char_y = (size == 1 ? SIZE1_CHAR33_Y : (size == 2 ? SIZE2_CHAR33_Y : (size == 3 ? SIZE3_CHAR33_Y : (size == 4 ? SIZE4_CHAR33_Y : SIZE5_CHAR33_Y))));
               char_width = (size == 1 ? SIZE1_CHAR33_WIDTH : (size == 2 ? SIZE2_CHAR33_WIDTH : (size == 3 ? SIZE3_CHAR33_WIDTH : (size == 4 ? SIZE4_CHAR33_WIDTH : SIZE5_CHAR33_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR33_HEIGHT : (size == 2 ? SIZE2_CHAR33_HEIGHT : (size == 3 ? SIZE3_CHAR33_HEIGHT : (size == 4 ? SIZE4_CHAR33_HEIGHT : SIZE5_CHAR33_HEIGHT))));
            end
            34: begin
               char_x = (size == 1 ? SIZE1_CHAR34_X : (size == 2 ? SIZE2_CHAR34_X : (size == 3 ? SIZE3_CHAR34_X : (size == 4 ? SIZE4_CHAR34_X : SIZE5_CHAR34_X))));
               char_y = (size == 1 ? SIZE1_CHAR34_Y : (size == 2 ? SIZE2_CHAR34_Y : (size == 3 ? SIZE3_CHAR34_Y : (size == 4 ? SIZE4_CHAR34_Y : SIZE5_CHAR34_Y))));
               char_width = (size == 1 ? SIZE1_CHAR34_WIDTH : (size == 2 ? SIZE2_CHAR34_WIDTH : (size == 3 ? SIZE3_CHAR34_WIDTH : (size == 4 ? SIZE4_CHAR34_WIDTH : SIZE5_CHAR34_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR34_HEIGHT : (size == 2 ? SIZE2_CHAR34_HEIGHT : (size == 3 ? SIZE3_CHAR34_HEIGHT : (size == 4 ? SIZE4_CHAR34_HEIGHT : SIZE5_CHAR34_HEIGHT))));
            end
            35: begin
               char_x = (size == 1 ? SIZE1_CHAR35_X : (size == 2 ? SIZE2_CHAR35_X : (size == 3 ? SIZE3_CHAR35_X : (size == 4 ? SIZE4_CHAR35_X : SIZE5_CHAR35_X))));
               char_y = (size == 1 ? SIZE1_CHAR35_Y : (size == 2 ? SIZE2_CHAR35_Y : (size == 3 ? SIZE3_CHAR35_Y : (size == 4 ? SIZE4_CHAR35_Y : SIZE5_CHAR35_Y))));
               char_width = (size == 1 ? SIZE1_CHAR35_WIDTH : (size == 2 ? SIZE2_CHAR35_WIDTH : (size == 3 ? SIZE3_CHAR35_WIDTH : (size == 4 ? SIZE4_CHAR35_WIDTH : SIZE5_CHAR35_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR35_HEIGHT : (size == 2 ? SIZE2_CHAR35_HEIGHT : (size == 3 ? SIZE3_CHAR35_HEIGHT : (size == 4 ? SIZE4_CHAR35_HEIGHT : SIZE5_CHAR35_HEIGHT))));
            end
            36: begin
               char_x = (size == 1 ? SIZE1_CHAR36_X : (size == 2 ? SIZE2_CHAR36_X : (size == 3 ? SIZE3_CHAR36_X : (size == 4 ? SIZE4_CHAR36_X : SIZE5_CHAR36_X))));
               char_y = (size == 1 ? SIZE1_CHAR36_Y : (size == 2 ? SIZE2_CHAR36_Y : (size == 3 ? SIZE3_CHAR36_Y : (size == 4 ? SIZE4_CHAR36_Y : SIZE5_CHAR36_Y))));
               char_width = (size == 1 ? SIZE1_CHAR36_WIDTH : (size == 2 ? SIZE2_CHAR36_WIDTH : (size == 3 ? SIZE3_CHAR36_WIDTH : (size == 4 ? SIZE4_CHAR36_WIDTH : SIZE5_CHAR36_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR36_HEIGHT : (size == 2 ? SIZE2_CHAR36_HEIGHT : (size == 3 ? SIZE3_CHAR36_HEIGHT : (size == 4 ? SIZE4_CHAR36_HEIGHT : SIZE5_CHAR36_HEIGHT))));
            end
            37: begin
               char_x = (size == 1 ? SIZE1_CHAR37_X : (size == 2 ? SIZE2_CHAR37_X : (size == 3 ? SIZE3_CHAR37_X : (size == 4 ? SIZE4_CHAR37_X : SIZE5_CHAR37_X))));
               char_y = (size == 1 ? SIZE1_CHAR37_Y : (size == 2 ? SIZE2_CHAR37_Y : (size == 3 ? SIZE3_CHAR37_Y : (size == 4 ? SIZE4_CHAR37_Y : SIZE5_CHAR37_Y))));
               char_width = (size == 1 ? SIZE1_CHAR37_WIDTH : (size == 2 ? SIZE2_CHAR37_WIDTH : (size == 3 ? SIZE3_CHAR37_WIDTH : (size == 4 ? SIZE4_CHAR37_WIDTH : SIZE5_CHAR37_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR37_HEIGHT : (size == 2 ? SIZE2_CHAR37_HEIGHT : (size == 3 ? SIZE3_CHAR37_HEIGHT : (size == 4 ? SIZE4_CHAR37_HEIGHT : SIZE5_CHAR37_HEIGHT))));
            end
            38: begin
               char_x = (size == 1 ? SIZE1_CHAR38_X : (size == 2 ? SIZE2_CHAR38_X : (size == 3 ? SIZE3_CHAR38_X : (size == 4 ? SIZE4_CHAR38_X : SIZE5_CHAR38_X))));
               char_y = (size == 1 ? SIZE1_CHAR38_Y : (size == 2 ? SIZE2_CHAR38_Y : (size == 3 ? SIZE3_CHAR38_Y : (size == 4 ? SIZE4_CHAR38_Y : SIZE5_CHAR38_Y))));
               char_width = (size == 1 ? SIZE1_CHAR38_WIDTH : (size == 2 ? SIZE2_CHAR38_WIDTH : (size == 3 ? SIZE3_CHAR38_WIDTH : (size == 4 ? SIZE4_CHAR38_WIDTH : SIZE5_CHAR38_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR38_HEIGHT : (size == 2 ? SIZE2_CHAR38_HEIGHT : (size == 3 ? SIZE3_CHAR38_HEIGHT : (size == 4 ? SIZE4_CHAR38_HEIGHT : SIZE5_CHAR38_HEIGHT))));
            end
            39: begin
               char_x = (size == 1 ? SIZE1_CHAR39_X : (size == 2 ? SIZE2_CHAR39_X : (size == 3 ? SIZE3_CHAR39_X : (size == 4 ? SIZE4_CHAR39_X : SIZE5_CHAR39_X))));
               char_y = (size == 1 ? SIZE1_CHAR39_Y : (size == 2 ? SIZE2_CHAR39_Y : (size == 3 ? SIZE3_CHAR39_Y : (size == 4 ? SIZE4_CHAR39_Y : SIZE5_CHAR39_Y))));
               char_width = (size == 1 ? SIZE1_CHAR39_WIDTH : (size == 2 ? SIZE2_CHAR39_WIDTH : (size == 3 ? SIZE3_CHAR39_WIDTH : (size == 4 ? SIZE4_CHAR39_WIDTH : SIZE5_CHAR39_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR39_HEIGHT : (size == 2 ? SIZE2_CHAR39_HEIGHT : (size == 3 ? SIZE3_CHAR39_HEIGHT : (size == 4 ? SIZE4_CHAR39_HEIGHT : SIZE5_CHAR39_HEIGHT))));
            end
            40: begin
               char_x = (size == 1 ? SIZE1_CHAR40_X : (size == 2 ? SIZE2_CHAR40_X : (size == 3 ? SIZE3_CHAR40_X : (size == 4 ? SIZE4_CHAR40_X : SIZE5_CHAR40_X))));
               char_y = (size == 1 ? SIZE1_CHAR40_Y : (size == 2 ? SIZE2_CHAR40_Y : (size == 3 ? SIZE3_CHAR40_Y : (size == 4 ? SIZE4_CHAR40_Y : SIZE5_CHAR40_Y))));
               char_width = (size == 1 ? SIZE1_CHAR40_WIDTH : (size == 2 ? SIZE2_CHAR40_WIDTH : (size == 3 ? SIZE3_CHAR40_WIDTH : (size == 4 ? SIZE4_CHAR40_WIDTH : SIZE5_CHAR40_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR40_HEIGHT : (size == 2 ? SIZE2_CHAR40_HEIGHT : (size == 3 ? SIZE3_CHAR40_HEIGHT : (size == 4 ? SIZE4_CHAR40_HEIGHT : SIZE5_CHAR40_HEIGHT))));
            end
            41: begin
               char_x = (size == 1 ? SIZE1_CHAR41_X : (size == 2 ? SIZE2_CHAR41_X : (size == 3 ? SIZE3_CHAR41_X : (size == 4 ? SIZE4_CHAR41_X : SIZE5_CHAR41_X))));
               char_y = (size == 1 ? SIZE1_CHAR41_Y : (size == 2 ? SIZE2_CHAR41_Y : (size == 3 ? SIZE3_CHAR41_Y : (size == 4 ? SIZE4_CHAR41_Y : SIZE5_CHAR41_Y))));
               char_width = (size == 1 ? SIZE1_CHAR41_WIDTH : (size == 2 ? SIZE2_CHAR41_WIDTH : (size == 3 ? SIZE3_CHAR41_WIDTH : (size == 4 ? SIZE4_CHAR41_WIDTH : SIZE5_CHAR41_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR41_HEIGHT : (size == 2 ? SIZE2_CHAR41_HEIGHT : (size == 3 ? SIZE3_CHAR41_HEIGHT : (size == 4 ? SIZE4_CHAR41_HEIGHT : SIZE5_CHAR41_HEIGHT))));
            end
            42: begin
               char_x = (size == 1 ? SIZE1_CHAR42_X : (size == 2 ? SIZE2_CHAR42_X : (size == 3 ? SIZE3_CHAR42_X : (size == 4 ? SIZE4_CHAR42_X : SIZE5_CHAR42_X))));
               char_y = (size == 1 ? SIZE1_CHAR42_Y : (size == 2 ? SIZE2_CHAR42_Y : (size == 3 ? SIZE3_CHAR42_Y : (size == 4 ? SIZE4_CHAR42_Y : SIZE5_CHAR42_Y))));
               char_width = (size == 1 ? SIZE1_CHAR42_WIDTH : (size == 2 ? SIZE2_CHAR42_WIDTH : (size == 3 ? SIZE3_CHAR42_WIDTH : (size == 4 ? SIZE4_CHAR42_WIDTH : SIZE5_CHAR42_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR42_HEIGHT : (size == 2 ? SIZE2_CHAR42_HEIGHT : (size == 3 ? SIZE3_CHAR42_HEIGHT : (size == 4 ? SIZE4_CHAR42_HEIGHT : SIZE5_CHAR42_HEIGHT))));
            end
            43: begin
               char_x = (size == 1 ? SIZE1_CHAR43_X : (size == 2 ? SIZE2_CHAR43_X : (size == 3 ? SIZE3_CHAR43_X : (size == 4 ? SIZE4_CHAR43_X : SIZE5_CHAR43_X))));
               char_y = (size == 1 ? SIZE1_CHAR43_Y : (size == 2 ? SIZE2_CHAR43_Y : (size == 3 ? SIZE3_CHAR43_Y : (size == 4 ? SIZE4_CHAR43_Y : SIZE5_CHAR43_Y))));
               char_width = (size == 1 ? SIZE1_CHAR43_WIDTH : (size == 2 ? SIZE2_CHAR43_WIDTH : (size == 3 ? SIZE3_CHAR43_WIDTH : (size == 4 ? SIZE4_CHAR43_WIDTH : SIZE5_CHAR43_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR43_HEIGHT : (size == 2 ? SIZE2_CHAR43_HEIGHT : (size == 3 ? SIZE3_CHAR43_HEIGHT : (size == 4 ? SIZE4_CHAR43_HEIGHT : SIZE5_CHAR43_HEIGHT))));
            end
            44: begin
               char_x = (size == 1 ? SIZE1_CHAR44_X : (size == 2 ? SIZE2_CHAR44_X : (size == 3 ? SIZE3_CHAR44_X : (size == 4 ? SIZE4_CHAR44_X : SIZE5_CHAR44_X))));
               char_y = (size == 1 ? SIZE1_CHAR44_Y : (size == 2 ? SIZE2_CHAR44_Y : (size == 3 ? SIZE3_CHAR44_Y : (size == 4 ? SIZE4_CHAR44_Y : SIZE5_CHAR44_Y))));
               char_width = (size == 1 ? SIZE1_CHAR44_WIDTH : (size == 2 ? SIZE2_CHAR44_WIDTH : (size == 3 ? SIZE3_CHAR44_WIDTH : (size == 4 ? SIZE4_CHAR44_WIDTH : SIZE5_CHAR44_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR44_HEIGHT : (size == 2 ? SIZE2_CHAR44_HEIGHT : (size == 3 ? SIZE3_CHAR44_HEIGHT : (size == 4 ? SIZE4_CHAR44_HEIGHT : SIZE5_CHAR44_HEIGHT))));
            end
            45: begin
               char_x = (size == 1 ? SIZE1_CHAR45_X : (size == 2 ? SIZE2_CHAR45_X : (size == 3 ? SIZE3_CHAR45_X : (size == 4 ? SIZE4_CHAR45_X : SIZE5_CHAR45_X))));
               char_y = (size == 1 ? SIZE1_CHAR45_Y : (size == 2 ? SIZE2_CHAR45_Y : (size == 3 ? SIZE3_CHAR45_Y : (size == 4 ? SIZE4_CHAR45_Y : SIZE5_CHAR45_Y))));
               char_width = (size == 1 ? SIZE1_CHAR45_WIDTH : (size == 2 ? SIZE2_CHAR45_WIDTH : (size == 3 ? SIZE3_CHAR45_WIDTH : (size == 4 ? SIZE4_CHAR45_WIDTH : SIZE5_CHAR45_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR45_HEIGHT : (size == 2 ? SIZE2_CHAR45_HEIGHT : (size == 3 ? SIZE3_CHAR45_HEIGHT : (size == 4 ? SIZE4_CHAR45_HEIGHT : SIZE5_CHAR45_HEIGHT))));
            end
            46: begin
               char_x = (size == 1 ? SIZE1_CHAR46_X : (size == 2 ? SIZE2_CHAR46_X : (size == 3 ? SIZE3_CHAR46_X : (size == 4 ? SIZE4_CHAR46_X : SIZE5_CHAR46_X))));
               char_y = (size == 1 ? SIZE1_CHAR46_Y : (size == 2 ? SIZE2_CHAR46_Y : (size == 3 ? SIZE3_CHAR46_Y : (size == 4 ? SIZE4_CHAR46_Y : SIZE5_CHAR46_Y))));
               char_width = (size == 1 ? SIZE1_CHAR46_WIDTH : (size == 2 ? SIZE2_CHAR46_WIDTH : (size == 3 ? SIZE3_CHAR46_WIDTH : (size == 4 ? SIZE4_CHAR46_WIDTH : SIZE5_CHAR46_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR46_HEIGHT : (size == 2 ? SIZE2_CHAR46_HEIGHT : (size == 3 ? SIZE3_CHAR46_HEIGHT : (size == 4 ? SIZE4_CHAR46_HEIGHT : SIZE5_CHAR46_HEIGHT))));
            end
            47: begin
               char_x = (size == 1 ? SIZE1_CHAR47_X : (size == 2 ? SIZE2_CHAR47_X : (size == 3 ? SIZE3_CHAR47_X : (size == 4 ? SIZE4_CHAR47_X : SIZE5_CHAR47_X))));
               char_y = (size == 1 ? SIZE1_CHAR47_Y : (size == 2 ? SIZE2_CHAR47_Y : (size == 3 ? SIZE3_CHAR47_Y : (size == 4 ? SIZE4_CHAR47_Y : SIZE5_CHAR47_Y))));
               char_width = (size == 1 ? SIZE1_CHAR47_WIDTH : (size == 2 ? SIZE2_CHAR47_WIDTH : (size == 3 ? SIZE3_CHAR47_WIDTH : (size == 4 ? SIZE4_CHAR47_WIDTH : SIZE5_CHAR47_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR47_HEIGHT : (size == 2 ? SIZE2_CHAR47_HEIGHT : (size == 3 ? SIZE3_CHAR47_HEIGHT : (size == 4 ? SIZE4_CHAR47_HEIGHT : SIZE5_CHAR47_HEIGHT))));
            end
            48: begin
               char_x = (size == 1 ? SIZE1_CHAR48_X : (size == 2 ? SIZE2_CHAR48_X : (size == 3 ? SIZE3_CHAR48_X : (size == 4 ? SIZE4_CHAR48_X : SIZE5_CHAR48_X))));
               char_y = (size == 1 ? SIZE1_CHAR48_Y : (size == 2 ? SIZE2_CHAR48_Y : (size == 3 ? SIZE3_CHAR48_Y : (size == 4 ? SIZE4_CHAR48_Y : SIZE5_CHAR48_Y))));
               char_width = (size == 1 ? SIZE1_CHAR48_WIDTH : (size == 2 ? SIZE2_CHAR48_WIDTH : (size == 3 ? SIZE3_CHAR48_WIDTH : (size == 4 ? SIZE4_CHAR48_WIDTH : SIZE5_CHAR48_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR48_HEIGHT : (size == 2 ? SIZE2_CHAR48_HEIGHT : (size == 3 ? SIZE3_CHAR48_HEIGHT : (size == 4 ? SIZE4_CHAR48_HEIGHT : SIZE5_CHAR48_HEIGHT))));
            end
            49: begin
               char_x = (size == 1 ? SIZE1_CHAR49_X : (size == 2 ? SIZE2_CHAR49_X : (size == 3 ? SIZE3_CHAR49_X : (size == 4 ? SIZE4_CHAR49_X : SIZE5_CHAR49_X))));
               char_y = (size == 1 ? SIZE1_CHAR49_Y : (size == 2 ? SIZE2_CHAR49_Y : (size == 3 ? SIZE3_CHAR49_Y : (size == 4 ? SIZE4_CHAR49_Y : SIZE5_CHAR49_Y))));
               char_width = (size == 1 ? SIZE1_CHAR49_WIDTH : (size == 2 ? SIZE2_CHAR49_WIDTH : (size == 3 ? SIZE3_CHAR49_WIDTH : (size == 4 ? SIZE4_CHAR49_WIDTH : SIZE5_CHAR49_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR49_HEIGHT : (size == 2 ? SIZE2_CHAR49_HEIGHT : (size == 3 ? SIZE3_CHAR49_HEIGHT : (size == 4 ? SIZE4_CHAR49_HEIGHT : SIZE5_CHAR49_HEIGHT))));
            end
            50: begin
               char_x = (size == 1 ? SIZE1_CHAR50_X : (size == 2 ? SIZE2_CHAR50_X : (size == 3 ? SIZE3_CHAR50_X : (size == 4 ? SIZE4_CHAR50_X : SIZE5_CHAR50_X))));
               char_y = (size == 1 ? SIZE1_CHAR50_Y : (size == 2 ? SIZE2_CHAR50_Y : (size == 3 ? SIZE3_CHAR50_Y : (size == 4 ? SIZE4_CHAR50_Y : SIZE5_CHAR50_Y))));
               char_width = (size == 1 ? SIZE1_CHAR50_WIDTH : (size == 2 ? SIZE2_CHAR50_WIDTH : (size == 3 ? SIZE3_CHAR50_WIDTH : (size == 4 ? SIZE4_CHAR50_WIDTH : SIZE5_CHAR50_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR50_HEIGHT : (size == 2 ? SIZE2_CHAR50_HEIGHT : (size == 3 ? SIZE3_CHAR50_HEIGHT : (size == 4 ? SIZE4_CHAR50_HEIGHT : SIZE5_CHAR50_HEIGHT))));
            end
            51: begin
               char_x = (size == 1 ? SIZE1_CHAR51_X : (size == 2 ? SIZE2_CHAR51_X : (size == 3 ? SIZE3_CHAR51_X : (size == 4 ? SIZE4_CHAR51_X : SIZE5_CHAR51_X))));
               char_y = (size == 1 ? SIZE1_CHAR51_Y : (size == 2 ? SIZE2_CHAR51_Y : (size == 3 ? SIZE3_CHAR51_Y : (size == 4 ? SIZE4_CHAR51_Y : SIZE5_CHAR51_Y))));
               char_width = (size == 1 ? SIZE1_CHAR51_WIDTH : (size == 2 ? SIZE2_CHAR51_WIDTH : (size == 3 ? SIZE3_CHAR51_WIDTH : (size == 4 ? SIZE4_CHAR51_WIDTH : SIZE5_CHAR51_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR51_HEIGHT : (size == 2 ? SIZE2_CHAR51_HEIGHT : (size == 3 ? SIZE3_CHAR51_HEIGHT : (size == 4 ? SIZE4_CHAR51_HEIGHT : SIZE5_CHAR51_HEIGHT))));
            end
            52: begin
               char_x = (size == 1 ? SIZE1_CHAR52_X : (size == 2 ? SIZE2_CHAR52_X : (size == 3 ? SIZE3_CHAR52_X : (size == 4 ? SIZE4_CHAR52_X : SIZE5_CHAR52_X))));
               char_y = (size == 1 ? SIZE1_CHAR52_Y : (size == 2 ? SIZE2_CHAR52_Y : (size == 3 ? SIZE3_CHAR52_Y : (size == 4 ? SIZE4_CHAR52_Y : SIZE5_CHAR52_Y))));
               char_width = (size == 1 ? SIZE1_CHAR52_WIDTH : (size == 2 ? SIZE2_CHAR52_WIDTH : (size == 3 ? SIZE3_CHAR52_WIDTH : (size == 4 ? SIZE4_CHAR52_WIDTH : SIZE5_CHAR52_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR52_HEIGHT : (size == 2 ? SIZE2_CHAR52_HEIGHT : (size == 3 ? SIZE3_CHAR52_HEIGHT : (size == 4 ? SIZE4_CHAR52_HEIGHT : SIZE5_CHAR52_HEIGHT))));
            end
            53: begin
               char_x = (size == 1 ? SIZE1_CHAR53_X : (size == 2 ? SIZE2_CHAR53_X : (size == 3 ? SIZE3_CHAR53_X : (size == 4 ? SIZE4_CHAR53_X : SIZE5_CHAR53_X))));
               char_y = (size == 1 ? SIZE1_CHAR53_Y : (size == 2 ? SIZE2_CHAR53_Y : (size == 3 ? SIZE3_CHAR53_Y : (size == 4 ? SIZE4_CHAR53_Y : SIZE5_CHAR53_Y))));
               char_width = (size == 1 ? SIZE1_CHAR53_WIDTH : (size == 2 ? SIZE2_CHAR53_WIDTH : (size == 3 ? SIZE3_CHAR53_WIDTH : (size == 4 ? SIZE4_CHAR53_WIDTH : SIZE5_CHAR53_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR53_HEIGHT : (size == 2 ? SIZE2_CHAR53_HEIGHT : (size == 3 ? SIZE3_CHAR53_HEIGHT : (size == 4 ? SIZE4_CHAR53_HEIGHT : SIZE5_CHAR53_HEIGHT))));
            end
            54: begin
               char_x = (size == 1 ? SIZE1_CHAR54_X : (size == 2 ? SIZE2_CHAR54_X : (size == 3 ? SIZE3_CHAR54_X : (size == 4 ? SIZE4_CHAR54_X : SIZE5_CHAR54_X))));
               char_y = (size == 1 ? SIZE1_CHAR54_Y : (size == 2 ? SIZE2_CHAR54_Y : (size == 3 ? SIZE3_CHAR54_Y : (size == 4 ? SIZE4_CHAR54_Y : SIZE5_CHAR54_Y))));
               char_width = (size == 1 ? SIZE1_CHAR54_WIDTH : (size == 2 ? SIZE2_CHAR54_WIDTH : (size == 3 ? SIZE3_CHAR54_WIDTH : (size == 4 ? SIZE4_CHAR54_WIDTH : SIZE5_CHAR54_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR54_HEIGHT : (size == 2 ? SIZE2_CHAR54_HEIGHT : (size == 3 ? SIZE3_CHAR54_HEIGHT : (size == 4 ? SIZE4_CHAR54_HEIGHT : SIZE5_CHAR54_HEIGHT))));
            end
            55: begin
               char_x = (size == 1 ? SIZE1_CHAR55_X : (size == 2 ? SIZE2_CHAR55_X : (size == 3 ? SIZE3_CHAR55_X : (size == 4 ? SIZE4_CHAR55_X : SIZE5_CHAR55_X))));
               char_y = (size == 1 ? SIZE1_CHAR55_Y : (size == 2 ? SIZE2_CHAR55_Y : (size == 3 ? SIZE3_CHAR55_Y : (size == 4 ? SIZE4_CHAR55_Y : SIZE5_CHAR55_Y))));
               char_width = (size == 1 ? SIZE1_CHAR55_WIDTH : (size == 2 ? SIZE2_CHAR55_WIDTH : (size == 3 ? SIZE3_CHAR55_WIDTH : (size == 4 ? SIZE4_CHAR55_WIDTH : SIZE5_CHAR55_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR55_HEIGHT : (size == 2 ? SIZE2_CHAR55_HEIGHT : (size == 3 ? SIZE3_CHAR55_HEIGHT : (size == 4 ? SIZE4_CHAR55_HEIGHT : SIZE5_CHAR55_HEIGHT))));
            end
            56: begin
               char_x = (size == 1 ? SIZE1_CHAR56_X : (size == 2 ? SIZE2_CHAR56_X : (size == 3 ? SIZE3_CHAR56_X : (size == 4 ? SIZE4_CHAR56_X : SIZE5_CHAR56_X))));
               char_y = (size == 1 ? SIZE1_CHAR56_Y : (size == 2 ? SIZE2_CHAR56_Y : (size == 3 ? SIZE3_CHAR56_Y : (size == 4 ? SIZE4_CHAR56_Y : SIZE5_CHAR56_Y))));
               char_width = (size == 1 ? SIZE1_CHAR56_WIDTH : (size == 2 ? SIZE2_CHAR56_WIDTH : (size == 3 ? SIZE3_CHAR56_WIDTH : (size == 4 ? SIZE4_CHAR56_WIDTH : SIZE5_CHAR56_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR56_HEIGHT : (size == 2 ? SIZE2_CHAR56_HEIGHT : (size == 3 ? SIZE3_CHAR56_HEIGHT : (size == 4 ? SIZE4_CHAR56_HEIGHT : SIZE5_CHAR56_HEIGHT))));
            end
            57: begin
               char_x = (size == 1 ? SIZE1_CHAR57_X : (size == 2 ? SIZE2_CHAR57_X : (size == 3 ? SIZE3_CHAR57_X : (size == 4 ? SIZE4_CHAR57_X : SIZE5_CHAR57_X))));
               char_y = (size == 1 ? SIZE1_CHAR57_Y : (size == 2 ? SIZE2_CHAR57_Y : (size == 3 ? SIZE3_CHAR57_Y : (size == 4 ? SIZE4_CHAR57_Y : SIZE5_CHAR57_Y))));
               char_width = (size == 1 ? SIZE1_CHAR57_WIDTH : (size == 2 ? SIZE2_CHAR57_WIDTH : (size == 3 ? SIZE3_CHAR57_WIDTH : (size == 4 ? SIZE4_CHAR57_WIDTH : SIZE5_CHAR57_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR57_HEIGHT : (size == 2 ? SIZE2_CHAR57_HEIGHT : (size == 3 ? SIZE3_CHAR57_HEIGHT : (size == 4 ? SIZE4_CHAR57_HEIGHT : SIZE5_CHAR57_HEIGHT))));
            end
            58: begin
               char_x = (size == 1 ? SIZE1_CHAR58_X : (size == 2 ? SIZE2_CHAR58_X : (size == 3 ? SIZE3_CHAR58_X : (size == 4 ? SIZE4_CHAR58_X : SIZE5_CHAR58_X))));
               char_y = (size == 1 ? SIZE1_CHAR58_Y : (size == 2 ? SIZE2_CHAR58_Y : (size == 3 ? SIZE3_CHAR58_Y : (size == 4 ? SIZE4_CHAR58_Y : SIZE5_CHAR58_Y))));
               char_width = (size == 1 ? SIZE1_CHAR58_WIDTH : (size == 2 ? SIZE2_CHAR58_WIDTH : (size == 3 ? SIZE3_CHAR58_WIDTH : (size == 4 ? SIZE4_CHAR58_WIDTH : SIZE5_CHAR58_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR58_HEIGHT : (size == 2 ? SIZE2_CHAR58_HEIGHT : (size == 3 ? SIZE3_CHAR58_HEIGHT : (size == 4 ? SIZE4_CHAR58_HEIGHT : SIZE5_CHAR58_HEIGHT))));
            end
            59: begin
               char_x = (size == 1 ? SIZE1_CHAR59_X : (size == 2 ? SIZE2_CHAR59_X : (size == 3 ? SIZE3_CHAR59_X : (size == 4 ? SIZE4_CHAR59_X : SIZE5_CHAR59_X))));
               char_y = (size == 1 ? SIZE1_CHAR59_Y : (size == 2 ? SIZE2_CHAR59_Y : (size == 3 ? SIZE3_CHAR59_Y : (size == 4 ? SIZE4_CHAR59_Y : SIZE5_CHAR59_Y))));
               char_width = (size == 1 ? SIZE1_CHAR59_WIDTH : (size == 2 ? SIZE2_CHAR59_WIDTH : (size == 3 ? SIZE3_CHAR59_WIDTH : (size == 4 ? SIZE4_CHAR59_WIDTH : SIZE5_CHAR59_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR59_HEIGHT : (size == 2 ? SIZE2_CHAR59_HEIGHT : (size == 3 ? SIZE3_CHAR59_HEIGHT : (size == 4 ? SIZE4_CHAR59_HEIGHT : SIZE5_CHAR59_HEIGHT))));
            end
            60: begin
               char_x = (size == 1 ? SIZE1_CHAR60_X : (size == 2 ? SIZE2_CHAR60_X : (size == 3 ? SIZE3_CHAR60_X : (size == 4 ? SIZE4_CHAR60_X : SIZE5_CHAR60_X))));
               char_y = (size == 1 ? SIZE1_CHAR60_Y : (size == 2 ? SIZE2_CHAR60_Y : (size == 3 ? SIZE3_CHAR60_Y : (size == 4 ? SIZE4_CHAR60_Y : SIZE5_CHAR60_Y))));
               char_width = (size == 1 ? SIZE1_CHAR60_WIDTH : (size == 2 ? SIZE2_CHAR60_WIDTH : (size == 3 ? SIZE3_CHAR60_WIDTH : (size == 4 ? SIZE4_CHAR60_WIDTH : SIZE5_CHAR60_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR60_HEIGHT : (size == 2 ? SIZE2_CHAR60_HEIGHT : (size == 3 ? SIZE3_CHAR60_HEIGHT : (size == 4 ? SIZE4_CHAR60_HEIGHT : SIZE5_CHAR60_HEIGHT))));
            end
            61: begin
               char_x = (size == 1 ? SIZE1_CHAR61_X : (size == 2 ? SIZE2_CHAR61_X : (size == 3 ? SIZE3_CHAR61_X : (size == 4 ? SIZE4_CHAR61_X : SIZE5_CHAR61_X))));
               char_y = (size == 1 ? SIZE1_CHAR61_Y : (size == 2 ? SIZE2_CHAR61_Y : (size == 3 ? SIZE3_CHAR61_Y : (size == 4 ? SIZE4_CHAR61_Y : SIZE5_CHAR61_Y))));
               char_width = (size == 1 ? SIZE1_CHAR61_WIDTH : (size == 2 ? SIZE2_CHAR61_WIDTH : (size == 3 ? SIZE3_CHAR61_WIDTH : (size == 4 ? SIZE4_CHAR61_WIDTH : SIZE5_CHAR61_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR61_HEIGHT : (size == 2 ? SIZE2_CHAR61_HEIGHT : (size == 3 ? SIZE3_CHAR61_HEIGHT : (size == 4 ? SIZE4_CHAR61_HEIGHT : SIZE5_CHAR61_HEIGHT))));
            end
            62: begin
               char_x = (size == 1 ? SIZE1_CHAR62_X : (size == 2 ? SIZE2_CHAR62_X : (size == 3 ? SIZE3_CHAR62_X : (size == 4 ? SIZE4_CHAR62_X : SIZE5_CHAR62_X))));
               char_y = (size == 1 ? SIZE1_CHAR62_Y : (size == 2 ? SIZE2_CHAR62_Y : (size == 3 ? SIZE3_CHAR62_Y : (size == 4 ? SIZE4_CHAR62_Y : SIZE5_CHAR62_Y))));
               char_width = (size == 1 ? SIZE1_CHAR62_WIDTH : (size == 2 ? SIZE2_CHAR62_WIDTH : (size == 3 ? SIZE3_CHAR62_WIDTH : (size == 4 ? SIZE4_CHAR62_WIDTH : SIZE5_CHAR62_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR62_HEIGHT : (size == 2 ? SIZE2_CHAR62_HEIGHT : (size == 3 ? SIZE3_CHAR62_HEIGHT : (size == 4 ? SIZE4_CHAR62_HEIGHT : SIZE5_CHAR62_HEIGHT))));
            end
            63: begin
               char_x = (size == 1 ? SIZE1_CHAR63_X : (size == 2 ? SIZE2_CHAR63_X : (size == 3 ? SIZE3_CHAR63_X : (size == 4 ? SIZE4_CHAR63_X : SIZE5_CHAR63_X))));
               char_y = (size == 1 ? SIZE1_CHAR63_Y : (size == 2 ? SIZE2_CHAR63_Y : (size == 3 ? SIZE3_CHAR63_Y : (size == 4 ? SIZE4_CHAR63_Y : SIZE5_CHAR63_Y))));
               char_width = (size == 1 ? SIZE1_CHAR63_WIDTH : (size == 2 ? SIZE2_CHAR63_WIDTH : (size == 3 ? SIZE3_CHAR63_WIDTH : (size == 4 ? SIZE4_CHAR63_WIDTH : SIZE5_CHAR63_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR63_HEIGHT : (size == 2 ? SIZE2_CHAR63_HEIGHT : (size == 3 ? SIZE3_CHAR63_HEIGHT : (size == 4 ? SIZE4_CHAR63_HEIGHT : SIZE5_CHAR63_HEIGHT))));
            end
            64: begin
               char_x = (size == 1 ? SIZE1_CHAR64_X : (size == 2 ? SIZE2_CHAR64_X : (size == 3 ? SIZE3_CHAR64_X : (size == 4 ? SIZE4_CHAR64_X : SIZE5_CHAR64_X))));
               char_y = (size == 1 ? SIZE1_CHAR64_Y : (size == 2 ? SIZE2_CHAR64_Y : (size == 3 ? SIZE3_CHAR64_Y : (size == 4 ? SIZE4_CHAR64_Y : SIZE5_CHAR64_Y))));
               char_width = (size == 1 ? SIZE1_CHAR64_WIDTH : (size == 2 ? SIZE2_CHAR64_WIDTH : (size == 3 ? SIZE3_CHAR64_WIDTH : (size == 4 ? SIZE4_CHAR64_WIDTH : SIZE5_CHAR64_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR64_HEIGHT : (size == 2 ? SIZE2_CHAR64_HEIGHT : (size == 3 ? SIZE3_CHAR64_HEIGHT : (size == 4 ? SIZE4_CHAR64_HEIGHT : SIZE5_CHAR64_HEIGHT))));
            end
            65: begin
               char_x = (size == 1 ? SIZE1_CHAR65_X : (size == 2 ? SIZE2_CHAR65_X : (size == 3 ? SIZE3_CHAR65_X : (size == 4 ? SIZE4_CHAR65_X : SIZE5_CHAR65_X))));
               char_y = (size == 1 ? SIZE1_CHAR65_Y : (size == 2 ? SIZE2_CHAR65_Y : (size == 3 ? SIZE3_CHAR65_Y : (size == 4 ? SIZE4_CHAR65_Y : SIZE5_CHAR65_Y))));
               char_width = (size == 1 ? SIZE1_CHAR65_WIDTH : (size == 2 ? SIZE2_CHAR65_WIDTH : (size == 3 ? SIZE3_CHAR65_WIDTH : (size == 4 ? SIZE4_CHAR65_WIDTH : SIZE5_CHAR65_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR65_HEIGHT : (size == 2 ? SIZE2_CHAR65_HEIGHT : (size == 3 ? SIZE3_CHAR65_HEIGHT : (size == 4 ? SIZE4_CHAR65_HEIGHT : SIZE5_CHAR65_HEIGHT))));
            end
            66: begin
               char_x = (size == 1 ? SIZE1_CHAR66_X : (size == 2 ? SIZE2_CHAR66_X : (size == 3 ? SIZE3_CHAR66_X : (size == 4 ? SIZE4_CHAR66_X : SIZE5_CHAR66_X))));
               char_y = (size == 1 ? SIZE1_CHAR66_Y : (size == 2 ? SIZE2_CHAR66_Y : (size == 3 ? SIZE3_CHAR66_Y : (size == 4 ? SIZE4_CHAR66_Y : SIZE5_CHAR66_Y))));
               char_width = (size == 1 ? SIZE1_CHAR66_WIDTH : (size == 2 ? SIZE2_CHAR66_WIDTH : (size == 3 ? SIZE3_CHAR66_WIDTH : (size == 4 ? SIZE4_CHAR66_WIDTH : SIZE5_CHAR66_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR66_HEIGHT : (size == 2 ? SIZE2_CHAR66_HEIGHT : (size == 3 ? SIZE3_CHAR66_HEIGHT : (size == 4 ? SIZE4_CHAR66_HEIGHT : SIZE5_CHAR66_HEIGHT))));
            end
            67: begin
               char_x = (size == 1 ? SIZE1_CHAR67_X : (size == 2 ? SIZE2_CHAR67_X : (size == 3 ? SIZE3_CHAR67_X : (size == 4 ? SIZE4_CHAR67_X : SIZE5_CHAR67_X))));
               char_y = (size == 1 ? SIZE1_CHAR67_Y : (size == 2 ? SIZE2_CHAR67_Y : (size == 3 ? SIZE3_CHAR67_Y : (size == 4 ? SIZE4_CHAR67_Y : SIZE5_CHAR67_Y))));
               char_width = (size == 1 ? SIZE1_CHAR67_WIDTH : (size == 2 ? SIZE2_CHAR67_WIDTH : (size == 3 ? SIZE3_CHAR67_WIDTH : (size == 4 ? SIZE4_CHAR67_WIDTH : SIZE5_CHAR67_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR67_HEIGHT : (size == 2 ? SIZE2_CHAR67_HEIGHT : (size == 3 ? SIZE3_CHAR67_HEIGHT : (size == 4 ? SIZE4_CHAR67_HEIGHT : SIZE5_CHAR67_HEIGHT))));
            end
            68: begin
               char_x = (size == 1 ? SIZE1_CHAR68_X : (size == 2 ? SIZE2_CHAR68_X : (size == 3 ? SIZE3_CHAR68_X : (size == 4 ? SIZE4_CHAR68_X : SIZE5_CHAR68_X))));
               char_y = (size == 1 ? SIZE1_CHAR68_Y : (size == 2 ? SIZE2_CHAR68_Y : (size == 3 ? SIZE3_CHAR68_Y : (size == 4 ? SIZE4_CHAR68_Y : SIZE5_CHAR68_Y))));
               char_width = (size == 1 ? SIZE1_CHAR68_WIDTH : (size == 2 ? SIZE2_CHAR68_WIDTH : (size == 3 ? SIZE3_CHAR68_WIDTH : (size == 4 ? SIZE4_CHAR68_WIDTH : SIZE5_CHAR68_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR68_HEIGHT : (size == 2 ? SIZE2_CHAR68_HEIGHT : (size == 3 ? SIZE3_CHAR68_HEIGHT : (size == 4 ? SIZE4_CHAR68_HEIGHT : SIZE5_CHAR68_HEIGHT))));
            end
            69: begin
               char_x = (size == 1 ? SIZE1_CHAR69_X : (size == 2 ? SIZE2_CHAR69_X : (size == 3 ? SIZE3_CHAR69_X : (size == 4 ? SIZE4_CHAR69_X : SIZE5_CHAR69_X))));
               char_y = (size == 1 ? SIZE1_CHAR69_Y : (size == 2 ? SIZE2_CHAR69_Y : (size == 3 ? SIZE3_CHAR69_Y : (size == 4 ? SIZE4_CHAR69_Y : SIZE5_CHAR69_Y))));
               char_width = (size == 1 ? SIZE1_CHAR69_WIDTH : (size == 2 ? SIZE2_CHAR69_WIDTH : (size == 3 ? SIZE3_CHAR69_WIDTH : (size == 4 ? SIZE4_CHAR69_WIDTH : SIZE5_CHAR69_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR69_HEIGHT : (size == 2 ? SIZE2_CHAR69_HEIGHT : (size == 3 ? SIZE3_CHAR69_HEIGHT : (size == 4 ? SIZE4_CHAR69_HEIGHT : SIZE5_CHAR69_HEIGHT))));
            end
            70: begin
               char_x = (size == 1 ? SIZE1_CHAR70_X : (size == 2 ? SIZE2_CHAR70_X : (size == 3 ? SIZE3_CHAR70_X : (size == 4 ? SIZE4_CHAR70_X : SIZE5_CHAR70_X))));
               char_y = (size == 1 ? SIZE1_CHAR70_Y : (size == 2 ? SIZE2_CHAR70_Y : (size == 3 ? SIZE3_CHAR70_Y : (size == 4 ? SIZE4_CHAR70_Y : SIZE5_CHAR70_Y))));
               char_width = (size == 1 ? SIZE1_CHAR70_WIDTH : (size == 2 ? SIZE2_CHAR70_WIDTH : (size == 3 ? SIZE3_CHAR70_WIDTH : (size == 4 ? SIZE4_CHAR70_WIDTH : SIZE5_CHAR70_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR70_HEIGHT : (size == 2 ? SIZE2_CHAR70_HEIGHT : (size == 3 ? SIZE3_CHAR70_HEIGHT : (size == 4 ? SIZE4_CHAR70_HEIGHT : SIZE5_CHAR70_HEIGHT))));
            end
            71: begin
               char_x = (size == 1 ? SIZE1_CHAR71_X : (size == 2 ? SIZE2_CHAR71_X : (size == 3 ? SIZE3_CHAR71_X : (size == 4 ? SIZE4_CHAR71_X : SIZE5_CHAR71_X))));
               char_y = (size == 1 ? SIZE1_CHAR71_Y : (size == 2 ? SIZE2_CHAR71_Y : (size == 3 ? SIZE3_CHAR71_Y : (size == 4 ? SIZE4_CHAR71_Y : SIZE5_CHAR71_Y))));
               char_width = (size == 1 ? SIZE1_CHAR71_WIDTH : (size == 2 ? SIZE2_CHAR71_WIDTH : (size == 3 ? SIZE3_CHAR71_WIDTH : (size == 4 ? SIZE4_CHAR71_WIDTH : SIZE5_CHAR71_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR71_HEIGHT : (size == 2 ? SIZE2_CHAR71_HEIGHT : (size == 3 ? SIZE3_CHAR71_HEIGHT : (size == 4 ? SIZE4_CHAR71_HEIGHT : SIZE5_CHAR71_HEIGHT))));
            end
            72: begin
               char_x = (size == 1 ? SIZE1_CHAR72_X : (size == 2 ? SIZE2_CHAR72_X : (size == 3 ? SIZE3_CHAR72_X : (size == 4 ? SIZE4_CHAR72_X : SIZE5_CHAR72_X))));
               char_y = (size == 1 ? SIZE1_CHAR72_Y : (size == 2 ? SIZE2_CHAR72_Y : (size == 3 ? SIZE3_CHAR72_Y : (size == 4 ? SIZE4_CHAR72_Y : SIZE5_CHAR72_Y))));
               char_width = (size == 1 ? SIZE1_CHAR72_WIDTH : (size == 2 ? SIZE2_CHAR72_WIDTH : (size == 3 ? SIZE3_CHAR72_WIDTH : (size == 4 ? SIZE4_CHAR72_WIDTH : SIZE5_CHAR72_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR72_HEIGHT : (size == 2 ? SIZE2_CHAR72_HEIGHT : (size == 3 ? SIZE3_CHAR72_HEIGHT : (size == 4 ? SIZE4_CHAR72_HEIGHT : SIZE5_CHAR72_HEIGHT))));
            end
            73: begin
               char_x = (size == 1 ? SIZE1_CHAR73_X : (size == 2 ? SIZE2_CHAR73_X : (size == 3 ? SIZE3_CHAR73_X : (size == 4 ? SIZE4_CHAR73_X : SIZE5_CHAR73_X))));
               char_y = (size == 1 ? SIZE1_CHAR73_Y : (size == 2 ? SIZE2_CHAR73_Y : (size == 3 ? SIZE3_CHAR73_Y : (size == 4 ? SIZE4_CHAR73_Y : SIZE5_CHAR73_Y))));
               char_width = (size == 1 ? SIZE1_CHAR73_WIDTH : (size == 2 ? SIZE2_CHAR73_WIDTH : (size == 3 ? SIZE3_CHAR73_WIDTH : (size == 4 ? SIZE4_CHAR73_WIDTH : SIZE5_CHAR73_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR73_HEIGHT : (size == 2 ? SIZE2_CHAR73_HEIGHT : (size == 3 ? SIZE3_CHAR73_HEIGHT : (size == 4 ? SIZE4_CHAR73_HEIGHT : SIZE5_CHAR73_HEIGHT))));
            end
            74: begin
               char_x = (size == 1 ? SIZE1_CHAR74_X : (size == 2 ? SIZE2_CHAR74_X : (size == 3 ? SIZE3_CHAR74_X : (size == 4 ? SIZE4_CHAR74_X : SIZE5_CHAR74_X))));
               char_y = (size == 1 ? SIZE1_CHAR74_Y : (size == 2 ? SIZE2_CHAR74_Y : (size == 3 ? SIZE3_CHAR74_Y : (size == 4 ? SIZE4_CHAR74_Y : SIZE5_CHAR74_Y))));
               char_width = (size == 1 ? SIZE1_CHAR74_WIDTH : (size == 2 ? SIZE2_CHAR74_WIDTH : (size == 3 ? SIZE3_CHAR74_WIDTH : (size == 4 ? SIZE4_CHAR74_WIDTH : SIZE5_CHAR74_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR74_HEIGHT : (size == 2 ? SIZE2_CHAR74_HEIGHT : (size == 3 ? SIZE3_CHAR74_HEIGHT : (size == 4 ? SIZE4_CHAR74_HEIGHT : SIZE5_CHAR74_HEIGHT))));
            end
            75: begin
               char_x = (size == 1 ? SIZE1_CHAR75_X : (size == 2 ? SIZE2_CHAR75_X : (size == 3 ? SIZE3_CHAR75_X : (size == 4 ? SIZE4_CHAR75_X : SIZE5_CHAR75_X))));
               char_y = (size == 1 ? SIZE1_CHAR75_Y : (size == 2 ? SIZE2_CHAR75_Y : (size == 3 ? SIZE3_CHAR75_Y : (size == 4 ? SIZE4_CHAR75_Y : SIZE5_CHAR75_Y))));
               char_width = (size == 1 ? SIZE1_CHAR75_WIDTH : (size == 2 ? SIZE2_CHAR75_WIDTH : (size == 3 ? SIZE3_CHAR75_WIDTH : (size == 4 ? SIZE4_CHAR75_WIDTH : SIZE5_CHAR75_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR75_HEIGHT : (size == 2 ? SIZE2_CHAR75_HEIGHT : (size == 3 ? SIZE3_CHAR75_HEIGHT : (size == 4 ? SIZE4_CHAR75_HEIGHT : SIZE5_CHAR75_HEIGHT))));
            end
            76: begin
               char_x = (size == 1 ? SIZE1_CHAR76_X : (size == 2 ? SIZE2_CHAR76_X : (size == 3 ? SIZE3_CHAR76_X : (size == 4 ? SIZE4_CHAR76_X : SIZE5_CHAR76_X))));
               char_y = (size == 1 ? SIZE1_CHAR76_Y : (size == 2 ? SIZE2_CHAR76_Y : (size == 3 ? SIZE3_CHAR76_Y : (size == 4 ? SIZE4_CHAR76_Y : SIZE5_CHAR76_Y))));
               char_width = (size == 1 ? SIZE1_CHAR76_WIDTH : (size == 2 ? SIZE2_CHAR76_WIDTH : (size == 3 ? SIZE3_CHAR76_WIDTH : (size == 4 ? SIZE4_CHAR76_WIDTH : SIZE5_CHAR76_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR76_HEIGHT : (size == 2 ? SIZE2_CHAR76_HEIGHT : (size == 3 ? SIZE3_CHAR76_HEIGHT : (size == 4 ? SIZE4_CHAR76_HEIGHT : SIZE5_CHAR76_HEIGHT))));
            end
            77: begin
               char_x = (size == 1 ? SIZE1_CHAR77_X : (size == 2 ? SIZE2_CHAR77_X : (size == 3 ? SIZE3_CHAR77_X : (size == 4 ? SIZE4_CHAR77_X : SIZE5_CHAR77_X))));
               char_y = (size == 1 ? SIZE1_CHAR77_Y : (size == 2 ? SIZE2_CHAR77_Y : (size == 3 ? SIZE3_CHAR77_Y : (size == 4 ? SIZE4_CHAR77_Y : SIZE5_CHAR77_Y))));
               char_width = (size == 1 ? SIZE1_CHAR77_WIDTH : (size == 2 ? SIZE2_CHAR77_WIDTH : (size == 3 ? SIZE3_CHAR77_WIDTH : (size == 4 ? SIZE4_CHAR77_WIDTH : SIZE5_CHAR77_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR77_HEIGHT : (size == 2 ? SIZE2_CHAR77_HEIGHT : (size == 3 ? SIZE3_CHAR77_HEIGHT : (size == 4 ? SIZE4_CHAR77_HEIGHT : SIZE5_CHAR77_HEIGHT))));
            end
            78: begin
               char_x = (size == 1 ? SIZE1_CHAR78_X : (size == 2 ? SIZE2_CHAR78_X : (size == 3 ? SIZE3_CHAR78_X : (size == 4 ? SIZE4_CHAR78_X : SIZE5_CHAR78_X))));
               char_y = (size == 1 ? SIZE1_CHAR78_Y : (size == 2 ? SIZE2_CHAR78_Y : (size == 3 ? SIZE3_CHAR78_Y : (size == 4 ? SIZE4_CHAR78_Y : SIZE5_CHAR78_Y))));
               char_width = (size == 1 ? SIZE1_CHAR78_WIDTH : (size == 2 ? SIZE2_CHAR78_WIDTH : (size == 3 ? SIZE3_CHAR78_WIDTH : (size == 4 ? SIZE4_CHAR78_WIDTH : SIZE5_CHAR78_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR78_HEIGHT : (size == 2 ? SIZE2_CHAR78_HEIGHT : (size == 3 ? SIZE3_CHAR78_HEIGHT : (size == 4 ? SIZE4_CHAR78_HEIGHT : SIZE5_CHAR78_HEIGHT))));
            end
            79: begin
               char_x = (size == 1 ? SIZE1_CHAR79_X : (size == 2 ? SIZE2_CHAR79_X : (size == 3 ? SIZE3_CHAR79_X : (size == 4 ? SIZE4_CHAR79_X : SIZE5_CHAR79_X))));
               char_y = (size == 1 ? SIZE1_CHAR79_Y : (size == 2 ? SIZE2_CHAR79_Y : (size == 3 ? SIZE3_CHAR79_Y : (size == 4 ? SIZE4_CHAR79_Y : SIZE5_CHAR79_Y))));
               char_width = (size == 1 ? SIZE1_CHAR79_WIDTH : (size == 2 ? SIZE2_CHAR79_WIDTH : (size == 3 ? SIZE3_CHAR79_WIDTH : (size == 4 ? SIZE4_CHAR79_WIDTH : SIZE5_CHAR79_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR79_HEIGHT : (size == 2 ? SIZE2_CHAR79_HEIGHT : (size == 3 ? SIZE3_CHAR79_HEIGHT : (size == 4 ? SIZE4_CHAR79_HEIGHT : SIZE5_CHAR79_HEIGHT))));
            end
            80: begin
               char_x = (size == 1 ? SIZE1_CHAR80_X : (size == 2 ? SIZE2_CHAR80_X : (size == 3 ? SIZE3_CHAR80_X : (size == 4 ? SIZE4_CHAR80_X : SIZE5_CHAR80_X))));
               char_y = (size == 1 ? SIZE1_CHAR80_Y : (size == 2 ? SIZE2_CHAR80_Y : (size == 3 ? SIZE3_CHAR80_Y : (size == 4 ? SIZE4_CHAR80_Y : SIZE5_CHAR80_Y))));
               char_width = (size == 1 ? SIZE1_CHAR80_WIDTH : (size == 2 ? SIZE2_CHAR80_WIDTH : (size == 3 ? SIZE3_CHAR80_WIDTH : (size == 4 ? SIZE4_CHAR80_WIDTH : SIZE5_CHAR80_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR80_HEIGHT : (size == 2 ? SIZE2_CHAR80_HEIGHT : (size == 3 ? SIZE3_CHAR80_HEIGHT : (size == 4 ? SIZE4_CHAR80_HEIGHT : SIZE5_CHAR80_HEIGHT))));
            end
            81: begin
               char_x = (size == 1 ? SIZE1_CHAR81_X : (size == 2 ? SIZE2_CHAR81_X : (size == 3 ? SIZE3_CHAR81_X : (size == 4 ? SIZE4_CHAR81_X : SIZE5_CHAR81_X))));
               char_y = (size == 1 ? SIZE1_CHAR81_Y : (size == 2 ? SIZE2_CHAR81_Y : (size == 3 ? SIZE3_CHAR81_Y : (size == 4 ? SIZE4_CHAR81_Y : SIZE5_CHAR81_Y))));
               char_width = (size == 1 ? SIZE1_CHAR81_WIDTH : (size == 2 ? SIZE2_CHAR81_WIDTH : (size == 3 ? SIZE3_CHAR81_WIDTH : (size == 4 ? SIZE4_CHAR81_WIDTH : SIZE5_CHAR81_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR81_HEIGHT : (size == 2 ? SIZE2_CHAR81_HEIGHT : (size == 3 ? SIZE3_CHAR81_HEIGHT : (size == 4 ? SIZE4_CHAR81_HEIGHT : SIZE5_CHAR81_HEIGHT))));
            end
            82: begin
               char_x = (size == 1 ? SIZE1_CHAR82_X : (size == 2 ? SIZE2_CHAR82_X : (size == 3 ? SIZE3_CHAR82_X : (size == 4 ? SIZE4_CHAR82_X : SIZE5_CHAR82_X))));
               char_y = (size == 1 ? SIZE1_CHAR82_Y : (size == 2 ? SIZE2_CHAR82_Y : (size == 3 ? SIZE3_CHAR82_Y : (size == 4 ? SIZE4_CHAR82_Y : SIZE5_CHAR82_Y))));
               char_width = (size == 1 ? SIZE1_CHAR82_WIDTH : (size == 2 ? SIZE2_CHAR82_WIDTH : (size == 3 ? SIZE3_CHAR82_WIDTH : (size == 4 ? SIZE4_CHAR82_WIDTH : SIZE5_CHAR82_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR82_HEIGHT : (size == 2 ? SIZE2_CHAR82_HEIGHT : (size == 3 ? SIZE3_CHAR82_HEIGHT : (size == 4 ? SIZE4_CHAR82_HEIGHT : SIZE5_CHAR82_HEIGHT))));
            end
            83: begin
               char_x = (size == 1 ? SIZE1_CHAR83_X : (size == 2 ? SIZE2_CHAR83_X : (size == 3 ? SIZE3_CHAR83_X : (size == 4 ? SIZE4_CHAR83_X : SIZE5_CHAR83_X))));
               char_y = (size == 1 ? SIZE1_CHAR83_Y : (size == 2 ? SIZE2_CHAR83_Y : (size == 3 ? SIZE3_CHAR83_Y : (size == 4 ? SIZE4_CHAR83_Y : SIZE5_CHAR83_Y))));
               char_width = (size == 1 ? SIZE1_CHAR83_WIDTH : (size == 2 ? SIZE2_CHAR83_WIDTH : (size == 3 ? SIZE3_CHAR83_WIDTH : (size == 4 ? SIZE4_CHAR83_WIDTH : SIZE5_CHAR83_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR83_HEIGHT : (size == 2 ? SIZE2_CHAR83_HEIGHT : (size == 3 ? SIZE3_CHAR83_HEIGHT : (size == 4 ? SIZE4_CHAR83_HEIGHT : SIZE5_CHAR83_HEIGHT))));
            end
            84: begin
               char_x = (size == 1 ? SIZE1_CHAR84_X : (size == 2 ? SIZE2_CHAR84_X : (size == 3 ? SIZE3_CHAR84_X : (size == 4 ? SIZE4_CHAR84_X : SIZE5_CHAR84_X))));
               char_y = (size == 1 ? SIZE1_CHAR84_Y : (size == 2 ? SIZE2_CHAR84_Y : (size == 3 ? SIZE3_CHAR84_Y : (size == 4 ? SIZE4_CHAR84_Y : SIZE5_CHAR84_Y))));
               char_width = (size == 1 ? SIZE1_CHAR84_WIDTH : (size == 2 ? SIZE2_CHAR84_WIDTH : (size == 3 ? SIZE3_CHAR84_WIDTH : (size == 4 ? SIZE4_CHAR84_WIDTH : SIZE5_CHAR84_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR84_HEIGHT : (size == 2 ? SIZE2_CHAR84_HEIGHT : (size == 3 ? SIZE3_CHAR84_HEIGHT : (size == 4 ? SIZE4_CHAR84_HEIGHT : SIZE5_CHAR84_HEIGHT))));
            end
            85: begin
               char_x = (size == 1 ? SIZE1_CHAR85_X : (size == 2 ? SIZE2_CHAR85_X : (size == 3 ? SIZE3_CHAR85_X : (size == 4 ? SIZE4_CHAR85_X : SIZE5_CHAR85_X))));
               char_y = (size == 1 ? SIZE1_CHAR85_Y : (size == 2 ? SIZE2_CHAR85_Y : (size == 3 ? SIZE3_CHAR85_Y : (size == 4 ? SIZE4_CHAR85_Y : SIZE5_CHAR85_Y))));
               char_width = (size == 1 ? SIZE1_CHAR85_WIDTH : (size == 2 ? SIZE2_CHAR85_WIDTH : (size == 3 ? SIZE3_CHAR85_WIDTH : (size == 4 ? SIZE4_CHAR85_WIDTH : SIZE5_CHAR85_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR85_HEIGHT : (size == 2 ? SIZE2_CHAR85_HEIGHT : (size == 3 ? SIZE3_CHAR85_HEIGHT : (size == 4 ? SIZE4_CHAR85_HEIGHT : SIZE5_CHAR85_HEIGHT))));
            end
            86: begin
               char_x = (size == 1 ? SIZE1_CHAR86_X : (size == 2 ? SIZE2_CHAR86_X : (size == 3 ? SIZE3_CHAR86_X : (size == 4 ? SIZE4_CHAR86_X : SIZE5_CHAR86_X))));
               char_y = (size == 1 ? SIZE1_CHAR86_Y : (size == 2 ? SIZE2_CHAR86_Y : (size == 3 ? SIZE3_CHAR86_Y : (size == 4 ? SIZE4_CHAR86_Y : SIZE5_CHAR86_Y))));
               char_width = (size == 1 ? SIZE1_CHAR86_WIDTH : (size == 2 ? SIZE2_CHAR86_WIDTH : (size == 3 ? SIZE3_CHAR86_WIDTH : (size == 4 ? SIZE4_CHAR86_WIDTH : SIZE5_CHAR86_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR86_HEIGHT : (size == 2 ? SIZE2_CHAR86_HEIGHT : (size == 3 ? SIZE3_CHAR86_HEIGHT : (size == 4 ? SIZE4_CHAR86_HEIGHT : SIZE5_CHAR86_HEIGHT))));
            end
            87: begin
               char_x = (size == 1 ? SIZE1_CHAR87_X : (size == 2 ? SIZE2_CHAR87_X : (size == 3 ? SIZE3_CHAR87_X : (size == 4 ? SIZE4_CHAR87_X : SIZE5_CHAR87_X))));
               char_y = (size == 1 ? SIZE1_CHAR87_Y : (size == 2 ? SIZE2_CHAR87_Y : (size == 3 ? SIZE3_CHAR87_Y : (size == 4 ? SIZE4_CHAR87_Y : SIZE5_CHAR87_Y))));
               char_width = (size == 1 ? SIZE1_CHAR87_WIDTH : (size == 2 ? SIZE2_CHAR87_WIDTH : (size == 3 ? SIZE3_CHAR87_WIDTH : (size == 4 ? SIZE4_CHAR87_WIDTH : SIZE5_CHAR87_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR87_HEIGHT : (size == 2 ? SIZE2_CHAR87_HEIGHT : (size == 3 ? SIZE3_CHAR87_HEIGHT : (size == 4 ? SIZE4_CHAR87_HEIGHT : SIZE5_CHAR87_HEIGHT))));
            end
            88: begin
               char_x = (size == 1 ? SIZE1_CHAR88_X : (size == 2 ? SIZE2_CHAR88_X : (size == 3 ? SIZE3_CHAR88_X : (size == 4 ? SIZE4_CHAR88_X : SIZE5_CHAR88_X))));
               char_y = (size == 1 ? SIZE1_CHAR88_Y : (size == 2 ? SIZE2_CHAR88_Y : (size == 3 ? SIZE3_CHAR88_Y : (size == 4 ? SIZE4_CHAR88_Y : SIZE5_CHAR88_Y))));
               char_width = (size == 1 ? SIZE1_CHAR88_WIDTH : (size == 2 ? SIZE2_CHAR88_WIDTH : (size == 3 ? SIZE3_CHAR88_WIDTH : (size == 4 ? SIZE4_CHAR88_WIDTH : SIZE5_CHAR88_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR88_HEIGHT : (size == 2 ? SIZE2_CHAR88_HEIGHT : (size == 3 ? SIZE3_CHAR88_HEIGHT : (size == 4 ? SIZE4_CHAR88_HEIGHT : SIZE5_CHAR88_HEIGHT))));
            end
            89: begin
               char_x = (size == 1 ? SIZE1_CHAR89_X : (size == 2 ? SIZE2_CHAR89_X : (size == 3 ? SIZE3_CHAR89_X : (size == 4 ? SIZE4_CHAR89_X : SIZE5_CHAR89_X))));
               char_y = (size == 1 ? SIZE1_CHAR89_Y : (size == 2 ? SIZE2_CHAR89_Y : (size == 3 ? SIZE3_CHAR89_Y : (size == 4 ? SIZE4_CHAR89_Y : SIZE5_CHAR89_Y))));
               char_width = (size == 1 ? SIZE1_CHAR89_WIDTH : (size == 2 ? SIZE2_CHAR89_WIDTH : (size == 3 ? SIZE3_CHAR89_WIDTH : (size == 4 ? SIZE4_CHAR89_WIDTH : SIZE5_CHAR89_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR89_HEIGHT : (size == 2 ? SIZE2_CHAR89_HEIGHT : (size == 3 ? SIZE3_CHAR89_HEIGHT : (size == 4 ? SIZE4_CHAR89_HEIGHT : SIZE5_CHAR89_HEIGHT))));
            end
            90: begin
               char_x = (size == 1 ? SIZE1_CHAR90_X : (size == 2 ? SIZE2_CHAR90_X : (size == 3 ? SIZE3_CHAR90_X : (size == 4 ? SIZE4_CHAR90_X : SIZE5_CHAR90_X))));
               char_y = (size == 1 ? SIZE1_CHAR90_Y : (size == 2 ? SIZE2_CHAR90_Y : (size == 3 ? SIZE3_CHAR90_Y : (size == 4 ? SIZE4_CHAR90_Y : SIZE5_CHAR90_Y))));
               char_width = (size == 1 ? SIZE1_CHAR90_WIDTH : (size == 2 ? SIZE2_CHAR90_WIDTH : (size == 3 ? SIZE3_CHAR90_WIDTH : (size == 4 ? SIZE4_CHAR90_WIDTH : SIZE5_CHAR90_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR90_HEIGHT : (size == 2 ? SIZE2_CHAR90_HEIGHT : (size == 3 ? SIZE3_CHAR90_HEIGHT : (size == 4 ? SIZE4_CHAR90_HEIGHT : SIZE5_CHAR90_HEIGHT))));
            end
            91: begin
               char_x = (size == 1 ? SIZE1_CHAR91_X : (size == 2 ? SIZE2_CHAR91_X : (size == 3 ? SIZE3_CHAR91_X : (size == 4 ? SIZE4_CHAR91_X : SIZE5_CHAR91_X))));
               char_y = (size == 1 ? SIZE1_CHAR91_Y : (size == 2 ? SIZE2_CHAR91_Y : (size == 3 ? SIZE3_CHAR91_Y : (size == 4 ? SIZE4_CHAR91_Y : SIZE5_CHAR91_Y))));
               char_width = (size == 1 ? SIZE1_CHAR91_WIDTH : (size == 2 ? SIZE2_CHAR91_WIDTH : (size == 3 ? SIZE3_CHAR91_WIDTH : (size == 4 ? SIZE4_CHAR91_WIDTH : SIZE5_CHAR91_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR91_HEIGHT : (size == 2 ? SIZE2_CHAR91_HEIGHT : (size == 3 ? SIZE3_CHAR91_HEIGHT : (size == 4 ? SIZE4_CHAR91_HEIGHT : SIZE5_CHAR91_HEIGHT))));
            end
            92: begin
               char_x = (size == 1 ? SIZE1_CHAR92_X : (size == 2 ? SIZE2_CHAR92_X : (size == 3 ? SIZE3_CHAR92_X : (size == 4 ? SIZE4_CHAR92_X : SIZE5_CHAR92_X))));
               char_y = (size == 1 ? SIZE1_CHAR92_Y : (size == 2 ? SIZE2_CHAR92_Y : (size == 3 ? SIZE3_CHAR92_Y : (size == 4 ? SIZE4_CHAR92_Y : SIZE5_CHAR92_Y))));
               char_width = (size == 1 ? SIZE1_CHAR92_WIDTH : (size == 2 ? SIZE2_CHAR92_WIDTH : (size == 3 ? SIZE3_CHAR92_WIDTH : (size == 4 ? SIZE4_CHAR92_WIDTH : SIZE5_CHAR92_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR92_HEIGHT : (size == 2 ? SIZE2_CHAR92_HEIGHT : (size == 3 ? SIZE3_CHAR92_HEIGHT : (size == 4 ? SIZE4_CHAR92_HEIGHT : SIZE5_CHAR92_HEIGHT))));
            end
            93: begin
               char_x = (size == 1 ? SIZE1_CHAR93_X : (size == 2 ? SIZE2_CHAR93_X : (size == 3 ? SIZE3_CHAR93_X : (size == 4 ? SIZE4_CHAR93_X : SIZE5_CHAR93_X))));
               char_y = (size == 1 ? SIZE1_CHAR93_Y : (size == 2 ? SIZE2_CHAR93_Y : (size == 3 ? SIZE3_CHAR93_Y : (size == 4 ? SIZE4_CHAR93_Y : SIZE5_CHAR93_Y))));
               char_width = (size == 1 ? SIZE1_CHAR93_WIDTH : (size == 2 ? SIZE2_CHAR93_WIDTH : (size == 3 ? SIZE3_CHAR93_WIDTH : (size == 4 ? SIZE4_CHAR93_WIDTH : SIZE5_CHAR93_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR93_HEIGHT : (size == 2 ? SIZE2_CHAR93_HEIGHT : (size == 3 ? SIZE3_CHAR93_HEIGHT : (size == 4 ? SIZE4_CHAR93_HEIGHT : SIZE5_CHAR93_HEIGHT))));
            end
            94: begin
               char_x = (size == 1 ? SIZE1_CHAR94_X : (size == 2 ? SIZE2_CHAR94_X : (size == 3 ? SIZE3_CHAR94_X : (size == 4 ? SIZE4_CHAR94_X : SIZE5_CHAR94_X))));
               char_y = (size == 1 ? SIZE1_CHAR94_Y : (size == 2 ? SIZE2_CHAR94_Y : (size == 3 ? SIZE3_CHAR94_Y : (size == 4 ? SIZE4_CHAR94_Y : SIZE5_CHAR94_Y))));
               char_width = (size == 1 ? SIZE1_CHAR94_WIDTH : (size == 2 ? SIZE2_CHAR94_WIDTH : (size == 3 ? SIZE3_CHAR94_WIDTH : (size == 4 ? SIZE4_CHAR94_WIDTH : SIZE5_CHAR94_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR94_HEIGHT : (size == 2 ? SIZE2_CHAR94_HEIGHT : (size == 3 ? SIZE3_CHAR94_HEIGHT : (size == 4 ? SIZE4_CHAR94_HEIGHT : SIZE5_CHAR94_HEIGHT))));
            end
            95: begin
               char_x = (size == 1 ? SIZE1_CHAR95_X : (size == 2 ? SIZE2_CHAR95_X : (size == 3 ? SIZE3_CHAR95_X : (size == 4 ? SIZE4_CHAR95_X : SIZE5_CHAR95_X))));
               char_y = (size == 1 ? SIZE1_CHAR95_Y : (size == 2 ? SIZE2_CHAR95_Y : (size == 3 ? SIZE3_CHAR95_Y : (size == 4 ? SIZE4_CHAR95_Y : SIZE5_CHAR95_Y))));
               char_width = (size == 1 ? SIZE1_CHAR95_WIDTH : (size == 2 ? SIZE2_CHAR95_WIDTH : (size == 3 ? SIZE3_CHAR95_WIDTH : (size == 4 ? SIZE4_CHAR95_WIDTH : SIZE5_CHAR95_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR95_HEIGHT : (size == 2 ? SIZE2_CHAR95_HEIGHT : (size == 3 ? SIZE3_CHAR95_HEIGHT : (size == 4 ? SIZE4_CHAR95_HEIGHT : SIZE5_CHAR95_HEIGHT))));
            end
            96: begin
               char_x = (size == 1 ? SIZE1_CHAR96_X : (size == 2 ? SIZE2_CHAR96_X : (size == 3 ? SIZE3_CHAR96_X : (size == 4 ? SIZE4_CHAR96_X : SIZE5_CHAR96_X))));
               char_y = (size == 1 ? SIZE1_CHAR96_Y : (size == 2 ? SIZE2_CHAR96_Y : (size == 3 ? SIZE3_CHAR96_Y : (size == 4 ? SIZE4_CHAR96_Y : SIZE5_CHAR96_Y))));
               char_width = (size == 1 ? SIZE1_CHAR96_WIDTH : (size == 2 ? SIZE2_CHAR96_WIDTH : (size == 3 ? SIZE3_CHAR96_WIDTH : (size == 4 ? SIZE4_CHAR96_WIDTH : SIZE5_CHAR96_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR96_HEIGHT : (size == 2 ? SIZE2_CHAR96_HEIGHT : (size == 3 ? SIZE3_CHAR96_HEIGHT : (size == 4 ? SIZE4_CHAR96_HEIGHT : SIZE5_CHAR96_HEIGHT))));
            end
            97: begin
               char_x = (size == 1 ? SIZE1_CHAR97_X : (size == 2 ? SIZE2_CHAR97_X : (size == 3 ? SIZE3_CHAR97_X : (size == 4 ? SIZE4_CHAR97_X : SIZE5_CHAR97_X))));
               char_y = (size == 1 ? SIZE1_CHAR97_Y : (size == 2 ? SIZE2_CHAR97_Y : (size == 3 ? SIZE3_CHAR97_Y : (size == 4 ? SIZE4_CHAR97_Y : SIZE5_CHAR97_Y))));
               char_width = (size == 1 ? SIZE1_CHAR97_WIDTH : (size == 2 ? SIZE2_CHAR97_WIDTH : (size == 3 ? SIZE3_CHAR97_WIDTH : (size == 4 ? SIZE4_CHAR97_WIDTH : SIZE5_CHAR97_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR97_HEIGHT : (size == 2 ? SIZE2_CHAR97_HEIGHT : (size == 3 ? SIZE3_CHAR97_HEIGHT : (size == 4 ? SIZE4_CHAR97_HEIGHT : SIZE5_CHAR97_HEIGHT))));
            end
            98: begin
               char_x = (size == 1 ? SIZE1_CHAR98_X : (size == 2 ? SIZE2_CHAR98_X : (size == 3 ? SIZE3_CHAR98_X : (size == 4 ? SIZE4_CHAR98_X : SIZE5_CHAR98_X))));
               char_y = (size == 1 ? SIZE1_CHAR98_Y : (size == 2 ? SIZE2_CHAR98_Y : (size == 3 ? SIZE3_CHAR98_Y : (size == 4 ? SIZE4_CHAR98_Y : SIZE5_CHAR98_Y))));
               char_width = (size == 1 ? SIZE1_CHAR98_WIDTH : (size == 2 ? SIZE2_CHAR98_WIDTH : (size == 3 ? SIZE3_CHAR98_WIDTH : (size == 4 ? SIZE4_CHAR98_WIDTH : SIZE5_CHAR98_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR98_HEIGHT : (size == 2 ? SIZE2_CHAR98_HEIGHT : (size == 3 ? SIZE3_CHAR98_HEIGHT : (size == 4 ? SIZE4_CHAR98_HEIGHT : SIZE5_CHAR98_HEIGHT))));
            end
            99: begin
               char_x = (size == 1 ? SIZE1_CHAR99_X : (size == 2 ? SIZE2_CHAR99_X : (size == 3 ? SIZE3_CHAR99_X : (size == 4 ? SIZE4_CHAR99_X : SIZE5_CHAR99_X))));
               char_y = (size == 1 ? SIZE1_CHAR99_Y : (size == 2 ? SIZE2_CHAR99_Y : (size == 3 ? SIZE3_CHAR99_Y : (size == 4 ? SIZE4_CHAR99_Y : SIZE5_CHAR99_Y))));
               char_width = (size == 1 ? SIZE1_CHAR99_WIDTH : (size == 2 ? SIZE2_CHAR99_WIDTH : (size == 3 ? SIZE3_CHAR99_WIDTH : (size == 4 ? SIZE4_CHAR99_WIDTH : SIZE5_CHAR99_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR99_HEIGHT : (size == 2 ? SIZE2_CHAR99_HEIGHT : (size == 3 ? SIZE3_CHAR99_HEIGHT : (size == 4 ? SIZE4_CHAR99_HEIGHT : SIZE5_CHAR99_HEIGHT))));
            end
            100: begin
               char_x = (size == 1 ? SIZE1_CHAR100_X : (size == 2 ? SIZE2_CHAR100_X : (size == 3 ? SIZE3_CHAR100_X : (size == 4 ? SIZE4_CHAR100_X : SIZE5_CHAR100_X))));
               char_y = (size == 1 ? SIZE1_CHAR100_Y : (size == 2 ? SIZE2_CHAR100_Y : (size == 3 ? SIZE3_CHAR100_Y : (size == 4 ? SIZE4_CHAR100_Y : SIZE5_CHAR100_Y))));
               char_width = (size == 1 ? SIZE1_CHAR100_WIDTH : (size == 2 ? SIZE2_CHAR100_WIDTH : (size == 3 ? SIZE3_CHAR100_WIDTH : (size == 4 ? SIZE4_CHAR100_WIDTH : SIZE5_CHAR100_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR100_HEIGHT : (size == 2 ? SIZE2_CHAR100_HEIGHT : (size == 3 ? SIZE3_CHAR100_HEIGHT : (size == 4 ? SIZE4_CHAR100_HEIGHT : SIZE5_CHAR100_HEIGHT))));
            end
            101: begin
               char_x = (size == 1 ? SIZE1_CHAR101_X : (size == 2 ? SIZE2_CHAR101_X : (size == 3 ? SIZE3_CHAR101_X : (size == 4 ? SIZE4_CHAR101_X : SIZE5_CHAR101_X))));
               char_y = (size == 1 ? SIZE1_CHAR101_Y : (size == 2 ? SIZE2_CHAR101_Y : (size == 3 ? SIZE3_CHAR101_Y : (size == 4 ? SIZE4_CHAR101_Y : SIZE5_CHAR101_Y))));
               char_width = (size == 1 ? SIZE1_CHAR101_WIDTH : (size == 2 ? SIZE2_CHAR101_WIDTH : (size == 3 ? SIZE3_CHAR101_WIDTH : (size == 4 ? SIZE4_CHAR101_WIDTH : SIZE5_CHAR101_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR101_HEIGHT : (size == 2 ? SIZE2_CHAR101_HEIGHT : (size == 3 ? SIZE3_CHAR101_HEIGHT : (size == 4 ? SIZE4_CHAR101_HEIGHT : SIZE5_CHAR101_HEIGHT))));
            end
            102: begin
               char_x = (size == 1 ? SIZE1_CHAR102_X : (size == 2 ? SIZE2_CHAR102_X : (size == 3 ? SIZE3_CHAR102_X : (size == 4 ? SIZE4_CHAR102_X : SIZE5_CHAR102_X))));
               char_y = (size == 1 ? SIZE1_CHAR102_Y : (size == 2 ? SIZE2_CHAR102_Y : (size == 3 ? SIZE3_CHAR102_Y : (size == 4 ? SIZE4_CHAR102_Y : SIZE5_CHAR102_Y))));
               char_width = (size == 1 ? SIZE1_CHAR102_WIDTH : (size == 2 ? SIZE2_CHAR102_WIDTH : (size == 3 ? SIZE3_CHAR102_WIDTH : (size == 4 ? SIZE4_CHAR102_WIDTH : SIZE5_CHAR102_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR102_HEIGHT : (size == 2 ? SIZE2_CHAR102_HEIGHT : (size == 3 ? SIZE3_CHAR102_HEIGHT : (size == 4 ? SIZE4_CHAR102_HEIGHT : SIZE5_CHAR102_HEIGHT))));
            end
            103: begin
               char_x = (size == 1 ? SIZE1_CHAR103_X : (size == 2 ? SIZE2_CHAR103_X : (size == 3 ? SIZE3_CHAR103_X : (size == 4 ? SIZE4_CHAR103_X : SIZE5_CHAR103_X))));
               char_y = (size == 1 ? SIZE1_CHAR103_Y : (size == 2 ? SIZE2_CHAR103_Y : (size == 3 ? SIZE3_CHAR103_Y : (size == 4 ? SIZE4_CHAR103_Y : SIZE5_CHAR103_Y))));
               char_width = (size == 1 ? SIZE1_CHAR103_WIDTH : (size == 2 ? SIZE2_CHAR103_WIDTH : (size == 3 ? SIZE3_CHAR103_WIDTH : (size == 4 ? SIZE4_CHAR103_WIDTH : SIZE5_CHAR103_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR103_HEIGHT : (size == 2 ? SIZE2_CHAR103_HEIGHT : (size == 3 ? SIZE3_CHAR103_HEIGHT : (size == 4 ? SIZE4_CHAR103_HEIGHT : SIZE5_CHAR103_HEIGHT))));
            end
            104: begin
               char_x = (size == 1 ? SIZE1_CHAR104_X : (size == 2 ? SIZE2_CHAR104_X : (size == 3 ? SIZE3_CHAR104_X : (size == 4 ? SIZE4_CHAR104_X : SIZE5_CHAR104_X))));
               char_y = (size == 1 ? SIZE1_CHAR104_Y : (size == 2 ? SIZE2_CHAR104_Y : (size == 3 ? SIZE3_CHAR104_Y : (size == 4 ? SIZE4_CHAR104_Y : SIZE5_CHAR104_Y))));
               char_width = (size == 1 ? SIZE1_CHAR104_WIDTH : (size == 2 ? SIZE2_CHAR104_WIDTH : (size == 3 ? SIZE3_CHAR104_WIDTH : (size == 4 ? SIZE4_CHAR104_WIDTH : SIZE5_CHAR104_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR104_HEIGHT : (size == 2 ? SIZE2_CHAR104_HEIGHT : (size == 3 ? SIZE3_CHAR104_HEIGHT : (size == 4 ? SIZE4_CHAR104_HEIGHT : SIZE5_CHAR104_HEIGHT))));
            end
            105: begin
               char_x = (size == 1 ? SIZE1_CHAR105_X : (size == 2 ? SIZE2_CHAR105_X : (size == 3 ? SIZE3_CHAR105_X : (size == 4 ? SIZE4_CHAR105_X : SIZE5_CHAR105_X))));
               char_y = (size == 1 ? SIZE1_CHAR105_Y : (size == 2 ? SIZE2_CHAR105_Y : (size == 3 ? SIZE3_CHAR105_Y : (size == 4 ? SIZE4_CHAR105_Y : SIZE5_CHAR105_Y))));
               char_width = (size == 1 ? SIZE1_CHAR105_WIDTH : (size == 2 ? SIZE2_CHAR105_WIDTH : (size == 3 ? SIZE3_CHAR105_WIDTH : (size == 4 ? SIZE4_CHAR105_WIDTH : SIZE5_CHAR105_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR105_HEIGHT : (size == 2 ? SIZE2_CHAR105_HEIGHT : (size == 3 ? SIZE3_CHAR105_HEIGHT : (size == 4 ? SIZE4_CHAR105_HEIGHT : SIZE5_CHAR105_HEIGHT))));
            end
            106: begin
               char_x = (size == 1 ? SIZE1_CHAR106_X : (size == 2 ? SIZE2_CHAR106_X : (size == 3 ? SIZE3_CHAR106_X : (size == 4 ? SIZE4_CHAR106_X : SIZE5_CHAR106_X))));
               char_y = (size == 1 ? SIZE1_CHAR106_Y : (size == 2 ? SIZE2_CHAR106_Y : (size == 3 ? SIZE3_CHAR106_Y : (size == 4 ? SIZE4_CHAR106_Y : SIZE5_CHAR106_Y))));
               char_width = (size == 1 ? SIZE1_CHAR106_WIDTH : (size == 2 ? SIZE2_CHAR106_WIDTH : (size == 3 ? SIZE3_CHAR106_WIDTH : (size == 4 ? SIZE4_CHAR106_WIDTH : SIZE5_CHAR106_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR106_HEIGHT : (size == 2 ? SIZE2_CHAR106_HEIGHT : (size == 3 ? SIZE3_CHAR106_HEIGHT : (size == 4 ? SIZE4_CHAR106_HEIGHT : SIZE5_CHAR106_HEIGHT))));
            end
            107: begin
               char_x = (size == 1 ? SIZE1_CHAR107_X : (size == 2 ? SIZE2_CHAR107_X : (size == 3 ? SIZE3_CHAR107_X : (size == 4 ? SIZE4_CHAR107_X : SIZE5_CHAR107_X))));
               char_y = (size == 1 ? SIZE1_CHAR107_Y : (size == 2 ? SIZE2_CHAR107_Y : (size == 3 ? SIZE3_CHAR107_Y : (size == 4 ? SIZE4_CHAR107_Y : SIZE5_CHAR107_Y))));
               char_width = (size == 1 ? SIZE1_CHAR107_WIDTH : (size == 2 ? SIZE2_CHAR107_WIDTH : (size == 3 ? SIZE3_CHAR107_WIDTH : (size == 4 ? SIZE4_CHAR107_WIDTH : SIZE5_CHAR107_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR107_HEIGHT : (size == 2 ? SIZE2_CHAR107_HEIGHT : (size == 3 ? SIZE3_CHAR107_HEIGHT : (size == 4 ? SIZE4_CHAR107_HEIGHT : SIZE5_CHAR107_HEIGHT))));
            end
            108: begin
               char_x = (size == 1 ? SIZE1_CHAR108_X : (size == 2 ? SIZE2_CHAR108_X : (size == 3 ? SIZE3_CHAR108_X : (size == 4 ? SIZE4_CHAR108_X : SIZE5_CHAR108_X))));
               char_y = (size == 1 ? SIZE1_CHAR108_Y : (size == 2 ? SIZE2_CHAR108_Y : (size == 3 ? SIZE3_CHAR108_Y : (size == 4 ? SIZE4_CHAR108_Y : SIZE5_CHAR108_Y))));
               char_width = (size == 1 ? SIZE1_CHAR108_WIDTH : (size == 2 ? SIZE2_CHAR108_WIDTH : (size == 3 ? SIZE3_CHAR108_WIDTH : (size == 4 ? SIZE4_CHAR108_WIDTH : SIZE5_CHAR108_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR108_HEIGHT : (size == 2 ? SIZE2_CHAR108_HEIGHT : (size == 3 ? SIZE3_CHAR108_HEIGHT : (size == 4 ? SIZE4_CHAR108_HEIGHT : SIZE5_CHAR108_HEIGHT))));
            end
            109: begin
               char_x = (size == 1 ? SIZE1_CHAR109_X : (size == 2 ? SIZE2_CHAR109_X : (size == 3 ? SIZE3_CHAR109_X : (size == 4 ? SIZE4_CHAR109_X : SIZE5_CHAR109_X))));
               char_y = (size == 1 ? SIZE1_CHAR109_Y : (size == 2 ? SIZE2_CHAR109_Y : (size == 3 ? SIZE3_CHAR109_Y : (size == 4 ? SIZE4_CHAR109_Y : SIZE5_CHAR109_Y))));
               char_width = (size == 1 ? SIZE1_CHAR109_WIDTH : (size == 2 ? SIZE2_CHAR109_WIDTH : (size == 3 ? SIZE3_CHAR109_WIDTH : (size == 4 ? SIZE4_CHAR109_WIDTH : SIZE5_CHAR109_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR109_HEIGHT : (size == 2 ? SIZE2_CHAR109_HEIGHT : (size == 3 ? SIZE3_CHAR109_HEIGHT : (size == 4 ? SIZE4_CHAR109_HEIGHT : SIZE5_CHAR109_HEIGHT))));
            end
            110: begin
               char_x = (size == 1 ? SIZE1_CHAR110_X : (size == 2 ? SIZE2_CHAR110_X : (size == 3 ? SIZE3_CHAR110_X : (size == 4 ? SIZE4_CHAR110_X : SIZE5_CHAR110_X))));
               char_y = (size == 1 ? SIZE1_CHAR110_Y : (size == 2 ? SIZE2_CHAR110_Y : (size == 3 ? SIZE3_CHAR110_Y : (size == 4 ? SIZE4_CHAR110_Y : SIZE5_CHAR110_Y))));
               char_width = (size == 1 ? SIZE1_CHAR110_WIDTH : (size == 2 ? SIZE2_CHAR110_WIDTH : (size == 3 ? SIZE3_CHAR110_WIDTH : (size == 4 ? SIZE4_CHAR110_WIDTH : SIZE5_CHAR110_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR110_HEIGHT : (size == 2 ? SIZE2_CHAR110_HEIGHT : (size == 3 ? SIZE3_CHAR110_HEIGHT : (size == 4 ? SIZE4_CHAR110_HEIGHT : SIZE5_CHAR110_HEIGHT))));
            end
            111: begin
               char_x = (size == 1 ? SIZE1_CHAR111_X : (size == 2 ? SIZE2_CHAR111_X : (size == 3 ? SIZE3_CHAR111_X : (size == 4 ? SIZE4_CHAR111_X : SIZE5_CHAR111_X))));
               char_y = (size == 1 ? SIZE1_CHAR111_Y : (size == 2 ? SIZE2_CHAR111_Y : (size == 3 ? SIZE3_CHAR111_Y : (size == 4 ? SIZE4_CHAR111_Y : SIZE5_CHAR111_Y))));
               char_width = (size == 1 ? SIZE1_CHAR111_WIDTH : (size == 2 ? SIZE2_CHAR111_WIDTH : (size == 3 ? SIZE3_CHAR111_WIDTH : (size == 4 ? SIZE4_CHAR111_WIDTH : SIZE5_CHAR111_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR111_HEIGHT : (size == 2 ? SIZE2_CHAR111_HEIGHT : (size == 3 ? SIZE3_CHAR111_HEIGHT : (size == 4 ? SIZE4_CHAR111_HEIGHT : SIZE5_CHAR111_HEIGHT))));
            end
            112: begin
               char_x = (size == 1 ? SIZE1_CHAR112_X : (size == 2 ? SIZE2_CHAR112_X : (size == 3 ? SIZE3_CHAR112_X : (size == 4 ? SIZE4_CHAR112_X : SIZE5_CHAR112_X))));
               char_y = (size == 1 ? SIZE1_CHAR112_Y : (size == 2 ? SIZE2_CHAR112_Y : (size == 3 ? SIZE3_CHAR112_Y : (size == 4 ? SIZE4_CHAR112_Y : SIZE5_CHAR112_Y))));
               char_width = (size == 1 ? SIZE1_CHAR112_WIDTH : (size == 2 ? SIZE2_CHAR112_WIDTH : (size == 3 ? SIZE3_CHAR112_WIDTH : (size == 4 ? SIZE4_CHAR112_WIDTH : SIZE5_CHAR112_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR112_HEIGHT : (size == 2 ? SIZE2_CHAR112_HEIGHT : (size == 3 ? SIZE3_CHAR112_HEIGHT : (size == 4 ? SIZE4_CHAR112_HEIGHT : SIZE5_CHAR112_HEIGHT))));
            end
            113: begin
               char_x = (size == 1 ? SIZE1_CHAR113_X : (size == 2 ? SIZE2_CHAR113_X : (size == 3 ? SIZE3_CHAR113_X : (size == 4 ? SIZE4_CHAR113_X : SIZE5_CHAR113_X))));
               char_y = (size == 1 ? SIZE1_CHAR113_Y : (size == 2 ? SIZE2_CHAR113_Y : (size == 3 ? SIZE3_CHAR113_Y : (size == 4 ? SIZE4_CHAR113_Y : SIZE5_CHAR113_Y))));
               char_width = (size == 1 ? SIZE1_CHAR113_WIDTH : (size == 2 ? SIZE2_CHAR113_WIDTH : (size == 3 ? SIZE3_CHAR113_WIDTH : (size == 4 ? SIZE4_CHAR113_WIDTH : SIZE5_CHAR113_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR113_HEIGHT : (size == 2 ? SIZE2_CHAR113_HEIGHT : (size == 3 ? SIZE3_CHAR113_HEIGHT : (size == 4 ? SIZE4_CHAR113_HEIGHT : SIZE5_CHAR113_HEIGHT))));
            end
            114: begin
               char_x = (size == 1 ? SIZE1_CHAR114_X : (size == 2 ? SIZE2_CHAR114_X : (size == 3 ? SIZE3_CHAR114_X : (size == 4 ? SIZE4_CHAR114_X : SIZE5_CHAR114_X))));
               char_y = (size == 1 ? SIZE1_CHAR114_Y : (size == 2 ? SIZE2_CHAR114_Y : (size == 3 ? SIZE3_CHAR114_Y : (size == 4 ? SIZE4_CHAR114_Y : SIZE5_CHAR114_Y))));
               char_width = (size == 1 ? SIZE1_CHAR114_WIDTH : (size == 2 ? SIZE2_CHAR114_WIDTH : (size == 3 ? SIZE3_CHAR114_WIDTH : (size == 4 ? SIZE4_CHAR114_WIDTH : SIZE5_CHAR114_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR114_HEIGHT : (size == 2 ? SIZE2_CHAR114_HEIGHT : (size == 3 ? SIZE3_CHAR114_HEIGHT : (size == 4 ? SIZE4_CHAR114_HEIGHT : SIZE5_CHAR114_HEIGHT))));
            end
            115: begin
               char_x = (size == 1 ? SIZE1_CHAR115_X : (size == 2 ? SIZE2_CHAR115_X : (size == 3 ? SIZE3_CHAR115_X : (size == 4 ? SIZE4_CHAR115_X : SIZE5_CHAR115_X))));
               char_y = (size == 1 ? SIZE1_CHAR115_Y : (size == 2 ? SIZE2_CHAR115_Y : (size == 3 ? SIZE3_CHAR115_Y : (size == 4 ? SIZE4_CHAR115_Y : SIZE5_CHAR115_Y))));
               char_width = (size == 1 ? SIZE1_CHAR115_WIDTH : (size == 2 ? SIZE2_CHAR115_WIDTH : (size == 3 ? SIZE3_CHAR115_WIDTH : (size == 4 ? SIZE4_CHAR115_WIDTH : SIZE5_CHAR115_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR115_HEIGHT : (size == 2 ? SIZE2_CHAR115_HEIGHT : (size == 3 ? SIZE3_CHAR115_HEIGHT : (size == 4 ? SIZE4_CHAR115_HEIGHT : SIZE5_CHAR115_HEIGHT))));
            end
            116: begin
               char_x = (size == 1 ? SIZE1_CHAR116_X : (size == 2 ? SIZE2_CHAR116_X : (size == 3 ? SIZE3_CHAR116_X : (size == 4 ? SIZE4_CHAR116_X : SIZE5_CHAR116_X))));
               char_y = (size == 1 ? SIZE1_CHAR116_Y : (size == 2 ? SIZE2_CHAR116_Y : (size == 3 ? SIZE3_CHAR116_Y : (size == 4 ? SIZE4_CHAR116_Y : SIZE5_CHAR116_Y))));
               char_width = (size == 1 ? SIZE1_CHAR116_WIDTH : (size == 2 ? SIZE2_CHAR116_WIDTH : (size == 3 ? SIZE3_CHAR116_WIDTH : (size == 4 ? SIZE4_CHAR116_WIDTH : SIZE5_CHAR116_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR116_HEIGHT : (size == 2 ? SIZE2_CHAR116_HEIGHT : (size == 3 ? SIZE3_CHAR116_HEIGHT : (size == 4 ? SIZE4_CHAR116_HEIGHT : SIZE5_CHAR116_HEIGHT))));
            end
            117: begin
               char_x = (size == 1 ? SIZE1_CHAR117_X : (size == 2 ? SIZE2_CHAR117_X : (size == 3 ? SIZE3_CHAR117_X : (size == 4 ? SIZE4_CHAR117_X : SIZE5_CHAR117_X))));
               char_y = (size == 1 ? SIZE1_CHAR117_Y : (size == 2 ? SIZE2_CHAR117_Y : (size == 3 ? SIZE3_CHAR117_Y : (size == 4 ? SIZE4_CHAR117_Y : SIZE5_CHAR117_Y))));
               char_width = (size == 1 ? SIZE1_CHAR117_WIDTH : (size == 2 ? SIZE2_CHAR117_WIDTH : (size == 3 ? SIZE3_CHAR117_WIDTH : (size == 4 ? SIZE4_CHAR117_WIDTH : SIZE5_CHAR117_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR117_HEIGHT : (size == 2 ? SIZE2_CHAR117_HEIGHT : (size == 3 ? SIZE3_CHAR117_HEIGHT : (size == 4 ? SIZE4_CHAR117_HEIGHT : SIZE5_CHAR117_HEIGHT))));
            end
            118: begin
               char_x = (size == 1 ? SIZE1_CHAR118_X : (size == 2 ? SIZE2_CHAR118_X : (size == 3 ? SIZE3_CHAR118_X : (size == 4 ? SIZE4_CHAR118_X : SIZE5_CHAR118_X))));
               char_y = (size == 1 ? SIZE1_CHAR118_Y : (size == 2 ? SIZE2_CHAR118_Y : (size == 3 ? SIZE3_CHAR118_Y : (size == 4 ? SIZE4_CHAR118_Y : SIZE5_CHAR118_Y))));
               char_width = (size == 1 ? SIZE1_CHAR118_WIDTH : (size == 2 ? SIZE2_CHAR118_WIDTH : (size == 3 ? SIZE3_CHAR118_WIDTH : (size == 4 ? SIZE4_CHAR118_WIDTH : SIZE5_CHAR118_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR118_HEIGHT : (size == 2 ? SIZE2_CHAR118_HEIGHT : (size == 3 ? SIZE3_CHAR118_HEIGHT : (size == 4 ? SIZE4_CHAR118_HEIGHT : SIZE5_CHAR118_HEIGHT))));
            end
            119: begin
               char_x = (size == 1 ? SIZE1_CHAR119_X : (size == 2 ? SIZE2_CHAR119_X : (size == 3 ? SIZE3_CHAR119_X : (size == 4 ? SIZE4_CHAR119_X : SIZE5_CHAR119_X))));
               char_y = (size == 1 ? SIZE1_CHAR119_Y : (size == 2 ? SIZE2_CHAR119_Y : (size == 3 ? SIZE3_CHAR119_Y : (size == 4 ? SIZE4_CHAR119_Y : SIZE5_CHAR119_Y))));
               char_width = (size == 1 ? SIZE1_CHAR119_WIDTH : (size == 2 ? SIZE2_CHAR119_WIDTH : (size == 3 ? SIZE3_CHAR119_WIDTH : (size == 4 ? SIZE4_CHAR119_WIDTH : SIZE5_CHAR119_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR119_HEIGHT : (size == 2 ? SIZE2_CHAR119_HEIGHT : (size == 3 ? SIZE3_CHAR119_HEIGHT : (size == 4 ? SIZE4_CHAR119_HEIGHT : SIZE5_CHAR119_HEIGHT))));
            end
            120: begin
               char_x = (size == 1 ? SIZE1_CHAR120_X : (size == 2 ? SIZE2_CHAR120_X : (size == 3 ? SIZE3_CHAR120_X : (size == 4 ? SIZE4_CHAR120_X : SIZE5_CHAR120_X))));
               char_y = (size == 1 ? SIZE1_CHAR120_Y : (size == 2 ? SIZE2_CHAR120_Y : (size == 3 ? SIZE3_CHAR120_Y : (size == 4 ? SIZE4_CHAR120_Y : SIZE5_CHAR120_Y))));
               char_width = (size == 1 ? SIZE1_CHAR120_WIDTH : (size == 2 ? SIZE2_CHAR120_WIDTH : (size == 3 ? SIZE3_CHAR120_WIDTH : (size == 4 ? SIZE4_CHAR120_WIDTH : SIZE5_CHAR120_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR120_HEIGHT : (size == 2 ? SIZE2_CHAR120_HEIGHT : (size == 3 ? SIZE3_CHAR120_HEIGHT : (size == 4 ? SIZE4_CHAR120_HEIGHT : SIZE5_CHAR120_HEIGHT))));
            end
            121: begin
               char_x = (size == 1 ? SIZE1_CHAR121_X : (size == 2 ? SIZE2_CHAR121_X : (size == 3 ? SIZE3_CHAR121_X : (size == 4 ? SIZE4_CHAR121_X : SIZE5_CHAR121_X))));
               char_y = (size == 1 ? SIZE1_CHAR121_Y : (size == 2 ? SIZE2_CHAR121_Y : (size == 3 ? SIZE3_CHAR121_Y : (size == 4 ? SIZE4_CHAR121_Y : SIZE5_CHAR121_Y))));
               char_width = (size == 1 ? SIZE1_CHAR121_WIDTH : (size == 2 ? SIZE2_CHAR121_WIDTH : (size == 3 ? SIZE3_CHAR121_WIDTH : (size == 4 ? SIZE4_CHAR121_WIDTH : SIZE5_CHAR121_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR121_HEIGHT : (size == 2 ? SIZE2_CHAR121_HEIGHT : (size == 3 ? SIZE3_CHAR121_HEIGHT : (size == 4 ? SIZE4_CHAR121_HEIGHT : SIZE5_CHAR121_HEIGHT))));
            end
            122: begin
               char_x = (size == 1 ? SIZE1_CHAR122_X : (size == 2 ? SIZE2_CHAR122_X : (size == 3 ? SIZE3_CHAR122_X : (size == 4 ? SIZE4_CHAR122_X : SIZE5_CHAR122_X))));
               char_y = (size == 1 ? SIZE1_CHAR122_Y : (size == 2 ? SIZE2_CHAR122_Y : (size == 3 ? SIZE3_CHAR122_Y : (size == 4 ? SIZE4_CHAR122_Y : SIZE5_CHAR122_Y))));
               char_width = (size == 1 ? SIZE1_CHAR122_WIDTH : (size == 2 ? SIZE2_CHAR122_WIDTH : (size == 3 ? SIZE3_CHAR122_WIDTH : (size == 4 ? SIZE4_CHAR122_WIDTH : SIZE5_CHAR122_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR122_HEIGHT : (size == 2 ? SIZE2_CHAR122_HEIGHT : (size == 3 ? SIZE3_CHAR122_HEIGHT : (size == 4 ? SIZE4_CHAR122_HEIGHT : SIZE5_CHAR122_HEIGHT))));
            end
            123: begin
               char_x = (size == 1 ? SIZE1_CHAR123_X : (size == 2 ? SIZE2_CHAR123_X : (size == 3 ? SIZE3_CHAR123_X : (size == 4 ? SIZE4_CHAR123_X : SIZE5_CHAR123_X))));
               char_y = (size == 1 ? SIZE1_CHAR123_Y : (size == 2 ? SIZE2_CHAR123_Y : (size == 3 ? SIZE3_CHAR123_Y : (size == 4 ? SIZE4_CHAR123_Y : SIZE5_CHAR123_Y))));
               char_width = (size == 1 ? SIZE1_CHAR123_WIDTH : (size == 2 ? SIZE2_CHAR123_WIDTH : (size == 3 ? SIZE3_CHAR123_WIDTH : (size == 4 ? SIZE4_CHAR123_WIDTH : SIZE5_CHAR123_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR123_HEIGHT : (size == 2 ? SIZE2_CHAR123_HEIGHT : (size == 3 ? SIZE3_CHAR123_HEIGHT : (size == 4 ? SIZE4_CHAR123_HEIGHT : SIZE5_CHAR123_HEIGHT))));
            end
            124: begin
               char_x = (size == 1 ? SIZE1_CHAR124_X : (size == 2 ? SIZE2_CHAR124_X : (size == 3 ? SIZE3_CHAR124_X : (size == 4 ? SIZE4_CHAR124_X : SIZE5_CHAR124_X))));
               char_y = (size == 1 ? SIZE1_CHAR124_Y : (size == 2 ? SIZE2_CHAR124_Y : (size == 3 ? SIZE3_CHAR124_Y : (size == 4 ? SIZE4_CHAR124_Y : SIZE5_CHAR124_Y))));
               char_width = (size == 1 ? SIZE1_CHAR124_WIDTH : (size == 2 ? SIZE2_CHAR124_WIDTH : (size == 3 ? SIZE3_CHAR124_WIDTH : (size == 4 ? SIZE4_CHAR124_WIDTH : SIZE5_CHAR124_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR124_HEIGHT : (size == 2 ? SIZE2_CHAR124_HEIGHT : (size == 3 ? SIZE3_CHAR124_HEIGHT : (size == 4 ? SIZE4_CHAR124_HEIGHT : SIZE5_CHAR124_HEIGHT))));
            end
            125: begin
               char_x = (size == 1 ? SIZE1_CHAR125_X : (size == 2 ? SIZE2_CHAR125_X : (size == 3 ? SIZE3_CHAR125_X : (size == 4 ? SIZE4_CHAR125_X : SIZE5_CHAR125_X))));
               char_y = (size == 1 ? SIZE1_CHAR125_Y : (size == 2 ? SIZE2_CHAR125_Y : (size == 3 ? SIZE3_CHAR125_Y : (size == 4 ? SIZE4_CHAR125_Y : SIZE5_CHAR125_Y))));
               char_width = (size == 1 ? SIZE1_CHAR125_WIDTH : (size == 2 ? SIZE2_CHAR125_WIDTH : (size == 3 ? SIZE3_CHAR125_WIDTH : (size == 4 ? SIZE4_CHAR125_WIDTH : SIZE5_CHAR125_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR125_HEIGHT : (size == 2 ? SIZE2_CHAR125_HEIGHT : (size == 3 ? SIZE3_CHAR125_HEIGHT : (size == 4 ? SIZE4_CHAR125_HEIGHT : SIZE5_CHAR125_HEIGHT))));
            end
            126: begin
               char_x = (size == 1 ? SIZE1_CHAR126_X : (size == 2 ? SIZE2_CHAR126_X : (size == 3 ? SIZE3_CHAR126_X : (size == 4 ? SIZE4_CHAR126_X : SIZE5_CHAR126_X))));
               char_y = (size == 1 ? SIZE1_CHAR126_Y : (size == 2 ? SIZE2_CHAR126_Y : (size == 3 ? SIZE3_CHAR126_Y : (size == 4 ? SIZE4_CHAR126_Y : SIZE5_CHAR126_Y))));
               char_width = (size == 1 ? SIZE1_CHAR126_WIDTH : (size == 2 ? SIZE2_CHAR126_WIDTH : (size == 3 ? SIZE3_CHAR126_WIDTH : (size == 4 ? SIZE4_CHAR126_WIDTH : SIZE5_CHAR126_WIDTH))));
               char_height = (size == 1 ? SIZE1_CHAR126_HEIGHT : (size == 2 ? SIZE2_CHAR126_HEIGHT : (size == 3 ? SIZE3_CHAR126_HEIGHT : (size == 4 ? SIZE4_CHAR126_HEIGHT : SIZE5_CHAR126_HEIGHT))));
            end
        endcase
    end
    
    reg [31:0] offset_x, offset_y;
    reg [6:0] char_xpos = 32;   // x coord of top left of char
    reg [5:0] char_ypos = 28;   // y coord of top left of char
    assign debug[15:8] = char_xpos;
    assign debug[7:0] = char_ypos;
    // display current screen state
    // analysis is that this code block displays the 
    always @(posedge clk6p25m) begin
        // Check if the current screen position falls within the character
        if ((x >= char_xpos) && (x < char_xpos + char_width) && (y >= char_ypos) && (y < char_ypos + char_height)) begin
            // Calculate the relative position within the character's bitmap
            // Fetch the pixel color from the character's bitmap
            offset_x = char_xpos;      // equals the min val of x
            offset_y = char_ypos;      // equals the min val of y
            oled_data = bitmap_data(x, y);  
        end else begin
//            oled_data = 16'hFFFF;  // Display background if outside the character
            case (bg_colour)            // Display background if outside the character
                3'b000: oled_data = 16'hFFFF; // white
                3'b001: oled_data = 16'b11111_000000_00000; // red
                3'b010: oled_data = 16'b11111_101000_00000; // orange
                3'b011: oled_data = 16'b11111_111111_00000; // yellow
                3'b100: oled_data = 16'b00000_111111_00000; // green
                3'b101: oled_data = 16'b00000_000000_11111; // blue
                3'b110: oled_data = 16'b00100_000000_10010; // indigo
                3'b111: oled_data = 16'b11101_100000_11101; // violet
            endcase
        end
    end
    
    wire clock_10hz;
    variable_clock clk_10Hz(.basys_clock(basys_clock), .m(4999999), .slow_clock(clock_10hz));
    always @(posedge clock_10hz) begin
        if (enable) begin
            case (sw)
                4'b0000: begin
                    // shifting char by pixels using btns
                    if (btnU && (char_ypos > 1)) begin
                        char_ypos <= char_ypos - 2;
                    end else if (btnD && (char_ypos <= 62 - char_height)) begin
                        char_ypos <= char_ypos + 2;
                    end 
                
                    if (btnL && (char_xpos > 1)) begin
                        char_xpos <= char_xpos - 2;
                    end else if (btnR && (char_xpos <= 93 - char_width)) begin
                        char_xpos <= char_xpos + 2;
                    end
                end
                4'b0001: begin
                    // snapping char to the sides using btns
                    if (btnU && (char_ypos > 1)) begin
                        char_ypos <= 1;
                    end else if (btnD && (char_ypos <= 62 - char_height)) begin
                        char_ypos <= 62 - char_height;
                    end 
                
                    if (btnL && (char_xpos > 1)) begin
                        char_xpos <= 1;
                    end else if (btnR && (char_xpos <= 93 - char_width)) begin
                        char_xpos <= 93 - char_width;
                    end
                end
                4'b0010: begin
                    // increasing the size of the characters using btns
                    if ((btnU | btnR) && size < 3'b101) begin
                        size <= size + 1;
                    end else if ((btnD | btnL) && size > 3'b001) begin
                        size <= size - 1;
                    end
                end
                4'b0100: begin
                    // changing colour of the character using btns
                    if ((btnU | btnR) && char_colour < 3'b111) begin
                        char_colour <= char_colour + 1;
                    end else if ((btnD | btnL) && char_colour > 3'b000) begin
                        char_colour <= char_colour - 1;
                    end
                end
                4'b1000: begin
                    // changing colour of the background using btns
                    if ((btnU | btnR) && bg_colour < 3'b111) begin
                        bg_colour <= bg_colour + 1;
                    end else if ((btnD | btnL) && bg_colour > 3'b000) begin
                        bg_colour <= bg_colour - 1;
                    end
                end
            endcase
        end
    end
    
    // gets the value of the pixel based on the x and y coordinates
    wire pixel_val;
    process_bitmap map(.x(x + char_x - offset_x), .y(y + char_y - offset_y), .size(size), .pixel_value(pixel_val));
    
    // inputs: x and y pixel coordinates
    // returns: the colour, black or white, depending on whether the pixel is filled
    function [15:0] bitmap_data;
        input [6:0] x;      // x coordinate
        input [5:0] y;      // y coordinate
        
        begin
            if (~pixel_val) begin   // colour of the character
                case (char_colour)
                    3'b000: bitmap_data = 16'h0000; // black
                    3'b001: bitmap_data = 16'b11111_000000_00000; // red
                    3'b010: bitmap_data = 16'b11111_101000_00000; // orange
                    3'b011: bitmap_data = 16'b11111_111111_00000; // yellow
                    3'b100: bitmap_data = 16'b00000_111111_00000; // green
                    3'b101: bitmap_data = 16'b00000_000000_11111; // blue
                    3'b110: bitmap_data = 16'b00100_000000_10010; // indigo
                    3'b111: bitmap_data = 16'b11101_100000_11101; // violet
                endcase
            end else begin      // background colour
                case (bg_colour)
                    3'b000: bitmap_data = 16'hFFFF; // white
                    3'b001: bitmap_data = 16'b11111_000000_00000; // red
                    3'b010: bitmap_data = 16'b11111_101000_00000; // orange
                    3'b011: bitmap_data = 16'b11111_111111_00000; // yellow
                    3'b100: bitmap_data = 16'b00000_111111_00000; // green
                    3'b101: bitmap_data = 16'b00000_000000_11111; // blue
                    3'b110: bitmap_data = 16'b00100_000000_10010; // indigo
                    3'b111: bitmap_data = 16'b11101_100000_11101; // violet
                endcase
            end
        end
    endfunction

endmodule

