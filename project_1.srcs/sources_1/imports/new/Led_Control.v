`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 20:12:46
// Design Name: 
// Module Name: soundFilter
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


module Led_Control(input enable, input [7:0] easter_egg, basys_clock, input [11:0] mic_in, output reg [6:0] seg,
output reg [3:0] an, output reg dp, output reg [15:0] led, output reg easter_egg_done = 0);

`include "alphabets.vh"

wire clk_20khz, clk_2hz;
reg [11:0] max_mic = 0;
reg [31:0] counter = 0;
reg [5:0] level = 0;
reg [1:0] display = 0;
reg [3:0] timer = 0; //counter for easter eggs
wire [3:0] easter;

variable_clock clk20khz(.basys_clock(basys_clock), .m(2499), .slow_clock(clk_20khz));
variable_clock clk2hz(.basys_clock(basys_clock), .m(24999999), .slow_clock(clk_2hz));

assign easter = (easter_egg == one) ? 1 :
                (easter_egg == two) ? 2 :
                (easter_egg == three) ? 3 :
                (easter_egg == four) ? 4 :
                (easter_egg == five) ? 5 :
                (easter_egg == six) ? 6 :
                (easter_egg == seven) ? 7 :
                (easter_egg == eight) ? 8 :
                (easter_egg == nine) ? 9 :
                10;
                
//easter egg logic
always @ (posedge clk_2hz) begin
    if (level >= 15) begin //loudest audio input
        timer <= (timer == easter) ? easter : timer + 1;
    end
    
    else //not a loud noise
        timer <= 0;
        
    if (timer == easter) begin
        easter_egg_done <= 1;
    end
end

always @(posedge clk_20khz) begin
    
    if (max_mic < mic_in) begin
        max_mic <= mic_in;
    end
    
    else max_mic <= max_mic;
    
    if (counter == 2000) begin
    
        counter <= 0;
        max_mic <= 0;
        
        if (max_mic < 2000) begin
            level <= 0;
        end
        if (max_mic >= 2000 && max_mic < 2125) begin
            level <= 1;
        end   
        else if (max_mic >= 2125 && max_mic < 2250) begin
            level <= 2;
        end      
        else if (max_mic >= 2250 && max_mic < 2375) begin
            level <= 3;
        end      
        else if (max_mic >= 2500 && max_mic < 2625) begin
            level <= 4;
        end
        else if (max_mic >= 2625 && max_mic < 2750) begin
            level <= 5;
        end
        else if (max_mic >= 2750 && max_mic < 2875) begin
            level <= 6;
        end
        else if (max_mic >= 2875 && max_mic < 3000) begin
            level <= 7;
        end
        else if (max_mic >= 3000 && max_mic < 3125) begin
            level <= 8;
        end
        else if (max_mic >= 3125 && max_mic < 3250) begin
            level <= 9;
        end
        else if (max_mic >= 3250 && max_mic < 3375) begin
            level <= 10;
        end
        else if (max_mic >= 3375 && max_mic < 3500) begin
            level <= 11;
        end
        else if (max_mic >= 3500 && max_mic < 3625) begin
            level <= 12;
        end
        else if (max_mic >= 3625 && max_mic < 3750) begin
            level <= 13;
        end
        else if (max_mic >= 3750 && max_mic < 3875) begin
            level <= 14;
        end
        else if (max_mic >= 4000 && max_mic < 4125) begin
            level <= 15;
        end
        else if (max_mic >= 4125 && max_mic < 4250) begin
            level <= 16;
        end
        
        else level <= level;
    end
    
    else begin
    
        counter <= counter + 1;
        
    end
    
end

    always @ (posedge basys_clock) begin
    if (enable == 1) begin
        case (level)
            16'd0: led <= 16'b0000_0000_0000_0000;
            16'd1: led <= 16'b0000_0000_0000_0001;
            16'd2: led <= 16'b0000_0000_0000_0011;
            16'd3: led <= 16'b0000_0000_0000_0111;
            16'd4: led <= 16'b0000_0000_0000_1111;
            16'd5: led <= 16'b0000_0000_0001_1111;
            16'd6: led <= 16'b0000_0000_0011_1111;
            16'd7: led <= 16'b0000_0000_0111_1111;
            16'd8: led <= 16'b0000_0000_1111_1111;
            16'd9: led <= 16'b0000_0001_1111_1111;
            16'd10: led <= 16'b0000_0011_1111_1111;
            16'd11: led <= 16'b0000_0111_1111_1111;
            16'd12: led <= 16'b0000_1111_1111_1111;
            16'd13: led <= 16'b0001_1111_1111_1111;
            16'd14: led <= 16'b0011_1111_1111_1111;
            16'd15: led <= 16'b0111_1111_1111_1111;
            16'd16: led <= 16'b1111_1111_1111_1111;
        endcase
    end
    else if (enable == 0)
        led <= 16'b0000_0000_0000_0000;
end
    
    always @ (posedge clk_20khz) begin 
    if (enable == 1) begin
        display <= display + 1;
        case (display)
            2'b00:  begin
                if (level <= 6) begin
                    seg <= 7'b0010_000;
                    an <= 4'b0111;
                    dp <= 1;
                end
                else if (level > 6 && level <= 14) begin
                    seg <= 7'b0001_001;
                    an <= 4'b0111;
                    dp <= 1;  
                end     
                else begin
                    seg <= 7'b1000_000;
                    an <= 4'b0111;
                    dp <= 1;                      
                end        
            end
            
            2'b01:  begin
                if (level <= 6) begin
                    seg <= 7'b1000_000;
                    an <= 4'b1011;
                    dp <= 1;
                end
                else if (level > 6 && level <= 14) begin
                    seg <= 7'b1101_010;
                    an <= 4'b1011;
                    dp <= 1;  
                end   
                else begin
                    seg <= 7'b1000_001;
                    an <= 4'b1011;
                    dp <= 1;                      
                end            
            end
             
            2'b10: begin
                if (level <= 6) begin
                    seg <= 7'b1000_000;
                    an <= 4'b1101;
                    dp <= 1;
                end
                else if (level > 6 && level <= 14) begin
                    seg <= 7'b1101_010;
                    an <= 4'b1101;
                    dp <= 1;  
                end  
                else begin
                    seg <= 7'b1000_110;
                    an <= 4'b1101;
                    dp <= 1;                      
                end                                   
            end
            
            2'b11:  begin
                if (level <= 6) begin
                    seg <= 7'b0100_001;
                    an <= 4'b1110;
                    dp <= 1;
                end
                else if (level > 6 && level <= 14) begin
                    seg <= 7'b1101_010;
                    an <= 4'b1110;
                    dp <= 1;  
                end 
                else begin
                    seg <= 7'b0001_001;
                    an <= 4'b1110;
                    dp <= 1;                      
                end                                   
            end
        endcase
     end
  end

endmodule
