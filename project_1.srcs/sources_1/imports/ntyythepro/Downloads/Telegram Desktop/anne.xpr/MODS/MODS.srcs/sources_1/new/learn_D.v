`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2023 00:26:13
// Design Name: 
// Module Name: learn_C
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


module learn_D(input clk, clk_1000Hz,
               input [1:0]state, [5:0]learn_state,
               output [3:0]an, [7:0]seg);
    reg [31:0] COUNT;
    always @ (posedge clk) begin
       COUNT <= (COUNT == 24999999) ? 0 : COUNT + 1;
    end
    
    wire [7:0]seg_D1, seg_D2;
    wire [3:0]an_D1, an_D2;
    
    reg [31:0]counter = 0;
    
    B1_disp C1(.clk_1000Hz(clk_1000Hz), .counter(counter),
                           .seg(seg_D1), .an(an_D1));
                           
    B2_disp C2(.clk_1000Hz(clk_1000Hz), .counter(counter),
                       .seg(seg_D2), .an(an_D2));
         
    assign an = (counter == 1 || counter == 2) ? 4'b0111 : 
               (counter == 3) ? an_D1 : 
               (counter >= 4) ? an_D2 :
               4'b1111;
               
    assign seg = (counter == 1 || counter == 2) ? 8'b1111_0111 : 
               (counter == 3) ? seg_D1 : 
               (counter >= 4) ? seg_D2 :
               8'b1111_1111;
    
    always @ (posedge clk) begin
       if (state == 1 && learn_state == 4) begin
           counter <= (COUNT == 0) ? counter + 1 : counter;
           end
       if (learn_state != 4) counter <= 0;
    end

endmodule