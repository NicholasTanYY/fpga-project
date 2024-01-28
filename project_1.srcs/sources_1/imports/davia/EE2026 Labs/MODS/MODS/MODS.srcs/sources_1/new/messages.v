`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2023 22:31:37
// Design Name: 
// Module Name: messages
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


module messages(clock, pixelNumber, currentX, currentY, btnC, btnL, btnR, enable, keySignal, messageMode, status, typeMessageScreen, letterID, dataIn1, dataIn2, dataIn3, pixelData, currData1, currData2, currData3, request, stateOut);

    input clock, btnC, btnL, btnR, enable, keySignal, status;
    input [1:0]messageMode;
    input [7:0]letterID;
    input [12:0]pixelNumber, currentX, currentY;
    input [15:0]typeMessageScreen;
    input [31:0]dataIn1, dataIn2;
    input [23:0]dataIn3;
    output [15:0]pixelData;
    output [31:0]currData1, currData2;
    output [23:0]currData3;
    output reg [2:0]request = 3'b100;
    output [10:0]stateOut;
    `include "alphabets.vh"
    
    wire [15:0]typeMessageScreen; // Main Screen Background
    reg [7:0]letterWrite[10:0]; // Temporarily stores the typed in text
    reg [7:0]letterRead[10:0]; // Reads incoming data stored within the image
    wire [7:0]letter[10:0];
    reg [10:0]state = 0; // Stores the state of each individual character cell 
    reg [4:0]keyPresses = 0; // Tracks the number of correct key presses
    reg [7:0]counter = 0; // Variable for the array
    wire [10:0]char;// Tracks if the current Pixel being updated is on the cell for  printing to screen
    wire [15:0]charData[10:0]; // Store pixel data for showing on OLED
    wire isRedBox, isWhiteBox, slowerClock;
    reg init = 0;
    
    parameter RESET = 3'b000;
    parameter INIT = 3'b001;
    parameter READ = 3'b010;
    parameter WRITE = 3'b011;
    parameter DISABLED = 3'b100;
    
    // To transmit data for encryption
    assign currData1 = {letterWrite[10], letterWrite[9], letterWrite[8], letterWrite[7]};
    assign currData2 = {letterWrite[6], letterWrite[5], letterWrite[4], letterWrite[3]};
    assign currData3 = {letterWrite[2], letterWrite[1], letterWrite[0]};
        
    assign letter[0] = (messageMode == 2) ? letterRead[0] : letterWrite[0];
    assign letter[1] = (messageMode == 2) ? letterRead[1] : letterWrite[1];
    assign letter[2] = (messageMode == 2) ? letterRead[2] : letterWrite[2];
    assign letter[3] = (messageMode == 2) ? letterRead[3] : letterWrite[3];
    assign letter[4] = (messageMode == 2) ? letterRead[4] : letterWrite[4];
    assign letter[5] = (messageMode == 2) ? letterRead[5] : letterWrite[5];
    assign letter[6] = (messageMode == 2) ? letterRead[6] : letterWrite[6];
    assign letter[7] = (messageMode == 2) ? letterRead[7] : letterWrite[7];
    assign letter[8] = (messageMode == 2) ? letterRead[8] : letterWrite[8];
    assign letter[9] = (messageMode == 2) ? letterRead[9] : letterWrite[9];
    assign letter[10] = (messageMode == 2) ? letterRead[10] : letterWrite[10];
    
    assign isWhiteBox = (12 <= currentX && currentX <= 81 && 49 <= currentY && currentY <= 59) ? 1 : 0;
    
    assign stateOut = state;
    
    // Initialise all letter data to 0
    integer i;
    initial begin
        for ( i = 0 ; i < 11 ; i = i + 1 ) begin
            letterWrite[i] = 0;
            letterRead[i] = 0;
        end
    end  
    
    // Red Box to indicate that message can now be stored, white box to cover the option
    redBox selection(.clock(clock), .state(state[0]), .currentX(currentX), .currentY(currentY), .isRedBox(isRedBox));
    
    //Each individual cell for character input
    enterLetter char1(.clock(clock), .cellNumber(0), .currX(currentX), .currY(currentY), .x0(5), .x1(10), .isThisChar(char[0]), .letter(letter[0]), .charData(charData[0]));
    enterLetter char2(.clock(clock), .cellNumber(1), .currX(currentX), .currY(currentY), .x0(13), .x1(18), .isThisChar(char[1]), .letter(letter[1]), .charData(charData[1]));
    enterLetter char3(.clock(clock), .cellNumber(2), .currX(currentX), .currY(currentY), .x0(21), .x1(26), .isThisChar(char[2]), .letter(letter[2]), .charData(charData[2]));
    enterLetter char4(.clock(clock), .cellNumber(3), .currX(currentX), .currY(currentY), .x0(29), .x1(34), .isThisChar(char[3]), .letter(letter[3]), .charData(charData[3]));
    enterLetter char5(.clock(clock), .cellNumber(4), .currX(currentX), .currY(currentY), .x0(37), .x1(42), .isThisChar(char[4]), .letter(letter[4]), .charData(charData[4]));
    enterLetter char6(.clock(clock), .cellNumber(5), .currX(currentX), .currY(currentY), .x0(45), .x1(50), .isThisChar(char[5]), .letter(letter[5]), .charData(charData[5]));
    enterLetter char7(.clock(clock), .cellNumber(6), .currX(currentX), .currY(currentY), .x0(53), .x1(58), .isThisChar(char[6]), .letter(letter[6]), .charData(charData[6]));
    enterLetter char8(.clock(clock), .cellNumber(7), .currX(currentX), .currY(currentY), .x0(61), .x1(66), .isThisChar(char[7]), .letter(letter[7]), .charData(charData[7]));
    enterLetter char9(.clock(clock), .cellNumber(8), .currX(currentX), .currY(currentY), .x0(69), .x1(74), .isThisChar(char[8]), .letter(letter[8]), .charData(charData[8]));
    enterLetter char10(.clock(clock), .cellNumber(9), .currX(currentX), .currY(currentY), .x0(77), .x1(82), .isThisChar(char[9]), .letter(letter[9]), .charData(charData[9]));
    enterLetter char11(.clock(clock), .cellNumber(10), .currX(currentX), .currY(currentY), .x0(85), .x1(90), .isThisChar(char[10]), .letter(letter[10]), .charData(charData[10]));
    
    integer j;
    always @ (negedge keySignal) begin
        if (enable) begin
            // Mode 1 is for entering message
            if (messageMode == 1) begin
                keyPresses = (keyPresses < 12) ? keyPresses + 1 : keyPresses;
                if (letterID != Backspace) begin
                    if (keyPresses == (counter + 1)) begin
                        letterWrite[counter] = letterID;
                        state[counter] = 1;
                        counter = (counter == 11) ? counter : counter + 1;
                    end
                    if (letterID == Esc) begin
                        state = 0;
                        keyPresses = 0;
                        counter = 0;
                        for ( j = 0 ; j < 11 ; j = j + 1 ) begin
                            letterWrite[j] <= 0;
                        end
                    end
                end
                else begin
                    keyPresses = (keyPresses == 1) ? 0 : keyPresses - 2;
                    counter = (counter == 0) ? counter : counter - 1;
                    state[counter] = 0;
                    letterWrite[counter] = 0;
                end
            end
        end
    end
    
    always @ (posedge clock) begin
        if (enable) begin
            if (btnR) begin
                request <= RESET;
                if (status) begin
                    request <= DISABLED;
                end
            end
            case (messageMode)
                1: begin
                    if (btnC && state[0]) begin
                        if (~init) begin
                            request = INIT;
                            if (status) begin
                                init <= 1;
                                request <= DISABLED;
                            end
                        end
                        if (init) begin
                            request = WRITE;
                            if (status) begin
                                request = DISABLED;
                            end
                        end
                    end
                end
                2: begin
                    request <= READ;
                    if (status) begin
                        letterRead[0] <= dataIn3[7:0];
                        letterRead[1] <= dataIn3[15:8];
                        letterRead[2] <= dataIn3[23:16];
                        letterRead[3] <= dataIn2[7:0];
                        letterRead[4] <= dataIn2[15:8];
                        letterRead[5] <= dataIn2[23:16];
                        letterRead[6] <= dataIn2[31:24];
                        letterRead[7] <= dataIn1[7:0];
                        letterRead[8] <= dataIn1[15:8];
                        letterRead[9] <= dataIn1[23:16];
                        letterRead[10] <= dataIn1[31:24];
                        request <= DISABLED;
                    end
                end 
            endcase
        end
    end
    
    // Print out text data
    assign pixelData = (char[0] && enable) ? charData[0] :
                       (char[1] && enable) ? charData[1] :
                       (char[2] && enable) ? charData[2] :
                       (char[3] && enable) ? charData[3] :
                       (char[4] && enable) ? charData[4] :
                       (char[5] && enable) ? charData[5] :
                       (char[6] && enable) ? charData[6] :
                       (char[7] && enable) ? charData[7] :
                       (char[8] && enable) ? charData[8] :
                       (char[9] && enable) ? charData[9] :
                       (char[10] && enable) ? charData[10] :
                       (isRedBox && (messageMode == 1) && enable) ? 16'b11111_000000_00000 :
                       (isWhiteBox && (messageMode == 2) && enable) ? 16'hffff :
                       (enable) ? typeMessageScreen :
                       0;
    
endmodule
