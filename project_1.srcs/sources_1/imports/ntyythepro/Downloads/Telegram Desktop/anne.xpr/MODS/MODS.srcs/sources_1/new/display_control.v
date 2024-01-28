`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2023 23:36:34
// Design Name: 
// Module Name: display_control
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


module display_control(input clk_1000Hz,
                       input [5:0] learn_state, 
                       input [3:0] an_A, an_B, an_C, an_D, an_E, an_F, an_G, an_H, an_I, an_J, an_K, an_L, an_M, an_N, 
                       input [7:0] seg_A, seg_B, seg_C, seg_D, seg_E, seg_F, seg_G, seg_H, seg_I, seg_J, seg_K, seg_L, seg_M, seg_N,
                       output reg [3:0] an, reg [7:0] seg);
                       
    always @ (posedge clk_1000Hz) begin
        case(learn_state)
        0: begin
          an <= 4'b1111; seg <= 8'b1111_1111;  
        end
        1: begin
          an <= an_A; seg <= seg_A;  
        end 
        2: begin
          an <= an_B; seg <= seg_B;  
        end
        3: begin
            an <= an_C; seg <= seg_C;
        end
        4: begin
            an <= an_D; seg <= seg_D;
        end
        5: begin
            an <= an_E; seg <= seg_E;
        end
        6: begin
            an <= an_F; seg <= seg_F;
        end
        7: begin
            an <= an_G; seg <= seg_G;
        end
        8: begin
            an <= an_H; seg <= seg_H;
        end
        9: begin
            an <= an_I; seg <= seg_I;
        end
        10: begin
            an <= an_J; seg <= seg_J;
        end
        11: begin
            an <= an_K; seg <= seg_K;
        end
        12: begin
            an <= an_L; seg <= seg_L;
        end
        13: begin
            an <= an_M; seg <= seg_M;
        end
        14: begin
            an <= an_N; seg <= seg_N;
        end
        default: begin
          an <= 4'b1111; seg<= 8'b1111_1111;  
        end                       
        endcase
       end


endmodule
