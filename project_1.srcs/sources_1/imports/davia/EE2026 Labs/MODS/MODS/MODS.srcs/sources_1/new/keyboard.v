`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2023 00:22:27
// Design Name: 
// Module Name: keyboard
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


module keyboard(
    inout wire clk, // Clock pin from keyboard
    inout wire data, //Data pin from keyboard
    input enable,
    output reg [7:0] letterID, //Printing input data to led
    output reg keySignal
    );
    
    reg [7:0] data_curr;
    reg [7:0] data_pre;
    reg [3:0] b;
    reg flag;
        
    initial begin
        b<=4'h1;
        flag<=1'b0;
        data_curr<=8'h00;
        data_pre<=8'hf0;
        letterID<=8'hf0;
    end
    always @(negedge clk) //Activating at negative edge of clock from keyboard
    begin
    if (enable) begin
        case(b)
            1:; //first bit
            2:data_curr[0]<=data;
            3:data_curr[1]<=data;
            4:data_curr[2]<=data;
            5:data_curr[3]<=data;
            6:data_curr[4]<=data;
            7:data_curr[5]<=data;
            8:data_curr[6]<=data;
            9:data_curr[7]<=data;
            10:flag<=1'b1; //Parity bit
            11:flag<=1'b0; //Ending bit
        endcase
    if(b<=10)
        b<=b+1;
    else if(b==11)
        b<=1;
    end
    end
    always@(posedge flag) // Printing data obtained to led
    begin
        if (enable) begin
        if(data_curr==8'hf0) begin
            letterID<=data_pre;
            keySignal <= 1;
        end
        else begin
            data_pre<=data_curr;
            keySignal <= 0;
        end
        end
    end 
endmodule
