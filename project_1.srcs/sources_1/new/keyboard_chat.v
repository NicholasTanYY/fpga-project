`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 00:38:20
// Design Name: 
// Module Name: keyboard_chat
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

// Modified from https://students.iitk.ac.in/eclub/assets/tutorials/keyboard.pdf
module keyboard_chat(
    input wire keyboard_clk,// Clock input from the keyboard
    input wire data,        // Data input from the keyboard
    output reg [7:0] led    // Printing input data to led
    );
    
    // Internal signal declarations
    reg [7:0] data_curr;    // Current 8-bit data received from the keyboard
    reg [7:0] data_pre;     // Previous 8-bit data from the keyboard
    reg [3:0] b;            // Sending over 11 bits in each data packet. Use a 4-bit counter to track the bit position. 
    reg flag;               // flag signal to indicate the end of the current byte transmission
    
    // Convert from scancode from PS2 keyboard into ascii
    wire [7:0] data_pre_ascii;
    scancode_to_ascii data_pre_to_ascii(.scancode(data_pre), .ascii(data_pre_ascii));
    
    // Initialisation
    initial begin
        b<=4'h1;            // b is initialized to 1, indicating the start of the transmission
        flag<=1'b0;         // no data sent yet
        data_curr<=8'hf0;   // no data sent yet - arbitrary value
        data_pre<=8'hf0;    // no data sent yet - arbitrary value
        led<=8'hf0;         // no data sent yet - arbitrary value
    end
    
    // Activating at negative edge of clock from keyboard
    always @(negedge keyboard_clk) begin 
        case(b)
            1:;                     // Start bit
            2:data_curr[0]<=data;   
            3:data_curr[1]<=data;
            4:data_curr[2]<=data;
            5:data_curr[3]<=data;
            6:data_curr[4]<=data;
            7:data_curr[5]<=data;
            8:data_curr[6]<=data;
            9:data_curr[7]<=data;
            10:flag<=1'b1;          // Parity bit
            11:flag<=1'b0;          // Ending bit
        endcase
        
        if(b<=10)
            b<=b+1;
        else if(b==11)
            b<=1;
    end
    
    // Printing data obtained to led
    always @(posedge flag) begin
        // breakcode val to signify that a key has been released
        if(data_curr == 8'hf0)      
            led <= data_pre_ascii;
        else
            data_pre <= data_curr;
     end
 endmodule
