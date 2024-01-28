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


module learn_A(input clk, clk_1000Hz,
                input [1:0]state, [5:0]learn_state,
                output [3:0]an, [7:0]seg);   
    
    reg [31:0] COUNT = 0;
    
    always @ (posedge clk) begin
        COUNT <= (COUNT == 24999999) ? 0 : COUNT + 1;
    end
    
    wire [7:0]seg_A;
    wire [3:0]an_A;
    
    reg [31:0]counter = 0;
    
    A_disp a1(.clk_1000Hz(clk_1000Hz), .counter(counter), .seg(seg_A), .an(an_A));
                
    assign an = (counter == 1) ? 4'b0111 : 
                (counter > 1) ? an_A : 
                4'b1111;
                
    assign seg = (counter == 1) ? 8'b0111_1111 : 
                 (counter > 1) ? seg_A : 
                 8'b1111_1111;
    
    always @ (posedge clk) begin
        if (learn_state == 1 && state == 1) begin
            counter <= (COUNT == 0) ? counter + 1 : counter;
            end
        if (learn_state != 1) counter <= 0;
    end

endmodule

