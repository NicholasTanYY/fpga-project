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


module Top_Student(clock, btnU, btnD, btnL, btnR, btnC, sw, led, seg, JC, an, dp, PS2Clk, PS2Data);

    input clock, btnU, btnD, btnL, btnR, btnC;
    input [15:0]sw;
    output [15:0]led;
    output [6:0]seg;
    output [7:0]JC;
    output [3:0]an;
    output dp;
    inout PS2Clk, PS2Data;
    
    // Oled Dependencies
    wire clk_6p25;
    variableClock clk6p25m(.CLOCK(clock), .counter(7), .enable(1), .SLOW_CLOCK(clk_6p25));
    wire [15:0] oled_data, steganography, morseCode, powerpoint, mic, passwordDisplay;
    wire [12:0] pixelNumber;
    wire [6:0] seg1, seg2, seg3, seg4;
    wire [3:0] an1, an2, an3, an4;
    wire [15:0] led1, led2, led3, led4;
    wire fb;
    
    wire [7:0]letterID;
    wire keySignal;
    wire [15:0]mainMenu;
    
    reg [2:0]selectedItem = 0;
    wire init;
    wire [31:0]code;
    wire [15:0]codeScreen;
    
    keyboard inputs(.clk(PS2Clk), .data(PS2Data), .enable(~init), .letterID(letterID), .keySignal(keySignal));
    
    eastercode easter(.keySignal(keySignal), .clock(clock), .letterID(letterID), .pixelNumber(pixelNumber), .init(init), .code(code), .pixelData(codeScreen), .led(led));
    
    steganography(.sw(sw[15:0]), .enable(1), .btnU(btnU), .btnD(btnD), .btnC(btnC), .btnL(btnL), .btnR(btnR), .clock(clock), .pixelNumber(pixelNumber), .PS2Clk(PS2Clk), .PS2Data(PS2Data), .pixelData(steganography));
    
    assign oled_data = (~init) ? codeScreen : steganography;
    
    //powerpoint(.basys_clock(clock), .btnC(btnC), .btnU(btnU), .btnD(btnD), .btnL(btnL), .btnR(btnR),
    //           .sw(sw[3:0]), .PS2Clk(PS2Clk), .PS2Data(PS2Data), .led(led2), .an(an2), .seg(seg2), .dp(dp), .cs());
    
    
//    assign oled_data = (selectedItem == 1 && mode) ? morseCode :
//                       (selectedItem == 2 && mode) ? powerpoint : 
//                       (selectedItem == 3 && mode) ?  mic :
//                       (selectedItem == 4 && mode) ? steganography :
//                       (selectedItem == 0 && mode) ? mainMenu :
//                       passwordDisplay;
                       
//    assign seg = (selectedItem == 1 && mode) ? seg1 :
//                 (selectedItem == 2 && mode) ? seg2 :
//                 (selectedItem == 3 && mode) ? seg3 :
//                 (selectedItem == 4 && mode) ? seg4 :
//                 7'b1111111;
    
//    assign an = (selectedItem == 1 && mode) ? an1 :
//                (selectedItem == 2 && mode) ? an2 :
//                (selectedItem == 3 && mode) ? an3 :
//                (selectedItem == 4 && mode) ? an4 :
//                4'b1111;
    
    Oled_Display display1(.clk(clk_6p25), .reset(0), .frame_begin(fb), .sending_pixels(),
                          .sample_pixel(), .pixel_index(pixelNumber), .pixel_data(oled_data), .cs(JC[0]),
                          .sdin(JC[1]), .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]), .pmoden(JC[7]));

endmodule

// Old Code or Assignment Archives
   // wire leftMouse, middleMouse, rightMouse;
    //wire [11:0]mouseX, mouseY;
//    assign an = 0;
//    assign led[1] = sw[1];
    
    //box boxPictures(.pixelNumber(pixelNumber), .clock(clock), .btnL(btnL), .btnR(btnR), .enable(sw[1]), .pixelData(oled_data));
    
    //MouseCtl test_mouse(.clk(clock), .rst(0), .value(0), .setx(0), .sety(0), .setmax_x(), .setmax_y(), .xpos(mouseX), .ypos(mouseY), .zpos(), .left(leftMouse), .middle(middleMouse), .right(rightMouse), .new_event(), .ps2_clk(PS2Clk), .ps2_data(PS2Data));
    
    //paint test_paint(.clk_100M(clock), .mouse_l(leftMouse), .reset(rightMouse), .enable(1), .mouse_x(mouseX), .mouse_y(mouseY), .pixel_index(pixelNumber), .led(led), .mouse_press(), .mouse_reset(), .mouse_press_x(), .mouse_press_y(), .seg(seg), .colour_chooser(oled_data));
    
    //BRAM_csgo print(.clk(clock), .addr(pixelNumber), .read_write(0), .clear(0), .data_in(0), .data_out(oled_data));
    
    //keyboard keytest(.clk(PS2Clk), .data(PS2Data), .letterID(led[7:0]), .led(led[8]));