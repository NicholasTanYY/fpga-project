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


module anne (
    input [7:0] easter_egg,
    input enable, basys_clock, btnC, btnL, btnR, btnU, btnD,
    input [12:0] pixel_index,
    output [15:0] oled_data, [3:0]an, [7:0]seg, 
    output easter_egg_done, 
    inout PS2Clk, 
    inout PS2Data
    );
    
    
    wire right;
    wire middle;
    wire left;
    wire reset;
    
    wire [15:0] oled_data_home;
    wire [15:0] oled_data_learn;

    reg state = 0;
    
    assign oled_data = (state == 0) ? oled_data_home : oled_data_learn;
    
    wire CLK_1000Hz;
    wire CLK_10Hz;
        
    wire [6:0]x_pixel_index;
    wire [5:0]y_pixel_index;
    
    assign x_pixel_index = pixel_index % 96;
    assign y_pixel_index = pixel_index / 96;
    
    wire [11:0]xpos;
    wire [11:0]ypos;
    wire [3:0]zpos;
    wire new_event;
     
    variable_clock clk1000Hz(basys_clock, 49999, CLK_1000Hz);
    variable_clock clk10Hz(basys_clock,4999999, CLK_10Hz);

    MouseCtl m(.clk(basys_clock), .rst(reset), 
                .xpos(xpos), .ypos(ypos), .zpos(zpos), .left(left), .middle(middle), .right(right),.new_event(new_event), 
                .value(0), .setx(0), .sety(0), .setmax_x(), .setmax_y(), 
                .ps2_clk(PS2Clk), .ps2_data(PS2Data));
    
    
    wire select_learn; 
    assign select_learn = (xpos > 30 && xpos < 65) && (ypos > 29 && ypos < 40);
    wire back;
    assign back = xpos > 84 && (ypos > 5 && ypos < 49);
    
    
    always @ (posedge CLK_10Hz) begin
    if (enable == 1) begin
        if (state == 0) begin
            if (select_learn && left) state <= 1;
        end
        if (state == 1) begin 
            if (back && left) state <= 0;
        end
    end
    if (enable == 0)
        state = 0;
    end

    homepage h(.enable(enable), .clk(basys_clock), .mouse_l(left), .btnC(btnC),
        .mouse_x(xpos), .mouse_y(ypos),
        .x(x_pixel_index), .y(y_pixel_index),
        .state(state),  
        .oled_data(oled_data_home)
        );

    learn_p1 l(
            .clk(basys_clock), .clk_1000Hz(CLK_1000Hz), .mouse_l(left), .mouse_r(right), .btnC(btnC), .btnL(btnL), .btnR(btnR), .btnU(btnU), .btnD(btnD),
            .mouse_x(xpos), .mouse_y(ypos),
            .x(x_pixel_index), .y(y_pixel_index),
            .pixel_index(pixel_index),
            .state(state),  
            .oled_data(oled_data_learn),
            .an(an), .seg(seg), .easter_egg(easter_egg), .easter_egg_done(easter_egg_done));
                 
endmodule