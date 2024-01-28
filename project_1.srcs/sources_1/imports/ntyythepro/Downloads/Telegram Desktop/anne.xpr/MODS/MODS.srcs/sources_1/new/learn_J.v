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


module learn_J(input clk, clk_1000Hz,
               input [1:0]state, [5:0]learn_state,
               output [3:0]an, [7:0]seg);   

    reg [31:0] COUNT;
    always @ (posedge clk) begin
        COUNT <= (COUNT == 24999999) ? 0 : COUNT + 1;
    end
    
    wire [7:0]seg_J1, seg_J2, seg_J3;
    wire [3:0]an_J1, an_J2, an_J3;
    
    reg [31:0]counter = 0;
    
    A_disp J1(.clk_1000Hz(clk_1000Hz), .counter(counter),
                            .seg(seg_J1), .an(an_J1));
                            
    J2_disp J2(.clk_1000Hz(clk_1000Hz), .counter(counter),
                        .seg(seg_J2), .an(an_J2));
                    
    J3_disp J3(.clk_1000Hz(clk_1000Hz), .counter(counter),
                    .seg(seg_J3), .an(an_J3));
          
    assign an = (counter == 1) ? 4'b0111 : 
                (counter == 2 || counter == 3) ? an_J1 : 
                (counter == 4 || counter == 5) ? an_J2 :
                (counter >= 6) ? an_J3 : 
                4'b1111;
                
    assign seg = (counter == 1) ? 8'b0111_1111 : 
                (counter == 2 || counter == 3) ? seg_J1 : 
                (counter == 4 || counter == 5) ? seg_J2 :
                (counter >= 6) ? seg_J3 : 
                8'b1111_1111;
    
    always @ (posedge clk) begin
        if (state == 1 && learn_state == 10) begin
            counter <= (COUNT == 0) ? counter + 1 : counter;
            end
        if (learn_state != 10) counter <= 0;
    end

endmodule