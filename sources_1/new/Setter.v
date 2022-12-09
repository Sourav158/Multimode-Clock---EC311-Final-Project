`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 03:32:38 AM
// Design Name: 
// Module Name: Setter
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


module Setter(clk,resetn,set,Hours_i,Minutes_i,Seconds_i,Milli_i,Hours_o,Minutes_o,Seconds_o,milli_o

    );
    
input clk, resetn;
input[1:0] set;
input [7:0] Minutes_i,Hours_i,Seconds_i;
input [11:0] Milli_i;
output reg [7:0] Minutes_o,Hours_o,Seconds_o;
output reg [11:0] milli_o;    
    
always @(posedge clk or negedge resetn)begin
 
 if(!resetn)begin
 Minutes_o <=0;
 Seconds_o <=0;
 Hours_o<=0;
 milli_o<=0;
 end else begin
 if(set == 2'b00)begin
 Seconds_o <= Seconds_i;
 milli_o <= Milli_i;
 Hours_o <= Hours_i;
 Minutes_o <= Minutes_i;
 end   
 if(set == 2'b01)begin
                        Seconds_o[3:0] <= Seconds_o + 1'b1;
                        if(Seconds_o[3:0] == 4'b1001)begin
                            Seconds_o[3:0] <= 0;
                            Seconds_o[7:4] <= Seconds_o[7:4] +1'b1;
                            if(Seconds_o[7:4] >= 4'b0101)begin
                                Seconds_o[7:4] <= 0;
                            end
                         end 
 end 
 if(set == 2'b10)begin
                                Minutes_o[3:0] <= Minutes_o[3:0] + 1'b1;
                                if(Minutes_o[3:0] == 4'b1001)begin
                                    Minutes_o[3:0] <= 0;
                                    Minutes_o[7:4] <= Minutes_o[7:4] + 1'b1;
                                    
                                    if(Minutes_o[7:4] >= 4'b0101)begin
                                        Minutes_o[7:4] <= 0;    
                                    end
                                end
end 
if(set== 2'b11) begin
                        Hours_o[3:0] = Hours_o[3:0]+1'b1;
                            if(Hours_o[3:0] == 4'b1010)begin
                                Hours_o[3:0] <=0;
                                Hours_o[7:4] <= Hours_o[7:4] + 1'b1;
                            
                             end
                             if((Hours_o[7:4] >= 4'b0010)&&(Hours_o[3:0] >= 4'b0100))begin
                                    Hours_o[7:0] = 8'b00000000;
                             end
        end

end
end


endmodule
