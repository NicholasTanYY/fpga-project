`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2023 16:05:56
// Design Name: 
// Module Name: Audio_Ball
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


module Audio_Ball(
    input enable, basys_clock,
    input [11:0] mic_in,
    input [12:0] pixel_index,
    output reg [15:0] oled_data
    );
    
    reg [12:0] counter;
    reg [5:0] rad, max_rad;
    reg [11:0] max_mic;
    reg [31:0] x, x1, y, y1;  
    reg [15:0] screen_colour, back_colour;
    wire clk_20khz;
    
    variable_clock clk20khz(.basys_clock(basys_clock), .m(2499), .slow_clock(clk_20khz));
    
    always @ (posedge clk_20khz) begin
        if (counter[8:0] == 0) begin
            rad = (max_mic - 2048) / 43;           
            if (counter == 0 && max_rad > 35) begin
                screen_colour <= 16'b1010_1010_1010_1010;
                back_colour <= 16'b1000_1000_1010_1010;
                max_rad = 0;
            end           
            if (rad > max_rad) begin
                max_rad <= rad;
            end        
            max_mic <= 0;
        end    
        if (mic_in > max_mic) begin
            max_mic <= mic_in;
        end
        if (counter[8:0] == 399) begin
            counter <= {counter[12:9] + 1, 9'b0};
        end else begin
            counter <= counter + 1;
        end

    end
    
    always @ (posedge basys_clock) begin
    if (enable == 1) begin
        oled_data = back_colour;
        x = pixel_index % 96;
        y = pixel_index / 96; 
        if (x < 48) 
            x1 <= 96 - x;
        else 
            x1 <= x;        
        if (y < 32)
             y1 <= 64 - y;
        else
             y1 <= y;      
        if ((x1 - 48)*(x1 - 48)+(y1 - 32)*(y1 - 32) < rad*rad) 
            oled_data = screen_colour;
    end
    end
    
endmodule
