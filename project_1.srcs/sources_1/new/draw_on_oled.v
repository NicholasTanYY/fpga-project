`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 22:01:02
// Design Name: 
// Module Name: draw_on_oled
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


module draw_on_oled(
    input enable,
    input basys_clock,
    input clk6p25m,
    input [12:0] pixel_index,
    input [7:0] external_keyboard_input,
    input btnU, btnD, btnL, btnR,
    input [3:0] sw,
    input [7:0]easterIn,
    output [15:0] oled_data,
    output [15:0] debug,
    output [3:0] size,
    output [3:0] char_colour,
    output [3:0] bg_colour,
    output reg easter_egg_done = 0
);  
    `include "alphabets.vh"
    reg [3:0] arrow_keys;
    reg [7:0] ascii_char;
    wire [3:0] easter;
    wire clock_10hz;
    variable_clock clk_10Hz(.basys_clock(basys_clock), .m(4999999), .slow_clock(clock_10hz));
    
//    assign easter = (easterIn == one) ? 1 :
//                (easterIn == two) ? 2 :
//                (easterIn == three) ? 3 :
//                (easterIn == four) ? 4 :
//                (easterIn == five) ? 5 :
//                (easterIn == six) ? 6 :
//                (easterIn == seven) ? 7 :
//                (easterIn == eight) ? 8 :
//                (easterIn == nine) ? 9 :
//                easter;
    
        
    always @ (posedge basys_clock) begin
        if (enable) begin //if nics task is going on
            // printable chars
            if (external_keyboard_input >= 32 && external_keyboard_input <= 126) begin
                ascii_char <= external_keyboard_input;
            end
            if (ascii_char == easterIn && ~easter_egg_done) begin
                easter_egg_done <= 1;
            end
        end
    end
//    wire [3:0] easter;

//    always @ (posedge clk6p25m) begin
//        if (ascii_char == easter && ~easter_egg_done) begin
//            easter_egg_done <= 1;
//        end
//    end
                    
    wire debounced_btnU, debounced_btnD, debounced_btnL, debounced_btnR;
    d_ff d1(.basys_clock(basys_clock), .btn(btnU), .debounced_btn(debounced_btnU));
    d_ff d2(.basys_clock(basys_clock), .btn(btnD), .debounced_btn(debounced_btnD));
    d_ff d3(.basys_clock(basys_clock), .btn(btnL), .debounced_btn(debounced_btnL));
    d_ff d4(.basys_clock(basys_clock), .btn(btnR), .debounced_btn(debounced_btnR));
    
    // draw character based on the ascii keyboard input
    draw_character(.enable(enable), .basys_clock(basys_clock), .clk6p25m(clk6p25m), .pixel_index(pixel_index), .character_id(ascii_char), .oled_data(oled_data), .debug(debug), .sw(sw),
                    .btnU(debounced_btnU), .btnD(debounced_btnD), .btnL(debounced_btnL), .btnR(debounced_btnR), .size(size), .char_colour(char_colour), .bg_colour(bg_colour));

endmodule

