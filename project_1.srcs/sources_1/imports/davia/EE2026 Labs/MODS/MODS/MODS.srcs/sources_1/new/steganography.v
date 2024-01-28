`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2023 01:50:37
// Design Name: 
// Module Name: steganography
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


module steganography(sw, enable, btnU, btnD, btnC, btnL, btnR, clock, pixelNumber, easterIn, letterID, transmitting, pixelData, led, seg, an, easteregg);
    
    input [9:0]sw;
    input enable, btnU, btnD, btnC, btnL, btnR, clock, transmitting;
    input [12:0]pixelNumber;
    input [7:0]easterIn, letterID;
    output [15:0]pixelData;
    output [15:0]led;
    output [6:0]seg;
    output [3:0]an;
    output reg easteregg = 0;
    
    wire [15:0]main;
    wire [12:0]currentX, currentY;
    //wire [7:0]letterID;
    wire onehundredMs, keySignal, dkeySignal, oled_data, status, dataReady;
    wire dbtnU, dbtnD, dbtnL, dbtnC, dbtnR;
    wire [3:0]selectedFunc;
    wire [15:0]whichPixelData[1:0];
    wire [15:0]MessageScreen;
    wire [31:0]data1, data2, dataOut1, dataOut2;
    wire [23:0]data3, dataOut3, temp;
    wire [3:0]key, easter;
    wire [2:0]request;
    wire [10:0]state;
    wire [1:0]messageMode;
    `include "alphabets.vh"
    
    assign currentX = pixelNumber % 96;
    assign currentY = pixelNumber / 96;
    
    assign messageMode = (selectedFunc[2]) ? 2 :
                         (selectedFunc[1]) ? 1 :
                         0;
        
    variableClock clk_100ms(.CLOCK(clock), .counter(4999999), .enable(1), .SLOW_CLOCK(onehundredMs));
    
    dff buttonU(.clock(onehundredMs), .D(btnU), .Q(dbtnU));
    dff buttonD(.clock(onehundredMs), .D(btnD), .Q(dbtnD));
    dff buttonL(.clock(onehundredMs), .D(btnL), .Q(dbtnL));
    dff buttonC(.clock(onehundredMs), .D(btnC), .Q(dbtnC));
    dff buttonR(.clock(onehundredMs), .D(btnR), .Q(dbtnR));
    
    // Background Images Stored in BRAM
    BRAM_messages messageScreen(.clk(clock), .addr(pixelNumber), .read_write(0), .data_in(0), .data_out(MessageScreen));
    
    //keyboard inputs(.clk(PS2Clk), .data(PS2Data), .enable(enable), .letterID(letterID), .keySignal(keySignal));
    MainMenu(.clock(clock), .pixelNumber(pixelNumber), .currentX(currentX), .currentY(currentY), .btnD(dbtnD), .btnU(dbtnU), .btnC(dbtnC), .btnL(dbtnL), .enable(enable), .letterID(letterID), .pixelData(main), .selectedFunc(selectedFunc));
    messages inputmessage(.clock(clock), .pixelNumber(pixelNumber), .currentX(currentX), .currentY(currentY), .btnC(dbtnC), .btnL(dbtnL), .btnR(dbtnR), .enable(enable), .keySignal(transmitting), .messageMode(messageMode), .status(status), .typeMessageScreen(MessageScreen), .letterID(letterID), .dataIn1(dataOut1), .dataIn2(dataOut2), .dataIn3(dataOut3), .pixelData(whichPixelData[1]), .currData1(data1), .currData2(data2), .currData3(data3), .request(request), .stateOut(state));
    encryption encrypt(.clock(clock), .key(key), .mode(request), .pixelNumber(pixelNumber), .letterData1(data1), .letterData2(data2), .letterData3(data3), .pixelData(whichPixelData[0]), .dataOut1(dataOut1), .dataOut2(dataOut2), .dataOut3(dataOut3), .dataReady(dataReady), .status(status), .led(led));
    letterCount segmentDisplay(.enable((messageMode == 1) && selectedFunc[1] && enable), .clock(clock), .state(state), .seg(seg), .an(an));
    
    assign pixelData = ((selectedFunc[1] || selectedFunc[2]) && enable) ? whichPixelData[1] :
                       (selectedFunc[0] && enable) ? whichPixelData[0] :
                       (enable) ? main :
                       0;
    
    assign key = sw[1] ? 1 :
                 sw[2] ? 2 :
                 sw[3] ? 3 :
                 sw[4] ? 4 :
                 sw[5] ? 5 :
                 sw[6] ? 6 :
                 sw[7] ? 7 :
                 sw[8] ? 8 :
                 sw[9] ? 9 :
                 1;
                 
    assign easter = (easterIn == one) ? 1 :
                    (easterIn == two) ? 2 :
                    (easterIn == three) ? 3 :
                    (easterIn == four) ? 4 :
                    (easterIn == five) ? 5 :
                    (easterIn == six) ? 6 :
                    (easterIn == seven) ? 7 :
                    (easterIn == eight) ? 8 :
                    (easterIn == nine) ? 9 :
                    0;
                    
    always @ (posedge clock) begin
        if ((key == easter && sw[1]) || (key == easter && key != 1)) begin
            easteregg <= 1;
        end
    end
    
endmodule
