`timescale 1ns / 1ps

module square_controls(
    input CLK_6p25MHz, start, centre, [2:0]move,
    output reg [5:0]square_top_bound = 0, reg [5:0]square_bottom_bound = 4, reg [6:0]square_left_bound = 0, reg [6:0]square_right_bound = 4
    );
    
    reg [16:0] COUNT = 0;
    
    always @ (posedge CLK_6p25MHz) begin
        COUNT = (COUNT == 69443) ? 0 : COUNT + 1; 
        if (start == 0) begin
            //square_top_bound <= 0;
            square_bottom_bound <= 4;
            //square_left_bound <= 0;
            square_right_bound <= 4;
            end
        else if (start == 1) begin
            if (centre == 1) begin
                square_top_bound <= 0;
                square_bottom_bound <= 4;
                square_left_bound <= 0;
                square_right_bound <= 4;
                end
            else if (COUNT == 0 && move == 3'b010 && square_left_bound > 3) begin //move left
                square_left_bound <= square_left_bound - 1;
                square_right_bound <= square_right_bound - 1;
                end
            else if (COUNT == 0 && move == 3'b001 && square_right_bound < 82) begin //move right
                square_left_bound <= square_left_bound + 1;
                square_right_bound <= square_right_bound + 1;
                end
            else if (COUNT == 0 && move == 3'b100 && square_top_bound > 3) begin //move up
                square_top_bound <= square_top_bound - 1;
                square_bottom_bound <= square_bottom_bound - 1;
                end
            else if (COUNT == 0 && move == 3'b101 && square_bottom_bound < 60) begin //move down
                square_top_bound <= square_top_bound + 1;
                square_bottom_bound <= square_bottom_bound + 1;
                end
            end
        end            
endmodule
