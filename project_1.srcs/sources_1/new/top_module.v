`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2023 17:27:00
// Design Name: 
// Module Name: top_module
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


module top_module(
    input basys_clock,
    input btnC,
    input btnU, btnD, btnL, btnR,
    input [15:0] sw,
    input J_MIC3_Pin3,
    inout PS2Clk, PS2Data,
    input RxD,
    output [15:0] led,
    output [3:0] an,
    output [6:0] seg,
    output dp,
    output J_MIC3_Pin1, J_MIC3_Pin4,
    output cs, sdin, sclk, d_cn, resn, vccen, pmoden    // oled_display
);

    wire [3:0] easter_egg_done;
    wire clk6p25m;        
    variable_clock clk_6p25MHz(.basys_clock(basys_clock), .m(7), .slow_clock(clk6p25m));
    
    wire fb, sending_pixels, sample_pixel;
    wire [12:0] pixel_index;
    wire [15:0] oled_data;
    wire [31:0] currentX, currentY;
    assign currentX = pixel_index % 96;
    assign currentY = pixel_index / 96;
    
    reg [2:0] selectedItem = 3'b001;
    
    wire clock_10hz;
    variable_clock clk_10Hz(.basys_clock(basys_clock), .m(4999999), .slow_clock(clock_10hz));
    always @(posedge clock_10hz) begin
    if (sw[14] == 0) begin
        if (btnR && (selectedItem == 3'b001 || selectedItem == 3'b011)) begin
            selectedItem <= selectedItem + 1;
        end
        if (btnL && (selectedItem == 3'b010 || selectedItem == 3'b100)) begin
            selectedItem <= selectedItem - 1;
        end
        if (btnD && selectedItem <= 3'b010) begin
            selectedItem <= selectedItem + 2;
        end
        if (btnU && selectedItem >= 3'b011) begin
            selectedItem <= selectedItem - 2;
        end
    end
    end
    
    reg [4:0] enable = 5'b10000;
    
    always @(sw[14]) begin
        if (sw[14] && selectedItem == 3'b001) begin
            enable = 5'b01000;
        end
        if (sw[14] && selectedItem == 3'b010) begin
            enable = 5'b00100;
        end
        if (sw[14] && selectedItem == 3'b011) begin
            enable = 5'b00010;
        end
        if (sw[14] && selectedItem == 3'b100) begin
            enable = 5'b00001;
        end
        if (~sw[14]) begin
            enable = 5'b10000;
        end
    end
    
    Oled_Display(.clk(clk6p25m), 
                 .reset(), 
                 .frame_begin(fb), 
                 .sending_pixels(sending_pixels),
                 .sample_pixel(sample_pixel), 
                 .pixel_index(pixel_index), 
                 .pixel_data(oled_data), 
                 .cs(cs), 
                 .sdin(sdin), 
                 .sclk(sclk), 
                 .d_cn(d_cn), 
                 .resn(resn), 
                 .vccen(vccen),
                 .pmoden(pmoden));
     

    wire [15:0]menuPic, morseCode, powerpoint, mic, steganography, mainMenu, easterScreen;
    wire [3:0] an1, an2, an3, an4;
    wire [6:0] seg1, seg2, seg3, seg4;
    wire dp1, dp2, dp3, dp4;
    wire [15:0]led1, led2, led3, led4, led5;
    wire [7:0]keySignal;
    wire init;
    wire [31:0]code;
    reg mode = 1;
    wire [7:0] transmit_data;
    wire transmit;

    assign oled_data = (~init) ?  easterScreen : 
                       (~sw[14]) ? mainMenu :
                       (selectedItem == 1) ? morseCode :
                       (selectedItem == 2) ? powerpoint : 
                       (selectedItem == 3) ? mic :
                       (selectedItem == 4) ? steganography :
                       0;
                       

     assign an = (enable == 5'b01000 && mode) ? an1 :
                 (enable == 5'b00100 && mode) ? an2 : 
                 (enable == 5'b00010 && mode) ? an3 :
                 (enable == 5'b00001 && mode) ? an4 :
                 4'b1111;
                 
     assign seg = (enable == 5'b01000 && mode) ? seg1 :
                 (enable == 5'b00100 && mode) ? seg2 : 
                 (enable == 5'b00010 && mode) ? seg3 :
                 (enable == 5'b00001 && mode) ? seg4 :
                 7'b1111_111;    
     
    assign dp = (enable == 5'b01000 && mode) ? dp1 :
                 (enable == 5'b00100 && mode) ? dp2 : 
                 (enable == 5'b00010 && mode) ? dp3 :
                 (enable == 5'b00001 && mode) ? dp4 :
                 1;         
     
    assign led = (~sw[14]) ? led5 :
                 (enable[1]) ? led3 : 
                 (enable[0]) ? led4 :
                 (enable[2]) ? led2 :
                 0;
                  
    assign led5 = {easter_egg_done, 12'b0000_0000_0000};
    
    assign dp4 = 1; 
    
    // Easter Egg!
    receiver R1(.basys_clock(basys_clock), .reset(), .RxD(RxD), .RxData(transmit_data), .transmitting(transmit));
    easterCode easter(.keySignal(transmit), .clock(basys_clock), .letterID(transmit_data), .pixelNumber(pixel_index), .init(init), .code(code), .pixelData(easterScreen));
    
    //annes task
    anne anne1(.easter_egg(code[31:24]), .enable(enable[3]), .basys_clock(basys_clock), .btnC(btnC), .btnL(btnL), .btnR(btnR), .btnU(btnU), .btnD(btnD),
      .pixel_index(pixel_index), .oled_data(morseCode), .an(an1), .seg({dp1, seg1}), .easter_egg_done(easter_egg_done[3]), .PS2Clk(PS2Clk), .PS2Data(PS2Data));
      
    //jonathans task
    jonathan (.enable(enable[1]), .basys_clock(basys_clock), .J_MIC3_Pin3(J_MIC3_Pin3), .sw(sw[0]), .easter_egg(code[15:8]), .pixel_index(pixel_index), .seg(seg3), .an(an3), .dp(dp3),
                .led(led3),.J_MIC3_Pin1(J_MIC3_Pin1), .J_MIC3_Pin4(J_MIC3_Pin4), .oled_data(mic), .easter_egg_done(easter_egg_done[1]));
      
      //nicholas task
    powerpoint(.enable(enable[2]), .easterIn(code[23:16]), .transmitted_data(transmit_data), .basys_clock(basys_clock), .pixel_index(pixel_index),
    .oled_data(powerpoint), .btnC(btnC), .btnU(btnU), .btnD(btnD), .btnL(btnL),
    .btnR(btnR), .sw(sw), .PS2Clk(PS2Clk), .PS2Data(PS2Data), .led(led2), .an(an2), .seg(seg2), .dp(dp2), .easter_egg_done(easter_egg_done[2]));
     
     //davians task
    steganography(.sw(sw[9:0]), .enable(enable[0]), .btnU(btnU), .btnD(btnD), .btnC(btnC), .btnL(btnL), .btnR(btnR), .transmitting(transmit), .clock(basys_clock), .pixelNumber(pixel_index), .letterID(transmit_data), .easterIn(code[7:0]), .pixelData(steganography), .led(led4), .seg(seg4), .an(an4), .easteregg(easter_egg_done[0]));

    BRAM_GroupMenu(.clk(basys_clock), .addr(pixel_index), .read_write(0), .data_in(0), .data_out(menuPic));
    menuGreenBox(.basys_clock(basys_clock), .menuItem(selectedItem),.menuPic(menuPic), .currentX(currentX), .currentY(currentY), .oled_data(mainMenu));    

endmodule