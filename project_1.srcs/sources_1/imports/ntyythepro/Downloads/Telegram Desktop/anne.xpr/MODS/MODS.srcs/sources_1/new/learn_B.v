`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2023 17:45:38
// Design Name: 
// Module Name: learn_B
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


module learn_B(input clk, clk_1000Hz,
               input [1:0]state, [5:0]learn_state,
               output [3:0]an, [7:0]seg);   

    reg [31:0] COUNT;
    always @ (posedge clk) begin
        COUNT <= (COUNT == 24999999) ? 0 : COUNT + 1;
    end
    
    wire [7:0]seg_B1, seg_B2, seg_B3;
    wire [3:0]an_B1, an_B2, an_B3;
    
    reg [31:0]counter = 0;
    
    B1_disp B1(.clk_1000Hz(clk_1000Hz), .counter(counter),
                            .seg(seg_B1), .an(an_B1));
                            
    B2_disp B2(.clk_1000Hz(clk_1000Hz), .counter(counter),
                        .seg(seg_B2), .an(an_B2));
                    
    B3_disp B3(.clk_1000Hz(clk_1000Hz), .counter(counter),
                    .seg(seg_B3), .an(an_B3));
          
    assign an = (counter == 1 || counter == 2) ? 4'b0111 : 
                (counter == 3) ? an_B1 : 
                (counter == 4) ? an_B2 :
                (counter >= 5) ? an_B3 : 
                4'b1111;
                
    assign seg = (counter == 1 || counter == 2) ? 8'b1111_0111 : 
                (counter == 3) ? seg_B1 : 
                (counter == 4) ? seg_B2 :
                (counter >= 5) ? seg_B3 : 
                8'b1111_1111;
    
    always @ (posedge clk) begin
        if (state == 1 && learn_state == 2) begin
            counter <= (COUNT == 0) ? counter + 1 : counter;
            end
        if (learn_state != 2) counter <= 0;
    end

endmodule

