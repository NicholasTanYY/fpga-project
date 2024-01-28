`timescale 1ns / 1ps

module button_controls(
    input CLK_1000Hz, btnC, btnL, btnR, btnU, btnD, sw3,
    output reg start = 0, reg centre = 0, reg [2:0]move = 0
    );
        
    always @ (posedge CLK_1000Hz) begin
        start <= (sw3 == 0) ? 0 : start;
        if (sw3 == 1) begin     
            if (start == 0) begin
                start <= (btnC == 1) ? 1 : start;
                centre <= (btnC == 1) ? 1 : centre;
                end
           
            else if(start == 1) begin // initialise == 1
                centre <= (btnC == 1) ? 1 : (btnL == 1 || btnR == 1 || btnU == 1 || btnD == 1) ? 0 : centre;
                move <= (btnC == 1)? 0 : (btnL == 1) ? 3'b010 : (btnR == 1) ? 3'b001 : (btnU == 1) ? 3'b100 : (btnD == 1) ? 3'b101 : move;
                end
            end
        end
        
endmodule
