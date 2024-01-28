`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2023 13:47:50
// Design Name: 
// Module Name: A_disp
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


module A_disp(input clk_1000Hz, [31:0]counter,
                output reg [7:0]seg, reg [3:0]an);
                
    reg [1:0]display = 0;
    
    
    always @ (posedge clk_1000Hz) begin
        display <= display + 1;
        if (counter > 1) begin
            case(display)
                2'b00: begin
                    an <= 4'b0111;
                    seg <= 8'b0111_1111;
                end
                2'b01: begin
                    an <= 4'b1011;
                    seg <= 8'b1111_0111;
                end
                default: begin
                    an <= 4'b1111;
                    seg <= 8'b1111_1111;
                end
            endcase
        end
    end
endmodule