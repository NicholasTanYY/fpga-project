`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2023 23:31:24
// Design Name: 
// Module Name: learn_A
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


module learn_N(input clk, clk_1000Hz,
                input [1:0]state, [5:0]learn_state,
                output [3:0]an, [7:0]seg);   
    
    reg [31:0] COUNT = 0;
    always @ (posedge clk) begin
        COUNT <= (COUNT == 24999999) ? 0 : COUNT + 1;
    end
    
    wire [7:0]seg_N;
    wire [3:0]an_N;
    
    reg [31:0]counter = 0;
    
    B1_disp N1(.clk_1000Hz(clk_1000Hz), .counter(counter), .seg(seg_N), .an(an_N));
                
    assign an = (counter == 1 || counter == 2) ? 4'b0111 : 
                (counter >= 3) ? an_N : 
                4'b1111;
                
    assign seg = (counter == 1 || counter == 2) ? 8'b1111_0111 : 
                 (counter >= 3) ? seg_N : 
                 8'b1111_1111;
    
    always @ (posedge clk) begin
        if (learn_state == 14 && state == 1) begin
            counter <= (COUNT == 0) ? counter + 1 : counter;
            end
        if (learn_state != 14) counter <= 0;
    end

endmodule
