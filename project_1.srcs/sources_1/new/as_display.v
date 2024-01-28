`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2023 10:33:25
// Design Name: 
// Module Name: as_display
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


module as_display(
    input basys_clock,
    input [3:0] sw,
    input [3:0] size,
    input [3:0] char_colour,
    input [3:0] bg_colour,
    output reg [3:0] an,
    output reg [6:0] seg,
    output reg dp
    );
    
    wire clk200Hz;
    variable_clock clk_200Hz(.basys_clock(basys_clock), .m(249999), .slow_clock(clk200Hz));
    
    // letters
    parameter H = 7'b0001001;
    parameter E = 7'b0000110;
    parameter L = 7'b1000111;
    parameter P = 7'b0001100;
    parameter O = 7'b1000000;
    parameter S = 7'b0010010;
    parameter A = 7'b0001000;
    parameter N = 7'b1001000;
    parameter I = 7'b1001111;
    parameter Z = 7'b1100100;
    parameter C = 7'b1000110;
    parameter B = 7'b0000011;
    parameter G = 7'b0010000;
    
    // numbers
    parameter num0 = 7'b1000000;
    parameter num1 = 7'b1111001;
    parameter num2 = 7'b0100100;
    parameter num3 = 7'b0110000;
    parameter num4 = 7'b0011001;
    parameter num5 = 7'b0010010;
    parameter num6 = 7'b0000010;
    parameter num7 = 7'b1111000;
    
    // display nothing    
    parameter NONE = 7'b1111111;
    
    
    reg [1:0] anode_select = 0;
    always @ (posedge clk200Hz) begin
        if (sw == 4'b0000) begin        // all switches off -> show POS
            case (anode_select)
                2'b00: begin
                    an <= 4'b1110;
                    seg <= NONE;
                    dp <= 1;
                end
                2'b01: begin
                    an <= 4'b1101;
                    seg <= S;
                    dp <= 0;
                end
                2'b10: begin
                    an <= 4'b1011;
                    seg <= O;
                    dp <= 1;
                end
                2'b11: begin
                    an <= 4'b0111;
                    seg <= P;
                    dp <= 1;
                end
                default: begin
                    an <= 4'b1111;  // Deactivate all anodes (blank display)
                    seg <= 7'b0000000;
                    dp <= 1;
                end
            endcase
        end
        if (sw == 4'b0001) begin        // sw1 on -> show SNAP
            case (anode_select)
                2'b00: begin
                    an <= 4'b1110;
                    seg <= P;
                    dp <= 0;
                end
                2'b01: begin
                    an <= 4'b1101;
                    seg <= A;
                    dp <= 1;
                end
                2'b10: begin
                    an <= 4'b1011;
                    seg <= N;
                    dp <= 1;
                end
                2'b11: begin
                    an <= 4'b0111;
                    seg <= S;
                    dp <= 1;
                end
                default: begin
                    an <= 4'b1111;  // Deactivate all anodes (blank display)
                    seg <= 7'b0000000;
                    dp <= 1;
                end
            endcase
        end
        if (sw == 4'b0010) begin        // sw2 on -> show SIZE
            case (anode_select)
                2'b00: begin
                    an <= 4'b1110;
                    dp <= 1;
                    case (size)
                        3'b001: seg <= num1;
                        3'b010: seg <= num2;
                        3'b011: seg <= num3;
                        3'b100: seg <= num4;
                        3'b101: seg <= num5;
                    endcase
                end
                2'b01: begin
                    an <= 4'b1101;
                    seg <= Z;
                    dp <= 0;
                end
                2'b10: begin
                    an <= 4'b1011;
                    seg <= I;
                    dp <= 1;
                end
                2'b11: begin
                    an <= 4'b0111;
                    seg <= S;
                    dp <= 1;
                end
                default: begin
                    an <= 4'b1111;  // Deactivate all anodes (blank display)
                    seg <= 7'b0000000;
                    dp <= 1;
                end
            endcase
        end
        if (sw == 4'b0100) begin        // sw3 on -> show COL
            case (anode_select)
                2'b00: begin
                    an <= 4'b1110;
                    dp <= 1;
                    case (char_colour)
                        3'b000: seg <= num0;
                        3'b001: seg <= num1;
                        3'b010: seg <= num2;
                        3'b011: seg <= num3;
                        3'b100: seg <= num4;
                        3'b101: seg <= num5;
                        3'b110: seg <= num6;
                        3'b111: seg <= num7;
                    endcase
                end
                2'b01: begin
                    an <= 4'b1101;
                    seg <= L;
                    dp <= 0;
                end
                2'b10: begin
                    an <= 4'b1011;
                    seg <= O;
                    dp <= 1;
                end
                2'b11: begin
                    an <= 4'b0111;
                    seg <= C;
                    dp <= 1;
                end
                default: begin
                    an <= 4'b1111;  // Deactivate all anodes (blank display)
                    seg <= 7'b0000000;
                    dp <= 1;
                end
            endcase
        end
        if (sw == 4'b1000) begin        // sw4 on -> show BG
            case (anode_select)
                2'b00: begin
                    an <= 4'b1110;
                    dp <= 1;
                    case (bg_colour)
                        3'b000: seg <= num0;
                        3'b001: seg <= num1;
                        3'b010: seg <= num2;
                        3'b011: seg <= num3;
                        3'b100: seg <= num4;
                        3'b101: seg <= num5;
                        3'b110: seg <= num6;
                        3'b111: seg <= num7;
                    endcase
                end
                2'b01: begin
                    an <= 4'b1101;
                    seg <= NONE;
                    dp <= 1;
                end
                2'b10: begin
                    an <= 4'b1011;
                    seg <= G;
                    dp <= 0;
                end
                2'b11: begin
                    an <= 4'b0111;
                    seg <= B;
                    dp <= 1;
                end
                default: begin
                    an <= 4'b1111;  // Deactivate all anodes (blank display)
                    seg <= 7'b0000000;
                    dp <= 1;
                end
            endcase
        end
        anode_select <= anode_select + 1;
    end
endmodule
