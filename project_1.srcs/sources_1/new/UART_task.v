`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2023 23:49:52
// Design Name: 
// Module Name: UART_task
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
//
//////////////////////////////////////////////////////////////////////////////////


module powerpoint(
    input enable,
    input basys_clock,
    input btnC, btnU, btnD, btnL, btnR,
    input [3:0] sw,
    input PS2Clk,
    input PS2Data,
    input [12:0] pixel_index,
    input [7:0]easterIn,
    input [7:0] transmitted_data,
    output [15:0] led,
    output [3:0] an,
    output [6:0] seg,
    output dp,
    output [15:0] oled_data,
    output easter_egg_done
);
            
    wire [7:0] chars_sent;
    wire [3:0] size, char_colour, bg_colour;
    
    // External keyboard connection
//    keyboard_chat keyboard(.keyboard_clk(PS2Clk), .data(PS2Data), .led(chars_sent));
    
    // Oled connection
    oled_display_chat oled(.enable(enable), .easterIn(easterIn), .basys_clock(basys_clock),
                            .external_keyboard_input(transmitted_data), .sw(sw),
                            .btnU(btnU), .btnD(btnD), .btnL(btnL), .btnR(btnR), .debug(led[15:0]),
                            .size(size), .char_colour(char_colour), .bg_colour(bg_colour),
                            .pixel_index(pixel_index), .oled_data(oled_data), .easter_egg_done(easter_egg_done));
                            
    as_display display(.basys_clock(basys_clock), .sw(sw), .an(an), .seg(seg), .dp(dp),
                        .size(size), .char_colour(char_colour), .bg_colour(bg_colour));
    
endmodule
