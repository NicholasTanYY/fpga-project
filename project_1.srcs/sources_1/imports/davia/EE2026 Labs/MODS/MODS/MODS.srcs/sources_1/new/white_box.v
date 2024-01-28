`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.10.2023 04:39:04
// Design Name: 
// Module Name: white_box
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


module white_box(input [12:0]currentPixel, input [12:0]x0, input [12:0]x1, output isTrue);
    
    wire [12:0]currentX;
    wire [12:0]currentY;
    assign currentX = currentPixel % 96;
    assign currentY = currentPixel / 96;
    assign isTrue = (x0 <= currentX && currentX <= x1 && 28 <= currentY && currentY <= 35) ? 1 : 0;
    
endmodule
