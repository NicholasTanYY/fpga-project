`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2023 14:42:21
// Design Name: 
// Module Name: variable_clock
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


module variableClock(input CLOCK,
                      input [31:0]counter,
                      input enable,
                      output reg SLOW_CLOCK = 0);

    reg [31:0]COUNT = 0;
    
    always @ (posedge CLOCK) begin
        if (enable) begin
            COUNT = (COUNT == counter) ? 0 : COUNT + 1;
            SLOW_CLOCK = ( COUNT == 0 ) ? ~SLOW_CLOCK : SLOW_CLOCK;
        end
        if (~enable) begin
            COUNT <= 0;
            SLOW_CLOCK <= 0;
        end
    end
        
endmodule
