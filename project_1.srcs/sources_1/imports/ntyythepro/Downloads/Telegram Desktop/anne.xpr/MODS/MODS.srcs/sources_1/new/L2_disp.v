`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2023 17:48:08
// Design Name: 
// Module Name: B2_disp
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


module L2_disp(input clk_1000Hz, [4:0]counter,
                output reg [7:0]seg, reg [3:0]an);
                
    reg display = 0;
    
    always @ (posedge clk_1000Hz) begin
        display <= display + 1;
        case(display)
            0:begin
                an <= 4'b0101;
                seg <= 8'b0111_1111; 
            end  
            1: begin
                an <= 4'b1011;
                seg <= 8'b1111_0111;
            end
            default: begin
                an <= 4'b1111;
                seg <= 8'b1111_1111;
            end
        endcase
    end
endmodule