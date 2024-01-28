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


module learn_L(input clk, clk_1000Hz,
               input [1:0]state, [5:0]learn_state,
               output [3:0]an, [7:0]seg);
    reg [31:0] COUNT;
    always @ (posedge clk) begin
       COUNT <= (COUNT == 24999999) ? 0 : COUNT + 1;
    end
    
    wire [7:0]seg_L1, seg_L2, seg_L3;
    wire [3:0]an_L1, an_L2, an_L3;
    
    reg [31:0]counter = 0;
    
    A_disp L1(.clk_1000Hz(clk_1000Hz), .counter(counter),
                           .seg(seg_L1), .an(an_L1));
                           
    L2_disp L2(.clk_1000Hz(clk_1000Hz), .counter(counter),
                       .seg(seg_L2), .an(an_L2));
                       
    L3_disp L3(.clk_1000Hz(clk_1000Hz), .counter(counter),
                        .seg(seg_L3), .an(an_L3));
                       
         
    assign an = (counter == 1) ? 4'b0111 : 
               (counter == 2 || counter == 3) ? an_L1 : 
               (counter == 4) ? an_L2 :
               (counter >= 5) ? an_L3 :
               4'b1111;
               
    assign seg = (counter == 1) ? 8'b0111_1111 : 
                (counter == 2 || counter == 3) ? seg_L1 :
                (counter == 4) ? seg_L2 : 
                (counter >= 5) ? seg_L3 :
                8'b1111_1111;
    
    always @ (posedge clk) begin
       if (state == 1 && learn_state == 12) begin
           counter <= (COUNT == 0) ? counter + 1 : counter;
           end
       if (learn_state != 12) counter <= 0;
    end

endmodule