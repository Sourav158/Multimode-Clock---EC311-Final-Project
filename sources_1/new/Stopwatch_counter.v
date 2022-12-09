`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2022 02:42:08 PM
// Design Name: 
// Module Name: Clock_Counter
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


module Stopwatch_counter(clk_in,resetn,Start_Stop,Seconds_o,Minutes_o,Hours_o,milli_o);
input clk_in, resetn,Start_Stop;
output reg [7:0] Seconds_o, Minutes_o, Hours_o;
output reg [11:0] milli_o;
initial begin
    Seconds_o <= 0;
    Minutes_o <= 0;
    Hours_o <= 0;
    milli_o <= 0;
    end

always@(posedge clk_in or negedge resetn)begin
    if (!resetn)begin
    Seconds_o <= 0;
    Minutes_o <= 0;
    Hours_o <= 0;
    milli_o <= 0;
    end else if(Start_Stop)begin                                   
 ////////////////////////////////////////////////////////////   
        milli_o = milli_o + 1;
        if(milli_o[3:0] == 4'b1010)begin
            milli_o[3:0] <= 0;
            milli_o[7:4] = milli_o[7:4] + 1'b1;
            if(milli_o[7:4] == 4'b1010)begin
                milli_o[7:4] <= 0;
                milli_o[11:8] = milli_o[11:8] + 1'b1;
                if(milli_o[11:8] == 4'b1010) begin
                    milli_o[11:8] <= 0;
                    Seconds_o[3:0] <= Seconds_o[3:0] + 1'b1;
                        if(Seconds_o[3:0] == 4'b1001)begin
                            Seconds_o[3:0] <= 0;
                            Seconds_o[7:4] <= Seconds_o[7:4] +1'b1;
                            if(Seconds_o[7:4] == 4'b0101)begin
                                Seconds_o[7:4] <= 0;
                                Minutes_o[3:0] <=Minutes_o[3:0] + 1'b1;
                                if(Minutes_o[3:0] == 4'b1001)begin
                                    Minutes_o[3:0] <= 0;
                                    Minutes_o[7:4] <= Minutes_o[7:4] + 1'b1;
                                    if(Minutes_o[7:4] == 4'b0101)begin
                                        Minutes_o[7:4] <= 0;
                                        Hours_o[3:0] = Hours_o[3:0] + 1'b1;
                                        if(Hours_o[3:0] == 4'b1010)begin
                                            Hours_o[3:0] <= 0;
                                            Hours_o[7:4] = Hours_o[7:4] + 1'b1;
                                        end
                                        
                                        if((Hours_o[7:4]>= 4'b0010)&&(Hours_o[3:0]>= 4'b0100))begin
                                            Hours_o[7:0] = 8'b00000000;
                                        end
                                    end
                                
                                end
                            end        
                        end                    
                end                
            end
        end
    
    
    end
end
endmodule