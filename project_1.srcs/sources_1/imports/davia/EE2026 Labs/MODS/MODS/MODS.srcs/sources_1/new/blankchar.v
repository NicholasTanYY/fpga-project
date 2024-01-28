`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2023 16:48:55
// Design Name: 
// Module Name: blankchar
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


module blankchar(clock, number, cellNumber, currX, currY, x0, x1, charData, isChar);

    input clock;
    input [7:0]number;
    input [2:0]cellNumber;
    input [12:0]currX, currY, x0, x1;
    output reg [15:0]charData = 0;
    output reg isChar = 0;
   
    `include "alphabets.vh"
    wire [12:0]pixelNum;
    assign pixelNum = ((currY - 38) * 7) + (currX - 22 - (15 * cellNumber));
    
    // Store individual number inputs
    reg [15:0] _1 [69:0];
    reg [15:0] _2 [69:0];
    reg [15:0] _3 [69:0];
    reg [15:0] _4 [69:0];
    reg [15:0] _5 [69:0];
    reg [15:0] _6 [69:0];
    reg [15:0] _7 [69:0];
    reg [15:0] _8 [69:0];
    reg [15:0] _9 [69:0];
    
    initial begin
        $readmemh("C:/Users/davia/EE2026/Numbers/1.txt", _1);
        $readmemh("C:/Users/davia/EE2026/Numbers/2.txt", _2);
        $readmemh("C:/Users/davia/EE2026/Numbers/3.txt", _3);
        $readmemh("C:/Users/davia/EE2026/Numbers/4.txt", _4);
        $readmemh("C:/Users/davia/EE2026/Numbers/5.txt", _5);
        $readmemh("C:/Users/davia/EE2026/Numbers/6.txt", _6);
        $readmemh("C:/Users/davia/EE2026/Numbers/7.txt", _7);
        $readmemh("C:/Users/davia/EE2026/Numbers/8.txt", _8);
        $readmemh("C:/Users/davia/EE2026/Numbers/9.txt", _9);
    end
    
    always @ (posedge clock) begin
        isChar <= 0;
        if (currX >= x0 && currX <= x1 && currY >= 38 && currY <= 47) begin
            isChar <= 1;
            case (number)
                one: charData <= _1[pixelNum];
                two: charData <= _2[pixelNum];
                three: charData <= _3[pixelNum];
                four: charData <= _4[pixelNum];
                five: charData <= _5[pixelNum];
                six: charData <= _6[pixelNum];
                seven: charData <= _7[pixelNum];
                eight: charData <= _8[pixelNum];
                nine: charData <= _9[pixelNum];
                default: charData <= 16'h0000;
            endcase
        end
    end
    
endmodule
