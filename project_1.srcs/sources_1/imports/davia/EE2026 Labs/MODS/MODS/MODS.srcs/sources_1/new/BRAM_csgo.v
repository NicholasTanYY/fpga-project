`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2023 22:10:49
// Design Name: 
// Module Name: BRAM_csgo
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


module BRAM_csgo(clk, addr1, addr2, read_write, key, data_in, data_out1, data_out2);
    parameter n = 13;
    parameter w = 16;

    input clk, read_write;
    input [3:0]key;
    input [n-1:0] addr1, addr2;
    input [w-1:0] data_in;
    output reg [w-1:0] data_out1, data_out2;

    // Start module here!
    reg [15:0] reg_array [6143:0];

    initial begin
        $readmemh("C:/Users/davia/EE2026/csgo_new.txt", reg_array);
    end
    
    always @(posedge(clk)) begin
        if(read_write == 1)
            reg_array[addr1 - key] <= data_in;
        data_out1 = reg_array[addr1];
    end
    
    always @ (negedge(clk)) begin
        data_out2 = reg_array[addr2];
    end 
endmodule
