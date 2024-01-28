`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2023 01:53:22
// Design Name: 
// Module Name: encryption
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


module encryption(clock, key, mode, pixelNumber, letterData1, letterData2, letterData3, pixelData, status, dataOut1, dataOut2, dataOut3, dataReady, led);

    input clock;
    input [2:0]mode;
    input [12:0]pixelNumber;
    input [31:0]letterData1; // letters 10, 9, 8, 7
    input [31:0]letterData2; // letters 6, 5, 4, 3
    input [23:0]letterData3; // letters 2, 1, 0
    input [3:0]key;
    output [15:0]pixelData;
    output reg status = 0;
    output reg [31:0]dataOut1 = 0;
    output reg [31:0]dataOut2 = 0;
    output reg [23:0]dataOut3 = 0;
    output reg dataReady = 0;
    output reg [15:0]led = 0;
    
    reg originalData[87:0];
    reg [7:0]initCounter = 0;
    reg [7:0]resetCounter = 0;
    reg [7:0]readCounter = 0;
    reg [7:0]writeCounter = 0;
    wire [12:0]addr1, addr2;
    reg [15:0]dataIn;
    reg rwImage = 0;
    wire slowerClock;
    wire [15:0]imageData;
    
    parameter RESET = 3'b000;
    parameter INIT = 3'b001;
    parameter READ = 3'b010;
    parameter WRITE = 3'b011;
    parameter DISABLED = 3'b100;
    
    assign addr1 = (mode == RESET) ? (resetCounter * key) :
                   (mode == INIT) ? (initCounter * key) :
                   (mode == READ) ? (readCounter * key) :
                   (mode == WRITE) ? (writeCounter * key) :
                   0;
    
    BRAM_csgo image(.clk(clock), .addr1(addr1), .addr2(pixelNumber), .read_write(rwImage), .key(key), .data_in(dataIn), .data_out1(imageData), .data_out2(pixelData));
    variableClock(.CLOCK(clock), .counter(5), .enable(1), .SLOW_CLOCK(slowerClock));
    
    always @ (posedge slowerClock) begin
        case (mode)
            RESET: begin
                rwImage <= 1;
                if (resetCounter < 88) begin
                    dataIn <= {imageData[15:1], originalData[resetCounter]};
                    resetCounter <= resetCounter + 1;
                end
                if (resetCounter == 88) begin
                    status <= 1;
                    rwImage <= 0;
                    led <= 0;
                end
            end
            INIT: begin
                rwImage = 0;
                if (initCounter < 88) begin
                    originalData[initCounter] <= imageData[0];
                    initCounter <= initCounter + 1;
                end
                if (initCounter == 88) begin
                    status = 1;
                end
            end
            READ: begin
                rwImage = 0;
                if (readCounter < 24) begin
                    dataOut3[readCounter] <= imageData[0];
                    readCounter <= readCounter + 1;
                end
                if (readCounter >= 24 && readCounter < 56) begin
                    dataOut2[readCounter - 24] <= imageData[0];
                    readCounter <= readCounter + 1;
                end
                if (readCounter >= 56 && readCounter < 88) begin
                    dataOut1[readCounter - 56] <= imageData[0];
                    readCounter <= readCounter + 1;
                end
                if (readCounter == 88) begin
                    status <= 1;
                end
            end
            WRITE: begin
                rwImage <= 1;
                if (writeCounter < 24) begin
                    dataIn <= {imageData[15:1], letterData3[writeCounter]};
                    writeCounter <= writeCounter + 1;
                end
                if (writeCounter >= 24 && writeCounter < 56) begin
                    dataIn <= {imageData[15:1], letterData2[(writeCounter - 24)]};
                    writeCounter <= writeCounter + 1;
                end
                if (writeCounter >= 56 && writeCounter < 88) begin
                    dataIn <= {imageData[15:1], letterData1[(writeCounter - 56)]};
                    writeCounter <= writeCounter + 1;
                end
                if (writeCounter == 88) begin
                    status <= 1;
                    rwImage <= 0;
                    led <= 16'hffff;
                end
            end
            default: begin
                readCounter <= 0;
                writeCounter <= 0;
                resetCounter <= 0;
                initCounter <= 0;
                status <= 0;
            end
                
        endcase
    end
    
                     //Debug Printing Init Bits
//    assign led[0] = originalData[0];
//    assign led[1] = originalData[1];
//    assign led[2] = originalData[2];
//    assign led[3] = originalData[3];
//    assign led[4] = originalData[4];
//    assign led[5] = originalData[5];
//    assign led[6] = originalData[6];
//    assign led[7] = originalData[7];
//    assign led[8] = originalData[8];
//    assign led[9] = originalData[9];
//    assign led[10] = originalData[10];
//    assign led[11] = originalData[11];
//    assign led[12] = originalData[12];
//    assign led[13] = originalData[13];
//    assign led[14] = originalData[14];
//    assign led[15] = originalData[15];

    
endmodule
