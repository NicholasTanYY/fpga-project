`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2023 14:25:36
// Design Name: 
// Module Name: learn_p1
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


module learn_p1(
    input clk, clk_1000Hz, mouse_l, mouse_r, btnC, btnL, btnR, btnU, btnD,
    input [11:0] mouse_x, mouse_y,
    input [6:0] x, [5:0] y,
    input [12:0] pixel_index,
    input state,  
    input [7:0] easter_egg,
    output reg easter_egg_done = 0,
    output reg [15:0] oled_data = 0,
    output [3:0]an, [7:0]seg, [5:0]led);
    
    //initialise alphabet for display, 0 for null state
    reg [5:0]learn_state = 0;
    
    //initialise register to determine which page to display, 0 for page 1 and 1 for page 2
    reg learn_page = 0; 
    
    parameter CURSOR_COLOUR = 16'h4C78;
    parameter CURSOR_SELECT = 16'hFA80;
    
    wire A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z;
    wire back, nextpage;
    
    wire [3:0] an_A, an_B, an_C, an_D, an_E, an_F, an_G, an_H, an_I, an_J, an_K, an_L, an_M, an_N; 

    wire [7:0] seg_A, seg_B, seg_C, seg_D, seg_E, seg_F, seg_G, seg_H, seg_I, seg_J, seg_K, seg_L, seg_M, seg_N; 
    
    wire [8:0] easter;
    
    assign easter = easter_egg - 48;
        
    assign A = (mouse_x > 7 && mouse_x < 36) && (mouse_y > 1 && mouse_y < 9);
    assign B = (mouse_x > 7 && mouse_x < 36) && (mouse_y > 10 && mouse_y < 18);
    assign C = (mouse_x > 7 && mouse_x < 36) && (mouse_y > 19 && mouse_y < 27);
    assign D = (mouse_x > 7 && mouse_x < 36) && (mouse_y > 28 && mouse_y < 35);
    assign E = (mouse_x > 7 && mouse_x < 36) && (mouse_y > 36 && mouse_y < 44);
    assign F = (mouse_x > 7 && mouse_x < 36) && (mouse_y > 45 && mouse_y < 53);
    assign G = (mouse_x > 7 && mouse_x < 36) && (mouse_y > 54 && mouse_y < 63);
    assign H = (mouse_x > 39 && mouse_x < 69) && (mouse_y > 1 && mouse_y < 9);
    assign I = (mouse_x > 39 && mouse_x < 69) && (mouse_y > 10 && mouse_y < 18);
    assign J = (mouse_x > 39 && mouse_x < 69) && (mouse_y > 19 && mouse_y < 27);
    assign K = (mouse_x > 39 && mouse_x < 69) && (mouse_y > 28 && mouse_y < 35);
    assign L = (mouse_x > 39 && mouse_x < 69) && (mouse_y > 36 && mouse_y < 44);
    assign M = (mouse_x > 39 && mouse_x < 69) && (mouse_y > 45 && mouse_y < 53);
    assign N = (mouse_x > 39 && mouse_x < 69) && (mouse_y > 54 && mouse_y < 63);
    
    assign back = mouse_x > 84 && (mouse_y > 5 && mouse_y < 49);
    assign nextpage = mouse_x > 84 && (mouse_y > 51 && mouse_y < 61);
    
    // Create a 3 x 3 cursor
    wire within_cursor; wire [15:0] cursor_color;
    wire cursor_selection;
    assign cursor_selection = A|| B || C || D || E || F || G || H || I || J || K || L || M || N || back || nextpage || learn_page;
    assign within_cursor = ((x == mouse_x) || ((x - mouse_x) == 1) || ((mouse_x - x) == 1)) 
                            && ((y == mouse_y) || ((y - mouse_y) == 1) || ((mouse_y - y) == 1));
    assign cursor_color = ((x == mouse_x) || ((x - mouse_x) == 1) || ((mouse_x - x) == 1)) && ((y == mouse_y) || ((y - mouse_y) == 1) || ((mouse_y - y) == 1)) ? (cursor_selection == 1) ? CURSOR_SELECT : CURSOR_COLOUR : 0; 
    
    reg [15:0] reg_array1 [0:6143];
    reg [15:0] reg_array2 [0:6143];
    
    initial begin
        $readmemb("C:/Users/davia/EE2026/learn1.txt", reg_array1);
        $readmemb("C:/Users/davia/EE2026/learn2.txt", reg_array2);
    end

    
    wire CLK_100Hz;
    wire CLK_10Hz;
    variable_clock clk_100Hz(clk, 499999, CLK_100Hz);
    variable_clock clk_10Hz(clk, 4999999, CLK_10Hz);
    
    always @ (posedge CLK_10Hz) begin
        if (state == 0) begin
            learn_state <= 0;
            learn_page <= 0;
        end
        if (state == 1 && learn_page == 0) begin
            if (mouse_r) learn_state <= 0;
            if (mouse_l && back) learn_state <= 0;
            if (mouse_l && A) learn_state <= 1;
            if (mouse_l && B) learn_state <= 2;
            if (mouse_l && C) learn_state <= 3;
            if (mouse_l && D) learn_state <= 4;
            if (mouse_l && E) learn_state <= 5;
            if (mouse_l && F) learn_state <= 6;
            if (mouse_l && G) learn_state <= 7;
            if (mouse_l && H) learn_state <= 8;
            if (mouse_l && I) learn_state <= 9;
            if (mouse_l && J) learn_state <= 10;
            if (mouse_l && K) learn_state <= 11;
            if (mouse_l && L) learn_state <= 12;
            if (mouse_l && M) learn_state <= 13;
            if (mouse_l && N) learn_state <= 14;
            if (mouse_l && nextpage) begin
                learn_state <= 0;
                learn_page <= 1;
            end
            if (learn_state == easter) easter_egg_done <= 1;
        end
        if (state == 1 && learn_page == 1) begin
            if(mouse_l && nextpage) learn_page <= 0;
        end
    end
    
    
    learn_A a0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_A), .seg(seg_A));
    learn_B b0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_B), .seg(seg_B));
    learn_C c0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_C), .seg(seg_C));
    learn_D d0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_D), .seg(seg_D));
    assign an_E = 4'b0111;
    assign seg_E = 8'b0111_1111;
    learn_F f0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_F), .seg(seg_F));
    learn_G g0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_G), .seg(seg_G));
    learn_H h0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_H), .seg(seg_H));
    learn_I i0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_I), .seg(seg_I));
    learn_J j0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_J), .seg(seg_J));
    learn_K k0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_K), .seg(seg_K));
    learn_L l0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_L), .seg(seg_L));
    learn_M m0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_M), .seg(seg_M));
    learn_N n0(.clk(clk), .clk_1000Hz(clk_1000Hz), .state(state), .learn_state(learn_state), .an(an_N), .seg(seg_N));
    
    display_control disp(clk_1000Hz, learn_state, 
                         an_A, an_B, an_C, an_D, an_E, an_F, an_G, an_H, an_I, an_J, an_K, an_L, an_M, an_N,
                         seg_A, seg_B, seg_C, seg_D, seg_E, seg_F, seg_G, seg_H, seg_I, seg_J, seg_K, seg_L, seg_M, seg_N, 
                         an, seg);
                         
    wire [1:0]start;
    wire centre;
    wire [2:0]move;
    
    assign led[1:0] = move;
    
    wire [5:0]square_top_bound;
    wire [5:0]square_bottom_bound;
    wire [6:0]square_left_bound;
    wire [6:0]square_right_bound;
    
    wire learnpage1;
    assign learnpage1 = (learn_page == 1);
    
    wire CLK_6p25MHz;
    variable_clock clk625MHz(clk, 7, CLK_6p25MHz);
    
    button_controls btn(clk_1000Hz, btnC, btnL, btnR, btnU, btnD, learnpage1, start, centre, move); 
    
    square_controls sq(CLK_6p25MHz, start, centre, move, square_top_bound, square_bottom_bound, square_left_bound, square_right_bound);
    
    always @ (pixel_index) begin 
        if (state == 1) begin
            if (within_cursor && cursor_color != 16'b1111_11111_1111) 
                oled_data <= cursor_color;
            else if (learn_page == 0) 
                oled_data <= reg_array1[pixel_index];
            else if (learn_page == 1)
                if(start == 0) begin
                    if (x <= square_right_bound && y <= square_bottom_bound)
                        oled_data <= 16'b00000_000000_00000; //square is black
                    else 
                        oled_data <= reg_array2[pixel_index];
                    end
                else if (start == 1) begin
                    if (x >= square_left_bound && x <= square_right_bound 
                    && y >= square_top_bound && y <= square_bottom_bound)
                        oled_data <= 16'b00000_000000_11111; //square is blue
                    else 
                        oled_data <= reg_array2[pixel_index];
                    end
        end
     end
                         
     
endmodule
