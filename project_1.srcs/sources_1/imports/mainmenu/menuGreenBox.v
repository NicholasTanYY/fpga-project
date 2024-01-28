`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2023 03:10:41
// Design Name: 
// Module Name: menuGreenBox
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
// dimensions:
// 

module menuGreenBox(input basys_clock, [2:0]menuItem, [15:0] menuPic, [31:0]currentX, [31:0]currentY, output reg [15:0] oled_data);

    parameter x1 = 11;
    parameter x2 = 42;
    parameter x3 = 52;
    parameter x4 = 83;
    parameter y1 = 13;
    parameter y2 = 31;
    parameter y3 = 37;
    parameter y4 = 53;
    parameter green = 16'b00000_111111_00000;
    parameter black = 16'b00000_000000_00000;
    
    always @ (posedge basys_clock) begin
        case (menuItem)
            3'b001: 
                if ((currentX >= x1 && currentX <= x2 && currentY >= y1 && currentY <= y2)&& !((currentX > x1 && currentX < x2 && currentY > y1 && currentY < y2))) oled_data <= green;
                else oled_data <= menuPic;
            3'b010:
                if ((currentX >= x3 && currentX <= x4 && currentY >= y1 && currentY <= y2)&& !((currentX > x3 && currentX < x4 && currentY > y1 && currentY < y2))) oled_data <= green;
                else oled_data <= menuPic;
            3'b011: 
                if ((currentX >= x1 && currentX <= x2 && currentY >= y3 && currentY <= y4) && !((currentX > x1 && currentX < x2 && currentY > y3 && currentY < y4))) oled_data <= green;
                else oled_data <= menuPic;
            3'b100:
                if ((currentX >= x3 && currentX <= x4 && currentY >= y3 && currentY <= y4)&& !((currentX > x3 && currentX < x4 && currentY > y3 && currentY < y4))) oled_data <= green;
                else oled_data <= menuPic;
        endcase
    end
    
endmodule
