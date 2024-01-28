`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2023 15:04:34
// Design Name: 
// Module Name: letterCount
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


module letterCount(enable, clock, state, seg, an);

    input enable, clock;
    input [10:0]state;
    output reg [6:0]seg = 0;
    output reg [3:0]an = 0;
    
    reg toggle = 0;
    wire slowerClock;
    
    variableClock(.CLOCK(clock), .counter(499999), .enable(1), .SLOW_CLOCK(slowerClock));
    
    always @ (posedge clock) begin
        if (enable) begin
            case (state)
                // 11 characters left
                11'b00000000000: begin
                    seg <= 7'b1111001;
                    an <= 4'b1100;
                end
                // 10 characters left
                11'b00000000001: begin
                    if (slowerClock) begin
                        seg <= 7'b1111001;
                        an <= 4'b1101;
                        toggle <= 1;
                    end
                    if (~slowerClock) begin
                        seg <= 7'b1000000;
                        an <= 4'b1110;
                        toggle <= 0;
                    end
                end
                // 9 characters left
                11'b00000000011: begin
                    seg <= 7'b0010000;
                    an <= 4'b1110;
                end
                // 8 characters left
                11'b00000000111: begin
                    seg <= 7'b0000000;
                    an <= 4'b1110;  
                end
                // 7 characters left
                11'b00000001111: begin
                    seg <= 7'b1111000;
                    an <= 4'b1110;
                end
                // 6 characters left
                11'b00000011111: begin
                    seg <= 7'b0000010;
                    an <= 4'b1110;    
                end
                // 5 characters left
                11'b00000111111: begin
                    seg <= 7'b0010010;
                    an <= 4'b1110;     
                end
                // 4 characters left
                11'b00001111111: begin
                    seg <= 7'b0011001;
                    an <= 4'b1110;
                end
                // 3 characters left
                11'b00011111111: begin
                    seg <= 7'b0110000;
                    an <= 4'b1110;
                end
                // 2 characters left
                11'b00111111111: begin
                    seg <= 7'b0100100;
                    an <= 4'b1110;
                end
                // 1 characters left
                11'b01111111111: begin
                    seg <= 7'b1111001;
                    an <= 4'b1110;
                end
                // 0 characters left
                11'b11111111111: begin
                    seg <= 7'b1000000;
                    an <= 4'b1110;
                end
            endcase
        end
        if (~enable) begin
            an <= 4'b1111;
        end
    end
endmodule
