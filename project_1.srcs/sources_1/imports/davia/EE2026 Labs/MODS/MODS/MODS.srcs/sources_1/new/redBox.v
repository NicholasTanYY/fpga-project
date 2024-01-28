`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2023 16:29:33
// Design Name: 
// Module Name: redBox
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


module redBox(clock, state, currentX, currentY, isRedBox);

    input clock, state;
    input [12:0]currentX, currentY;
    output reg isRedBox;
    
     always @ (posedge clock) begin
        if (((currentX > 12 && currentX < 81 && (currentY == 49 || currentY == 59)) || ((currentX == 12 || currentX == 81) && currentY >= 49 && currentY <= 59)) && state) begin
                isRedBox <= 1;
           end
           else begin
               isRedBox <= 0;    
           end
       end
    
endmodule
