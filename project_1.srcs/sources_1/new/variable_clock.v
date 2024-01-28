`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 16:56:45
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


module variable_clock(
    input basys_clock,
    input [31:0] m,
    output reg slow_clock = 0
    );
    
    reg [31:0] count = 0;
        
    always @(posedge basys_clock) begin
        count <= (count == m) ? 0 : count + 1;    // count until m, then reset to 0
        slow_clock <= (count == 0) ? ~slow_clock : slow_clock;  // invert slow clock everytime the clock hits 0
    end
    
endmodule
