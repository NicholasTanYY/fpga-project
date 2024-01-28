//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2023 14:29:39
// Design Name: 
// Module Name: Audio_Visualiser
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

module Audio_Visualiser(
    input enable, basys_clock,
    input [11:0] mic_in,
    input [12:0] pixel_index,
    output reg [15:0] oled_data
    );
    
    wire clk_20khz;
    variable_clock clk20khz(.basys_clock(basys_clock), .m(2499), .slow_clock(clk_20khz));
    
    reg [31:0] counter;
    reg [5:0] plot0, plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, plot10, plot11, plot12, plot13, plot14, plot15, plot16, plot17, plot18, plot19, plot20, plot21, plot22, plot23, plot24, plot25, plot26, plot27, plot28, plot29, plot30, plot31, plot32, plot33, plot34, plot35, plot36, plot37, plot38, plot39, plot40, plot41, plot42, plot43, plot44, plot45, plot46, plot47, plot48, plot49, plot50, plot51, plot52, plot53, plot54, plot55, plot56, plot57, plot58, plot59, plot60, plot61, plot62, plot63, plot64, plot65, plot66, plot67, plot68, plot69, plot70, plot71, plot72, plot73, plot74, plot75, plot76, plot77, plot78, plot79, plot80, plot81, plot82, plot83, plot84, plot85, plot86, plot87, plot88, plot89, plot90, plot91, plot92, plot93, plot94, plot95;
    reg [5:0] paused_plot0, paused_plot1, paused_plot2, paused_plot3, paused_plot4, paused_plot5, paused_plot6, paused_plot7, paused_plot8, paused_plot9, paused_plot10, paused_plot11, paused_plot12, paused_plot13, paused_plot14, paused_plot15, paused_plot16, paused_plot17, paused_plot18, paused_plot19, paused_plot20, paused_plot21, paused_plot22, paused_plot23, paused_plot24, paused_plot25, paused_plot26, paused_plot27, paused_plot28, paused_plot29, paused_plot30, paused_plot31, paused_plot32, paused_plot33, paused_plot34, paused_plot35, paused_plot36, paused_plot37, paused_plot38, paused_plot39, paused_plot40, paused_plot41, paused_plot42, paused_plot43, paused_plot44, paused_plot45, paused_plot46, paused_plot47, paused_plot48, paused_plot49, paused_plot50, paused_plot51, paused_plot52, paused_plot53, paused_plot54, paused_plot55, paused_plot56, paused_plot57, paused_plot58, paused_plot59, paused_plot60, paused_plot61, paused_plot62, paused_plot63, paused_plot64, paused_plot65, paused_plot66, paused_plot67, paused_plot68, paused_plot69, paused_plot70, paused_plot71, paused_plot72, paused_plot73, paused_plot74, paused_plot75, paused_plot76, paused_plot77, paused_plot78, paused_plot79, paused_plot80, paused_plot81, paused_plot82, paused_plot83, paused_plot84, paused_plot85, paused_plot86, paused_plot87, paused_plot88, paused_plot89, paused_plot90, paused_plot91, paused_plot92, paused_plot93, paused_plot94, paused_plot95;
    reg [31:0] x, y; 
    reg [15:0] line_colour, background_colour;
    

    
    always @ (posedge clk_20khz) begin
        case (counter)
            0: begin 
                plot0 <= mic_in[11:6];
                paused_plot0 <= plot0;
                line_colour <= 16'b1010_1010_1010_1010;
                background_colour <= 16'b1000_1000_1010_1010;
            end
        1: plot1 <= mic_in[11:6];
        2: plot2 <= mic_in[11:6];
        3: plot3 <= mic_in[11:6];
        4: plot4 <= mic_in[11:6];
        5: plot5 <= mic_in[11:6];
        6: plot6 <= mic_in[11:6];
        7: plot7 <= mic_in[11:6];
        8: plot8 <= mic_in[11:6];
        9: plot9 <= mic_in[11:6];
        10: plot10 <= mic_in[11:6];
        11: plot11 <= mic_in[11:6];
        12: plot12 <= mic_in[11:6];
        13: plot13 <= mic_in[11:6];
        14: plot14 <= mic_in[11:6];
        15: plot15 <= mic_in[11:6];
        16: plot16 <= mic_in[11:6];
        17: plot17 <= mic_in[11:6];
        18: plot18 <= mic_in[11:6];
        19: plot19 <= mic_in[11:6];
        20: plot20 <= mic_in[11:6];
        21: plot21 <= mic_in[11:6];
        22: plot22 <= mic_in[11:6];
        23: plot23 <= mic_in[11:6];
        24: plot24 <= mic_in[11:6];
        25: plot25 <= mic_in[11:6];
        26: plot26 <= mic_in[11:6];
        27: plot27 <= mic_in[11:6];
        28: plot28 <= mic_in[11:6];
        29: plot29 <= mic_in[11:6];
        30: plot30 <= mic_in[11:6];
        31: plot31 <= mic_in[11:6];
        32: plot32 <= mic_in[11:6];
        33: plot33 <= mic_in[11:6];
        34: plot34 <= mic_in[11:6];
        35: plot35 <= mic_in[11:6];
        36: plot36 <= mic_in[11:6];
        37: plot37 <= mic_in[11:6];
        38: plot38 <= mic_in[11:6];
        39: plot39 <= mic_in[11:6];
        40: plot40 <= mic_in[11:6];
        41: plot41 <= mic_in[11:6];
        42: plot42 <= mic_in[11:6];
        43: plot43 <= mic_in[11:6];
        44: plot44 <= mic_in[11:6];
        45: plot45 <= mic_in[11:6];
        46: plot46 <= mic_in[11:6];
        47: plot47 <= mic_in[11:6];
        48: plot48 <= mic_in[11:6];
        49: plot49 <= mic_in[11:6];
        50: plot50 <= mic_in[11:6];
        51: plot51 <= mic_in[11:6];
        52: plot52 <= mic_in[11:6];
        53: plot53 <= mic_in[11:6];
        54: plot54 <= mic_in[11:6];
        55: plot55 <= mic_in[11:6];
        56: plot56 <= mic_in[11:6];
        57: plot57 <= mic_in[11:6];
        58: plot58 <= mic_in[11:6];
        59: plot59 <= mic_in[11:6];
        60: plot60 <= mic_in[11:6];
        61: plot61 <= mic_in[11:6];
        62: plot62 <= mic_in[11:6];
        63: plot63 <= mic_in[11:6];
        64: plot64 <= mic_in[11:6];
        65: plot65 <= mic_in[11:6];
        66: plot66 <= mic_in[11:6];
        67: plot67 <= mic_in[11:6];
        68: plot68 <= mic_in[11:6];
        69: plot69 <= mic_in[11:6];
        70: plot70 <= mic_in[11:6];
        71: plot71 <= mic_in[11:6];
        72: plot72 <= mic_in[11:6];
        73: plot73 <= mic_in[11:6];
        74: plot74 <= mic_in[11:6];
        75: plot75 <= mic_in[11:6];
        76: plot76 <= mic_in[11:6];
        77: plot77 <= mic_in[11:6];
        78: plot78 <= mic_in[11:6];
        79: plot79 <= mic_in[11:6];
        80: plot80 <= mic_in[11:6];
        81: plot81 <= mic_in[11:6];
        82: plot82 <= mic_in[11:6];
        83: plot83 <= mic_in[11:6];
        84: plot84 <= mic_in[11:6];
        85: plot85 <= mic_in[11:6];
        86: plot86 <= mic_in[11:6];
        87: plot87 <= mic_in[11:6];
        88: plot88 <= mic_in[11:6];
        89: plot89 <= mic_in[11:6];
        90: plot90 <= mic_in[11:6];
        91: plot91 <= mic_in[11:6];
        92: plot92 <= mic_in[11:6];
        93: plot93 <= mic_in[11:6];
        94: plot94 <= mic_in[11:6];
        95: plot95 <= mic_in[11:6];
        104: paused_plot1 <= plot1;
        208: paused_plot2 <= plot2;
        312: paused_plot3 <= plot3;
        416: paused_plot4 <= plot4;
        520: paused_plot5 <= plot5;
        624: paused_plot6 <= plot6;
        728: paused_plot7 <= plot7;
        832: paused_plot8 <= plot8;
        936: paused_plot9 <= plot9;
        1040: paused_plot10 <= plot10;
        1144: paused_plot11 <= plot11;
        1248: paused_plot12 <= plot12;
        1352: paused_plot13 <= plot13;
        1456: paused_plot14 <= plot14;
        1560: paused_plot15 <= plot15;
        1664: paused_plot16 <= plot16;
        1768: paused_plot17 <= plot17;
        1872: paused_plot18 <= plot18;
        1976: paused_plot19 <= plot19;
        2080: paused_plot20 <= plot20;
        2184: paused_plot21 <= plot21;
        2288: paused_plot22 <= plot22;
        2392: paused_plot23 <= plot23;
        2496: paused_plot24 <= plot24;
        2600: paused_plot25 <= plot25;
        2704: paused_plot26 <= plot26;
        2808: paused_plot27 <= plot27;
        2912: paused_plot28 <= plot28;
        3016: paused_plot29 <= plot29;
        3120: paused_plot30 <= plot30;
        3224: paused_plot31 <= plot31;
        3328: paused_plot32 <= plot32;
        3432: paused_plot33 <= plot33;
        3536: paused_plot34 <= plot34;
        3640: paused_plot35 <= plot35;
        3744: paused_plot36 <= plot36;
        3848: paused_plot37 <= plot37;
        3952: paused_plot38 <= plot38;
        4056: paused_plot39 <= plot39;
        4160: paused_plot40 <= plot40;
        4264: paused_plot41 <= plot41;
        4368: paused_plot42 <= plot42;
        4472: paused_plot43 <= plot43;
        4576: paused_plot44 <= plot44;
        4680: paused_plot45 <= plot45;
        4784: paused_plot46 <= plot46;
        4888: paused_plot47 <= plot47;
        4992: paused_plot48 <= plot48;
        5096: paused_plot49 <= plot49;
        5200: paused_plot50 <= plot50;
        5304: paused_plot51 <= plot51;
        5408: paused_plot52 <= plot52;
        5512: paused_plot53 <= plot53;
        5616: paused_plot54 <= plot54;
        5720: paused_plot55 <= plot55;
        5824: paused_plot56 <= plot56;
        5928: paused_plot57 <= plot57;
        6032: paused_plot58 <= plot58;
        6136: paused_plot59 <= plot59;
        6240: paused_plot60 <= plot60;
        6344: paused_plot61 <= plot61;
        6448: paused_plot62 <= plot62;
        6552: paused_plot63 <= plot63;
        6656: paused_plot64 <= plot64;
        6760: paused_plot65 <= plot65;
        6864: paused_plot66 <= plot66;
        6968: paused_plot67 <= plot67;
        7072: paused_plot68 <= plot68;
        7176: paused_plot69 <= plot69;
        7280: paused_plot70 <= plot70;
        7384: paused_plot71 <= plot71;
        7488: paused_plot72 <= plot72;
        7592: paused_plot73 <= plot73;
        7696: paused_plot74 <= plot74;
        7800: paused_plot75 <= plot75;
        7904: paused_plot76 <= plot76;
        8008: paused_plot77 <= plot77;
        8112: paused_plot78 <= plot78;
        8216: paused_plot79 <= plot79;
        8320: paused_plot80 <= plot80;
        8424: paused_plot81 <= plot81;
        8528: paused_plot82 <= plot82;
        8632: paused_plot83 <= plot83;
        8736: paused_plot84 <= plot84;
        8840: paused_plot85 <= plot85;
        8944: paused_plot86 <= plot86;
        9048: paused_plot87 <= plot87;
        9152: paused_plot88 <= plot88;
        9256: paused_plot89 <= plot89;
        9360: paused_plot90 <= plot90;
        9464: paused_plot91 <= plot91;
        9568: paused_plot92 <= plot92;
        9672: paused_plot93 <= plot93;
        9776: paused_plot94 <= plot94;
        9880: paused_plot95 <= plot95;
    endcase
    
        counter <= (counter == 9999) ? 0 : counter + 1;
    end
    
    always @ (posedge basys_clock) begin
    if (enable == 1) begin
        oled_data = background_colour;
        x = pixel_index % 96; // [0:95]
        y = pixel_index / 96; // [0:63]
        
        if (x == 0 && (y == paused_plot0)) oled_data = line_colour;
        if (x == 1 && (y == paused_plot1)) oled_data = line_colour;
        if (x == 2 && (y == paused_plot2)) oled_data = line_colour;
        if (x == 3 && (y == paused_plot3)) oled_data = line_colour;
        if (x == 4 && (y == paused_plot4)) oled_data = line_colour;
        if (x == 5 && (y == paused_plot5)) oled_data = line_colour;
        if (x == 6 && (y == paused_plot6)) oled_data = line_colour;
        if (x == 7 && (y == paused_plot7)) oled_data = line_colour;
        if (x == 8 && (y == paused_plot8)) oled_data = line_colour;
        if (x == 9 && (y == paused_plot9)) oled_data = line_colour;
        if (x == 10 && (y == paused_plot10)) oled_data = line_colour;
        if (x == 11 && (y == paused_plot11)) oled_data = line_colour;
        if (x == 12 && (y == paused_plot12)) oled_data = line_colour;
        if (x == 13 && (y == paused_plot13)) oled_data = line_colour;
        if (x == 14 && (y == paused_plot14)) oled_data = line_colour;
        if (x == 15 && (y == paused_plot15)) oled_data = line_colour;
        if (x == 16 && (y == paused_plot16)) oled_data = line_colour;
        if (x == 17 && (y == paused_plot17)) oled_data = line_colour;
        if (x == 18 && (y == paused_plot18)) oled_data = line_colour;
        if (x == 19 && (y == paused_plot19)) oled_data = line_colour;
        if (x == 20 && (y == paused_plot20)) oled_data = line_colour;
        if (x == 21 && (y == paused_plot21)) oled_data = line_colour;
        if (x == 22 && (y == paused_plot22)) oled_data = line_colour;
        if (x == 23 && (y == paused_plot23)) oled_data = line_colour;
        if (x == 24 && (y == paused_plot24)) oled_data = line_colour;
        if (x == 25 && (y == paused_plot25)) oled_data = line_colour;
        if (x == 26 && (y == paused_plot26)) oled_data = line_colour;
        if (x == 27 && (y == paused_plot27)) oled_data = line_colour;
        if (x == 28 && (y == paused_plot28)) oled_data = line_colour;
        if (x == 29 && (y == paused_plot29)) oled_data = line_colour;
        if (x == 30 && (y == paused_plot30)) oled_data = line_colour;
        if (x == 31 && (y == paused_plot31)) oled_data = line_colour;
        if (x == 32 && (y == paused_plot32)) oled_data = line_colour;
        if (x == 33 && (y == paused_plot33)) oled_data = line_colour;
        if (x == 34 && (y == paused_plot34)) oled_data = line_colour;
        if (x == 35 && (y == paused_plot35)) oled_data = line_colour;
        if (x == 36 && (y == paused_plot36)) oled_data = line_colour;
        if (x == 37 && (y == paused_plot37)) oled_data = line_colour;
        if (x == 38 && (y == paused_plot38)) oled_data = line_colour;
        if (x == 39 && (y == paused_plot39)) oled_data = line_colour;
        if (x == 40 && (y == paused_plot40)) oled_data = line_colour;
        if (x == 41 && (y == paused_plot41)) oled_data = line_colour;
        if (x == 42 && (y == paused_plot42)) oled_data = line_colour;
        if (x == 43 && (y == paused_plot43)) oled_data = line_colour;
        if (x == 44 && (y == paused_plot44)) oled_data = line_colour;
        if (x == 45 && (y == paused_plot45)) oled_data = line_colour;
        if (x == 46 && (y == paused_plot46)) oled_data = line_colour;
        if (x == 47 && (y == paused_plot47)) oled_data = line_colour;
        if (x == 48 && (y == paused_plot48)) oled_data = line_colour;
        if (x == 49 && (y == paused_plot49)) oled_data = line_colour;
        if (x == 50 && (y == paused_plot50)) oled_data = line_colour;
        if (x == 51 && (y == paused_plot51)) oled_data = line_colour;
        if (x == 52 && (y == paused_plot52)) oled_data = line_colour;
        if (x == 53 && (y == paused_plot53)) oled_data = line_colour;
        if (x == 54 && (y == paused_plot54)) oled_data = line_colour;
        if (x == 55 && (y == paused_plot55)) oled_data = line_colour;
        if (x == 56 && (y == paused_plot56)) oled_data = line_colour;
        if (x == 57 && (y == paused_plot57)) oled_data = line_colour;
        if (x == 58 && (y == paused_plot58)) oled_data = line_colour;
        if (x == 59 && (y == paused_plot59)) oled_data = line_colour;
        if (x == 60 && (y == paused_plot60)) oled_data = line_colour;
        if (x == 61 && (y == paused_plot61)) oled_data = line_colour;
        if (x == 62 && (y == paused_plot62)) oled_data = line_colour;
        if (x == 63 && (y == paused_plot63)) oled_data = line_colour;
        if (x == 64 && (y == paused_plot64)) oled_data = line_colour;
        if (x == 65 && (y == paused_plot65)) oled_data = line_colour;
        if (x == 66 && (y == paused_plot66)) oled_data = line_colour;
        if (x == 67 && (y == paused_plot67)) oled_data = line_colour;
        if (x == 68 && (y == paused_plot68)) oled_data = line_colour;
        if (x == 69 && (y == paused_plot69)) oled_data = line_colour;
        if (x == 70 && (y == paused_plot70)) oled_data = line_colour;
        if (x == 71 && (y == paused_plot71)) oled_data = line_colour;
        if (x == 72 && (y == paused_plot72)) oled_data = line_colour;
        if (x == 73 && (y == paused_plot73)) oled_data = line_colour;
        if (x == 74 && (y == paused_plot74)) oled_data = line_colour;
        if (x == 75 && (y == paused_plot75)) oled_data = line_colour;
        if (x == 76 && (y == paused_plot76)) oled_data = line_colour;
        if (x == 77 && (y == paused_plot77)) oled_data = line_colour;
        if (x == 78 && (y == paused_plot78)) oled_data = line_colour;
        if (x == 79 && (y == paused_plot79)) oled_data = line_colour;
        if (x == 80 && (y == paused_plot80)) oled_data = line_colour;
        if (x == 81 && (y == paused_plot81)) oled_data = line_colour;
        if (x == 82 && (y == paused_plot82)) oled_data = line_colour;
        if (x == 83 && (y == paused_plot83)) oled_data = line_colour;
        if (x == 84 && (y == paused_plot84)) oled_data = line_colour;
        if (x == 85 && (y == paused_plot85)) oled_data = line_colour;
        if (x == 86 && (y == paused_plot86)) oled_data = line_colour;
        if (x == 87 && (y == paused_plot87)) oled_data = line_colour;
        if (x == 88 && (y == paused_plot88)) oled_data = line_colour;
        if (x == 89 && (y == paused_plot89)) oled_data = line_colour;
        if (x == 90 && (y == paused_plot90)) oled_data = line_colour;
        if (x == 91 && (y == paused_plot91)) oled_data = line_colour;
        if (x == 92 && (y == paused_plot92)) oled_data = line_colour;
        if (x == 93 && (y == paused_plot93)) oled_data = line_colour;
        if (x == 94 && (y == paused_plot94)) oled_data = line_colour;
        if (x == 95 && (y == paused_plot95)) oled_data = line_colour;
    end
end
endmodule
