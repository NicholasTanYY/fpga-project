`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2023 18:53:22
// Design Name: 
// Module Name: stegoGreenBox
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


module stegoGreenBox(input clock, enable, [1:0]menuItem, [12:0]currentX, [12:0]currentY, output reg isBox = 0);

    always @ (posedge clock) begin
        if ((((currentX > 2 && currentX < 93 && (currentY == 17 || currentY == 30)) || ((currentX == 3 || currentX == 92) && currentY > 17 && currentY < 30)) && menuItem == 0) ||
           (((currentX > 2 && currentX < 93 && (currentY == 31 || currentY == 44)) || ((currentX == 3 || currentX == 92) && currentY > 31 && currentY < 44)) && menuItem == 1) ||
           (((currentX > 2 && currentX < 93 && (currentY == 45 || currentY == 58)) || ((currentX == 3 || currentX == 92) && currentY > 45 && currentY < 58)) && menuItem == 2)) begin
            isBox <= 1;
        end
        else begin
            isBox <= 0;    
        end
    end
    
endmodule

