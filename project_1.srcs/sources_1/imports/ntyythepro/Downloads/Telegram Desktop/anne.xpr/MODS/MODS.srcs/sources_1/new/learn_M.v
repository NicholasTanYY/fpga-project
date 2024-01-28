`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2023 00:26:13
// Design Name: 
// Module Name: learn_G
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


module learn_M(input clk, clk_1000Hz,
               input [1:0]state, [5:0]learn_state,
               output [3:0]an, [7:0]seg);
               
    reg [31:0] COUNT;
    always @ (posedge clk) begin
       COUNT <= (COUNT == 24999999) ? 0 : COUNT + 1;
    end
    
    reg [31:0]counter = 0;
                                    
    assign an = (counter == 1) ? 4'b0111 : 
               (counter >= 2) ? 4'b0011 : 
               4'b1111;
               
    assign seg = 8'b1111_0111;
    
    always @ (posedge clk) begin
       if (state == 1 && learn_state == 13) begin
           counter <= (COUNT == 0) ? counter + 1 : counter;
           end
       if (learn_state != 13) counter <= 0;
    end

endmodule