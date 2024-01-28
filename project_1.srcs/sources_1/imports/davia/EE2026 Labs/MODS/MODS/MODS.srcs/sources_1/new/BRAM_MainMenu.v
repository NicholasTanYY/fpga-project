`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2023 02:08:54
// Design Name: 
// Module Name: BRAM_MainMenu
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


module BRAM_GroupMainMenu(clk, addr, read_write, clear, data_in, data_out);
    parameter n = 13;
    parameter w = 16;

    input clk, read_write, clear;
    input [n-1:0] addr;
    input [w-1:0] data_in;
    output reg [w-1:0] data_out;

    // Start module here!
    reg [15:0] reg_array [6143:0];

    initial begin
        $readmemh("C:/Users/davia/EE2026/groupmenu.txt", reg_array);
    end

    always @(posedge(clk)) begin
        if(read_write == 1)
            reg_array[addr] <= data_in;
        data_out = reg_array[addr];
    end
endmodule
