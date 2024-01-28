`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 02:01:23
// Design Name: 
// Module Name: eastercode
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


module easterCode(keySignal, clock, letterID, pixelNumber, init, code, pixelData);

    input keySignal, clock;
    input [7:0]letterID;
    input [12:0]pixelNumber; 
    output reg init = 0;
    output [31:0]code;
    output [15:0]pixelData;
    `include "alphabets.vh"
    
    wire [15:0]dataOut;
    reg [4:0]keyPresses = 0;
    reg [3:0]state = 0;
    reg [4:0]counter = 0;
    wire [12:0]currX, currY;
    wire [7:0]isChar;
    wire [15:0]charData[3:0];
    reg [7:0]numberChar[3:0];
        
    assign currX = pixelNumber % 96;
    assign currY = pixelNumber / 96;
    
    assign code = {numberChar[3], numberChar[2], numberChar[1], numberChar[0]};
    
    BRAM_codeScreen screenData(.clk(clock), .addr(pixelNumber), .read_write(0), .data_in(0), .data_out(dataOut));
        
    blankchar create1(.clock(clock), .number(numberChar[0]), .cellNumber(0), .currX(currX), .currY(currY), .x0(22), .x1(28), .charData(charData[0]), .isChar(isChar[0]));
    blankchar create2(.clock(clock), .number(numberChar[1]), .cellNumber(1), .currX(currX), .currY(currY), .x0(37), .x1(43), .charData(charData[1]), .isChar(isChar[1]));
    blankchar create3(.clock(clock), .number(numberChar[2]), .cellNumber(2), .currX(currX), .currY(currY), .x0(52), .x1(58), .charData(charData[2]), .isChar(isChar[2]));
    blankchar create4(.clock(clock), .number(numberChar[3]), .cellNumber(3), .currX(currX), .currY(currY), .x0(67), .x1(73), .charData(charData[3]), .isChar(isChar[3]));
    
    // If this module is enabled, keyboard inputs are recorded
    always @ (negedge keySignal) begin
        // If display is for creating password
        if (~init) begin
            keyPresses = (keyPresses < 5) ? keyPresses + 1 : keyPresses;
            if (letterID != Backspace) begin
                if (letterID != Enter) begin
                    if (keyPresses == (counter + 1)) begin
                        numberChar[counter] <= letterID;
                        state[counter] <= 1;
                        counter <= (counter == 4) ? counter : counter + 1;
                    end     
                end
                if (letterID == Enter) begin
                    keyPresses <= keyPresses - 1;
                    if (state[3]) begin
                        init <= 1;
                    end
                end
            end
            else begin
                keyPresses = (keyPresses == 1) ? 0 : keyPresses - 2;
                counter = (counter == 0) ? counter : counter - 1;
                numberChar[counter] <= 0;
                state[counter] <= 0;
            end
        end
    end            
    
    assign pixelData = (isChar[0]) ? charData[0] :
                       (isChar[1]) ? charData[1] :
                       (isChar[2]) ? charData[2] :
                       (isChar[3]) ? charData[3] :
                       dataOut;
endmodule