`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2023 03:12:04
// Design Name: 
// Module Name: greenBox
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


module greenBox(input [12:0]currentPixel, input btnL, input btnR, input clock, input init, output reg isTrue = 0);
    
    wire [12:0]currentX;
    wire [12:0]currentY;
    reg hasMovedL = 0;
    reg hasMovedR = 0;
    reg [2:0]boxCounter = 3;
    reg [12:0]x0 = 38;
    reg [12:0]x1 = 55;
    reg [12:0]x2 = 40;
    reg [12:0]x3 = 53;
    reg [12:0]y0 = 23;
    reg [12:0]y1 = 40;
    reg [12:0]y2 = 25;
    reg [12:0]y3 = 38;
            
    assign currentY = currentPixel / 96;
    assign currentX = currentPixel % 96;
   
    always @ (posedge clock) begin
        if (boxCounter > 1 && btnL && ~hasMovedL && init) begin
            boxCounter <= boxCounter - 1;
            x0 <= x0-17;
            x1 <= x1-17;
            x2 <= x2-17;
            x3 <= x3-17;
            hasMovedL <= 1;
        end
        if (boxCounter <= 4 && btnR && ~hasMovedR && init) begin
            boxCounter <= boxCounter + 1;
            x0 <= x0+17;
            x1 <= x1+17;
            x2 <= x2+17;
            x3 <= x3+17;
            hasMovedR <= 1;
        end
        if (~btnL) begin
            hasMovedL <= 0;
        end
        if (~btnR) begin
            hasMovedR <= 0;
        end
        if ((x0 <= currentX && currentX <= x1 && y0 <= currentY && currentY <= y2) ||
           (x0 <= currentX && currentX <= x2 && y2 <= currentY && currentY <= y3) ||
           (x3 <= currentX && currentX <= x1 && y2 <= currentY && currentY <= y3) ||
           (x0 <= currentX && currentX <= x1 && y3 <= currentY && currentY <= y1)) begin
            isTrue <= 1; 
        end
        else begin
            isTrue <= 0;
        end
        if (~init) begin
            x0 <= 38;
            x1 <= 55;
            x2 <= 40;
            x3 <= 53;
            boxCounter <= 3;
        end
    end        
    
endmodule
