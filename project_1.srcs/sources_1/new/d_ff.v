`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2023 02:28:33
// Design Name: 
// Module Name: d_ff
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


module d_ff(
    input basys_clock,
    input btn,
    output reg debounced_btn = 0
    );
    
    wire clock_10hz;
    variable_clock clk_10Hz(.basys_clock(basys_clock), .m(4999999), .slow_clock(clock_10hz));
    
    always @ (posedge clock_10hz)
    begin
        debounced_btn <= btn;
    end
    
endmodule

