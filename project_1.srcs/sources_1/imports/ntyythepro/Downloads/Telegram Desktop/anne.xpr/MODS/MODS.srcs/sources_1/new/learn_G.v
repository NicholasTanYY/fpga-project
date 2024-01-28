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


module learn_G(input clk, clk_1000Hz,
               input [1:0]state, [5:0]learn_state,
               output [3:0]an, [7:0]seg);
    reg [31:0] COUNT;
    always @ (posedge clk) begin
       COUNT <= (COUNT == 24999999) ? 0 : COUNT + 1;
    end
    
    wire [7:0]seg_G1;
    wire [3:0]an_G1;
    
    reg [31:0]counter = 0;
    
    G1_disp G1(.clk_1000Hz(clk_1000Hz), .counter(counter),
                           .seg(seg_G1), .an(an_G1));
                                    
    assign an = (counter == 1 || counter == 2) ? 4'b0111 : 
               (counter == 3 || counter == 4) ? 4'b0011 : 
               (counter >= 5) ? an_G1 :
               4'b1111;
               
    assign seg = (counter >= 1 && counter <=  4) ? 8'b1111_0111 : 
               (counter >= 5) ? seg_G1 : 
               8'b1111_1111;
    
    always @ (posedge clk) begin
       if (state == 1 && learn_state == 7) begin
           counter <= (COUNT == 0) ? counter + 1 : counter;
           end
       if (learn_state != 7) counter <= 0;
    end

endmodule