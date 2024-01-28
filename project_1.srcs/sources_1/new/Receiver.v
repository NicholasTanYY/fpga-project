`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2023 23:55:43
// Design Name: 
// Module Name: Receiver
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

// Referenced from: https://www.youtube.com/watch?v=XpfEHPg5AxU&ab_channel=ElectronicswithProf.Mughal
module receiver(
    input basys_clock,      // FPGA Basys 3 Board Clock
    input reset,
    input RxD,            // UART signal input
    output [7:0] RxData,  // data that we receive at the receiving end, using 8 rightmost least significant bits
    output reg transmitting = 1
);

//     // calling the module
//    // Basys3 as a UART receiver from the laptop
//    receiver R1(.basys_clock(basys_clock), .reset(btnU), .RxD(RxD), .RxData(led[7:0]));

    // Internal Variables
    reg shift;
    reg state, nextstate;
    reg [3:0] bit_counter;
    reg [1:0] sample_counter;
    reg [13:0] baudrate_counter;
    reg [9:0] rxshift_reg;
    reg clear_bitcounter, inc_bitcounter, inc_samplecounter, clear_samplecounter;
    
    // Constants
    parameter clk_freq = 100_000_000;
    parameter baud_rate = 9_600;
    parameter div_sample = 4;
    parameter div_counter = clk_freq/(baud_rate*div_sample);
    parameter mid_sample = (div_sample/2);
    parameter div_bit = 10;
    
    assign RxData = rxshift_reg [8:1];
    
    //UART Receiver Logic
    always @(posedge basys_clock)
    begin
        if (reset) begin //if reset button is pressed, all counters are reset
            state <=0; //idle
            bit_counter <=0;
            baudrate_counter <=0;
            sample_counter <=0;
        end 
        else begin
            baudrate_counter <= baudrate_counter +1;
            if (baudrate_counter >= div_counter-1) begin //if the counter reach the BR with sampling
                baudrate_counter <=0; //reset counter
                state <= nextstate;
                if (shift) rxshift_reg <= {RxD, rxshift_reg[9:1]};
                if (clear_samplecounter) sample_counter <=0;
                if (inc_samplecounter) sample_counter <= sample_counter +1;
                if (clear_bitcounter) bit_counter <=0;
                if (inc_bitcounter) bit_counter <= bit_counter +1;
            end
        end
    end
    
        // State Machine
        always @ (posedge basys_clock) begin
            shift <= 0;
            clear_samplecounter <= 0;
            inc_samplecounter <= 0;
            clear_bitcounter <= 0;
            inc_bitcounter <= 0;
            nextstate <= 0;
    
            case (state)
                0: begin // Idle State
                    if (RxD) // If input RxD line is asserted
                    begin
                        nextstate <= 0; // Stay in the idle state, RxD needs to be 1
                    end
                    else begin
                        nextstate <= 1; // Receiving state
                        clear_bitcounter <= 1; // Trigger to clear the bit counter
                        clear_samplecounter <= 1; // Trigger to clear the sample counter
                        // Set the transmitting signal to 1 when data transmission starts
                        transmitting <= 1'b1;
                    end
                end
    
                1: begin // Receiving State
                    nextstate <= 1; // DEFAULT
                    if (sample_counter == mid_sample - 1) shift <= 1;
                    if (sample_counter == div_sample - 1) begin
                        if (bit_counter == div_bit - 1) begin
                            nextstate <= 0;
                            // Set the transmitting signal to 0 when data transmission is complete
                            transmitting <= 1'b0;
                        end
                        inc_bitcounter <= 1;
                        clear_samplecounter <= 1;
                    end 
                    else inc_samplecounter <= 1;
                end
    
                default: nextstate <= 0;
            endcase
        end

endmodule

