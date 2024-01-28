`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2023 02:25:17
// Design Name: 
// Module Name: MainMenu
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


module MainMenu(clock, pixelNumber, currentX, currentY, btnD, btnU, btnC, btnL, enable, letterID, pixelData, selectedFunc);
    
    input clock, btnD, btnU, btnC, btnL, enable;
    input [12:0]pixelNumber, currentX, currentY;
    input [7:0]letterID;
    output reg [15:0]pixelData;
    output reg [3:0]selectedFunc = 0;
    
    wire [15:0]menuPic;
    reg [1:0]menuItem = 0;
    wire isGreenBox;
    reg moveUp = 0;
    reg moveDown = 0;
    
    BRAM_MainMenu(.clk(clock), .addr(pixelNumber), .read_write(0), .clear(0), .data_in(0), .data_out(menuPic));
    MenuGreenBox(.clock(clock), .enable(enable), .menuItem(menuItem), .currentX(currentX), .currentY(currentY), .isBox(isGreenBox));
    
    always @ (posedge clock) begin
        if (enable) begin
            if (btnU && ~moveUp && menuItem > 0) begin
                menuItem <= menuItem - 1;
                moveUp <= 1;
            end
            if (btnD && ~moveDown && menuItem < 2) begin
                menuItem <= menuItem + 1;
                moveDown <= 1;
            end
            if (~btnD) begin
                moveDown <= 0;
            end
            if (~btnU) begin
                moveUp <= 0;
            end
            if (isGreenBox) begin
                pixelData <= 16'b00000_111111_00000;
            end
            else begin
                pixelData <= menuPic;
            end
            if (btnC && selectedFunc == 0) begin
                selectedFunc[menuItem] <= 1;
            end
            if (btnL) begin
                selectedFunc <= 0;
            end
        end
    end
    
endmodule