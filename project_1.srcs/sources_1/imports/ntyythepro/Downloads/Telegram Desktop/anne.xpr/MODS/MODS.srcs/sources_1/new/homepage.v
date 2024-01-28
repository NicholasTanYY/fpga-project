`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 19:06:44
// Design Name: 
// Module Name: homepage
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


module homepage(
    input enable, clk, mouse_l, btnC,
    input [11:0] mouse_x, mouse_y,
    input [6:0] x, [5:0] y,
    input state,  
    output reg [15:0] oled_data = 0
    );
    
    parameter WHITE = 16'hFFFF;
    parameter RED = 16'hF044;
    parameter ORANGE = 16'hFE20;
    parameter YELLOW = 16'hF7E0;
    parameter GREEN = 16'h2FE0;
    parameter BLUE = 16'hD5E;
    parameter PURPLE = 16'hF05E;
    parameter GREY = 16'hAD75;
    parameter BLACK = 0;
    parameter CURSOR_COLOUR = 16'h4C78;
    parameter CURSOR_SELECT = 16'hFA80;
    
    wire heading;
    wire banner1_heading;
    wire banner2_heading;
    wire banner1;
    wire banner2;
    
    wire M, O1, R1, S, E1, C, O2, D, E2, T1, U, T2, O3, R2, smiley;
    
    wire l, e, a1, r1, n1;
    wire t, r2, a2, i, n2;
    
    assign heading = M || O1 || R1 || S || E1 || C || O2 || D || E2 || T1 || U || T2 || O3 || R2 || smiley;
    assign banner1 = l || e || a1 || r1 || n1;
    assign banner2 = t || r2 || a2 || i || n2;
    
    wire heading_height;
    assign heading_height = y > 16 && y < 23;
    
    wire banner1_height;
    assign banner1_height = y > 31 && y < 38;
    
    wire banner2_height;
    assign banner2_height = y > 44 && y < 51;
    
    assign M = (x == 6 && heading_height) || (x == 10 && heading_height) || (x == 7 && y > 17 && y < 20) || (x == 9 && y > 17 && y < 20) || (x == 8 && y > 18 && y < 21);
    assign O1 = (x == 12 && heading_height) || (x == 15 && heading_height) || ((x == 13 || x == 14) && (y == 17 || y == 22));
    assign R1 = (x == 17 && heading_height) || ((x > 17 && x < 20) && (y == 17 || y == 20)) || (x == 20 && (y == 18 || y == 19) ) || ( x == 19 && y == 21) || (x == 20 && y == 22);
    assign S = (x == 22 && (y == 18 || y == 19 || y == 21)) || (x == 23 && (y == 17 || y == 19 || y == 22)) || (x == 24 && (y == 17 || y == 20 || y == 22)) || (x == 25 && (y == 18 || y == 20 || y == 21));
    assign E1 = (x == 27 && heading_height) || ((x == 28 || x == 29) && (y == 17 || y == 19 || y == 22));
    
    assign C = (x == 34 && (y > 17 && y < 22)) || ((x == 35 || x == 36) && (y == 17 || y == 22)) || (x == 37 && (y == 18 || y == 21));
    assign O2 = (x == 39 && heading_height) || (x == 42 && heading_height) || ((x == 40 || x == 41) && (y == 17 || y == 22));
    assign D = (x == 44 && heading_height) || ((y == 17 || y == 22) && ( x == 45 || x == 46)) || ((y == 18 || y == 21) && (x ==46 || x == 47)) || (x == 47 && (y == 19 || y == 20));
    assign E2 = (x == 49 && heading_height) || ((x == 50 || x == 51) && (y == 17 || y == 19 || y == 22));
    
    assign T1 = (x == 58 && heading_height) || (y == 17 && (x > 55 && x < 61));
    assign U = ((x == 62 || x == 65) && heading_height) || ((x == 63 || x == 64) && y == 22);
    assign T2 = (x == 69 && heading_height) || (y == 17 && (x > 66 && x < 72));
    assign O3 = (x == 73 && heading_height) || (x == 76 && heading_height) || ((x == 74 || x == 75) && (y == 17 || y == 22));
    assign R2 = (x == 78 && heading_height) || ((x > 78 && x < 81) && (y == 17 || y == 20)) || (x == 81 && (y == 18 || y == 19) ) || ( x == 80 && y == 21) || (x == 81 && y == 22);
    
    assign smiley = (x == 84 && (y == 18 || y == 21)) || (x == 86 && (y == 17 || y == 22)) || (x == 87 && (y == 18 || y == 21)) || (x == 88 && (y == 19 || y == 20));
    
    assign l = (x == 35 && banner1_height) || (y == 37 && (x > 34 && x < 39));
    assign e = (x == 41 && banner1_height) || ((x == 42 || x == 43) && (y == 32 || y == 34 || y == 37));
    assign a1 = ((x == 46 || x == 49) && (y > 32 && y < 38)) || ((x == 47 || x == 48) && (y == 32 || y == 35));
    assign r1 = (x == 52 && banner1_height) || ((x > 52 && x < 55) && (y == 32 || y == 35)) || (x == 55 && (y == 33 || y == 34) ) || ( x == 54 && y == 36) || (x == 55 && y == 37);
    assign n1 = ((x == 58 || x == 61) && banner1_height) || (x == 59 && ( y == 33 || y == 34)) || (x == 60 && (y == 34 || y == 35));
    
//    assign t = (x == 37 && banner2_height) || (y == 45 && (x > 34 && x < 40));
//    assign r2 = (x == 42 && banner2_height) || ((x > 42 && x < 45) && (y == 45 || y == 48)) || (x == 45 && (y == 46 || y == 47) ) || ( x == 44 && y == 49) || (x == 45 && y == 50);
//    assign a2 = ((x == 48 || x == 51) && (y > 45 && y < 51)) || ((x == 49 || x == 50) && (y == 45 || y == 48));
//    assign i = (x == 54 && banner2_height);
//    assign n2 = ((x == 57 || x == 60) && banner2_height) || (x == 58 && ( y == 46 || y == 47)) || (x == 59 && (y == 47 || y == 48));
    
    wire CLK_10Hz;
    variable_clock clk_5Hz(clk, 4999999, CLK_10Hz);
    
    reg [15:0]banner_colour = WHITE;
    reg [2:0]colour_chooser = 0;
    
    always @ (posedge CLK_10Hz) begin
    if (enable == 1) begin
        if (btnC == 1) colour_chooser <= colour_chooser + 1;
        case (colour_chooser)
            0: begin
                banner_colour <= WHITE;
            end
            1: begin
                banner_colour <= RED;
            end
            2: begin
                banner_colour <= ORANGE;
            end
            3: begin
                banner_colour <= YELLOW;
            end
            4: begin
                banner_colour <= GREEN;
            end
            5: begin
                banner_colour <= BLUE;
            end
            6: begin
                banner_colour <= PURPLE;
            end
            7: begin
                banner_colour <= GREY;
            end
            default: begin
                banner_colour <= WHITE;
            end
        endcase
    end
    end
    
    wire cursor_selection;
    assign cursor_selection = (x > 30 && x < 65) && (y > 29 && y < 40);
    
    // Create a 3 x 3 cursor
    wire within_cursor; wire [15:0] cursor_color;
    assign within_cursor = ((x == mouse_x) || ((x - mouse_x) == 1) || ((mouse_x - x) == 1)) 
                            && ((y == mouse_y) || ((y - mouse_y) == 1) || ((mouse_y - y) == 1));
    assign cursor_color = ((x == mouse_x) || ((x - mouse_x) == 1) || ((mouse_x - x) == 1)) && ((y == mouse_y) || ((y - mouse_y) == 1) || ((mouse_y - y) == 1)) ? (cursor_selection == 1) ? CURSOR_SELECT : CURSOR_COLOUR : 0; 
    
    always @ (x, y) begin
    if (enable == 1) begin
        if (state == 0) begin
            if (within_cursor && cursor_color != 16'b1111_11111_1111) 
                oled_data <= cursor_color;
            else if (heading) oled_data <= WHITE;
            else if (banner1 /*|| banner2*/) oled_data <= BLACK;
            else if ( (x > 30 && x < 65) && ((y > 29 && y < 40)/* || (y > 42 && y < 53)*/) ) oled_data <= banner_colour;
            else oled_data <= BLACK;
        end    
    end
    end

//    always @ (x, y) begin
//        if (state == 0) begin
//            if (heading) oled_data <= WHITE;
//            else if (banner1 || banner2) oled_data <= BLACK;
//            else if ( (x > 30 && x < 65) && ((y > 29 && y < 40) || (y > 42 && y < 53)) ) oled_data <= WHITE;
//            else oled_data <= BLACK;
//        end    
//    end

endmodule
