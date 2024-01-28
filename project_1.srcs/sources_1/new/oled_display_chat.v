`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 16:48:30
// Design Name: 
// Module Name: oled_display_chat
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


module oled_display_chat (
    input enable,
    input basys_clock,
    input [7:0] external_keyboard_input, 
    input btnU, btnD, btnL, btnR,
    input [3:0] sw,
    input [12:0] pixel_index,
    input [7:0]easterIn,
    output [15:0] oled_data,
    output [15:0] debug,
    output [3:0] size,
    output [3:0] char_colour,
    output [3:0] bg_colour,
    output easter_egg_done
);

    wire clk6p25m, clk20Hz;        
    variable_clock clk_6p25MHz(.basys_clock(basys_clock), .m(7), .slow_clock(clk6p25m));
    variable_clock clk_20Hz(.basys_clock(basys_clock), .m(2499999), .slow_clock(clk20Hz));
                 
     // drawing on the oled
     draw_on_oled display(.enable(enable), .easterIn(easterIn), .basys_clock(basys_clock), .clk6p25m(clk6p25m), .pixel_index(pixel_index), .oled_data(oled_data), .debug(debug),
                            .external_keyboard_input(external_keyboard_input), .sw(sw),
                            .btnU(btnU), .btnD(btnD), .btnL(btnL), .btnR(btnR),
                            .size(size), .char_colour(char_colour), .bg_colour(bg_colour), .easter_egg_done(easter_egg_done));

endmodule
