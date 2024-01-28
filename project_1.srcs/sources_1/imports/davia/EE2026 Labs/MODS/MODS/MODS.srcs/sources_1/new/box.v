`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2023 02:41:53
// Design Name: 
// Module Name: box
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


module box(input [12:0]pixelNumber, input clock, input btnL, input btnR, input enable, output reg [15:0]pixelData = 0);
    
    wire threeSeconds, dbtnL, dbtnR, onehundredMs;
    wire [5:0]w;
    reg isInit = 0;
    variable_clock clk_3s(.CLOCK(clock), .counter(299999999), .enable(enable), .SLOW_CLOCK(threeSeconds));
    variable_clock clk_100ms(.CLOCK(clock), .counter(4999999), .enable(enable), .SLOW_CLOCK(onehundredMs));
    white_box white0(.currentPixel(pixelNumber), .x0(9), .x1(16), .isTrue(w[0]));
    white_box white1(.currentPixel(pixelNumber), .x0(26), .x1(33), .isTrue(w[1]));
    white_box white2(.currentPixel(pixelNumber), .x0(43), .x1(50), .isTrue(w[2]));
    white_box white3(.currentPixel(pixelNumber), .x0(60), .x1(67), .isTrue(w[3]));
    white_box white4(.currentPixel(pixelNumber), .x0(77), .x1(84), .isTrue(w[4]));
    greenBox green(.currentPixel(pixelNumber), .btnL(dbtnL), .btnR(dbtnR), .clock(clock), .init(isInit), .isTrue(w[5]));
    dff buttonL(.clock(onehundredMs), .D(btnL), .Q(dbtnL));
    dff buttonR(.clock(onehundredMs), .D(btnR), .Q(dbtnR));
    
    always @ (posedge clock) begin
        if (enable && threeSeconds) begin
            isInit <= (~isInit) ? 1 : isInit;
        end
        if (~enable) begin
            isInit <= 0;
        end
        casex (w)
            // Green Box
            6'b1xxxxx: pixelData <= (enable) ? 16'b00000_111111_00000 : pixelData;
            // White Boxes
            6'bx1xxxx: pixelData <= (isInit) ? 16'b11111_111111_11111 : pixelData;
            6'bxx1xxx: pixelData <= (isInit) ? 16'b11111_111111_11111 : pixelData;
            6'bxxx1xx: pixelData <= (isInit) ? 16'b11111_111111_11111 : pixelData;
            6'bxxxx1x: pixelData <= (isInit) ? 16'b11111_111111_11111 : pixelData;
            6'bxxxxx1: pixelData <= (isInit) ? 16'b11111_111111_11111 : pixelData;
            default: begin
                pixelData <= 16'b00000_000000_00000;
            end
        endcase
    end
    
endmodule
