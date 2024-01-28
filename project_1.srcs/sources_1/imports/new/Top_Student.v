`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module jonathan (
    input enable, basys_clock, J_MIC3_Pin3, sw,
    input [7:0] easter_egg,
    input [12:0] pixel_index,
    output [6:0] seg,
    output [3:0] an,
    output dp,
    output [15:0] led,
    output J_MIC3_Pin1, J_MIC3_Pin4, easter_egg_done,
    output [15:0] oled_data
//    output cs, sdin, sclk, d_cn, resn, vccen, pmoden
    );

    wire clk_20khz, clk_6p25mhz, res, fb, pixel_data;
    wire sample_pixel, frame_begin, sending_pixels, reset;
//    wire [12:0] pixel_index;
    wire [15:0] visualiser_oled_data, ball_oled_data;
    wire [11:0] mic_in;
    
    //Variable Clocks
    variable_clock clk20khz(.basys_clock(basys_clock), .m(2499), .slow_clock(clk_20khz));
    variable_clock clk6p25mhz(.basys_clock(basys_clock), .m(7), .slow_clock(clk_6p25mhz));
    
    //Oled instantiation
//    Oled_Display unit_oled_A (clk_6p25mhz, res, fb, sending_pixels,
//      sample_pixel, pixel_index, oled_data, cs, sdin, sclk, d_cn, resn, vccen,
//      pmoden);
              
    //PMODMIC3 instantiation 
    Audio_Capture audio0 (.CLK(basys_clock), .cs(clk_20khz), .MISO(J_MIC3_Pin3), .clk_samp(J_MIC3_Pin1), .sclk(J_MIC3_Pin4), .sample(mic_in));
    
    //Audio Visualiser
    Audio_Visualiser(enable, basys_clock, mic_in, pixel_index, visualiser_oled_data);
    
    //Audio Ball
    Audio_Ball (enable, basys_clock, mic_in, pixel_index, ball_oled_data);
    
    //Led Control
    Led_Control levels (enable, easter_egg, basys_clock, mic_in, seg, an, dp, led, easter_egg_done);
    
    assign oled_data = sw ? ball_oled_data : visualiser_oled_data;

endmodule