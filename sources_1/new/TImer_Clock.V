`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 07:36:01 PM
// Design Name: 
// Module Name: Timer_Clock
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


module Timer_Clock(Button,Stop_Start,set,clk, resetn, Milli_o,Seconds_o,Minutes_o,Hours_o

    );
input Button,Stop_Start, clk, resetn;
input [5:0] set;
output reg [7:0]  Seconds_o, Minutes_o, Hours_o;
output reg [11:0]  Milli_o;
reg[25:0]clock;  
    initial begin
    Seconds_o <= 8'b00000000;
    Minutes_o <= 8'b00000000;
    Hours_o <= 8'b00000000;
    Milli_o <= 12'b000000000000;
  
    end    
always@(posedge clk or negedge resetn)begin
    if (!resetn)begin
    Seconds_o <= 8'b00000000;
    Minutes_o <= 8'b00000000;
    Hours_o <= 8'b00000000;
    Milli_o <= 12'b000000000000;
    end else if(set != 6'b000000) begin 
          clock <= clock + 1'b1;
       if(clock >= 25'd1000)begin
                clock <= 0;
               if(set == 6'b000001)begin
                        Seconds_o[3:0] <= Seconds_o[3:0] + 1'b1;
                        if(Seconds_o[3:0] == 4'b1001)begin
                            Seconds_o[3:0] <= 0;
                        end 
               end
               if(set == 6'b000010)begin
                    Seconds_o[7:4] <= Seconds_o[7:4] +1'b1;
                    
                    if (Seconds_o[7:4] ==4'b0101)
                        Seconds_o[7:4] <=0;
                
               end  
               if(set == 6'b000100)begin
                                Minutes_o[3:0] <= Minutes_o[3:0] + 1'b1;
                                if(Minutes_o[3:0] == 4'b1001)begin
                                    Minutes_o[3:0] <= 0;
                                end
               end  
               if(set ==6'b001000)begin
                            Minutes_o[7:4] <= Minutes_o[7:4] + 1'b1;
                             
                            if(Minutes_o[7:4] >= 4'b0101)begin
                               Minutes_o[7:4] <= 0;    
                            end
               end
                   if(set== 6'b010000) begin
                        Hours_o[3:0] = Hours_o[3:0]+1'b1;
                            if(Hours_o[7:0] >= 8'b00100100)begin
                                Hours_o[3:0] <=0;
                            end
                            if(Hours_o[3:0] == 4'b1010)begin
                                Hours_o[3:0] <=0;
                            end
               end 
               if(set ==6'b100000) begin
               Hours_o[7:4] = Hours_o[7:4]+1'b1;
                            if(Hours_o[7:4] == 4'b0010)begin
                                if(Hours_o[3:0]>=4'b0011)
                                Hours_o[3:0] <=0;
                               
                            end
                            if(Hours_o[7:4]==4'b0011)
                                Hours_o[7:4] <= 0;
               end
               
        
       end
    end else begin
        if ((Stop_Start)&((Hours_o != 0)|(Minutes_o != 0)|(Seconds_o !=0)|(Milli_o != 0)))begin
            
            
            if(Milli_o[3:0] == 0)begin
            Milli_o[3:0] <= 4'b1001;
                if(Milli_o[7:4]== 0)begin
                     Milli_o[7:4] <= 4'b1001;       
                     if(Milli_o[11:8] == 0)begin
                        Milli_o[11:8] <= 4'b1001;
                        if(Seconds_o[3:0] == 0)begin
                            Seconds_o[3:0] <= 4'b1001;
                            if(Seconds_o[7:4] == 0)begin
                                Seconds_o[7:4] <= 4'b0101;
                                if(Minutes_o[3:0]==0)begin
                                    Minutes_o[3:0]<=4'b1001;
                                    if(Minutes_o[7:4] == 0)begin
                                        Minutes_o[7:4] = 4'b0101;
                                        if(Hours_o[3:0] == 0)begin
                                            Hours_o[3:0]<=4'b1001;
                                            Hours_o[7:4]<=Hours_o[7:4] - 1'b1;
                                        end else
                                          Hours_o[3:0] <= Hours_o[3:0] - 1'b1;  
                                    end else
                                        Minutes_o[7:4] <= Minutes_o[7:4] -1'b1; 
                                end else
                                    Minutes_o[3:0] <= Minutes_o[3:0] -1'b1;
                            end else
                                Seconds_o[7:4]<= Seconds_o[7:4] - 1'b1;
                        end else
                            Seconds_o[3:0] <= Seconds_o[3:0] - 1'b1;
                     end else
                        Milli_o[11:8] <= Milli_o[11:8]-1'b1;        
                end else
                    Milli_o[7:4] <= Milli_o[7:4] - 1'b1;
            end else
                Milli_o[3:0] <= Milli_o[3:0] - 1'b1;
         
              
        end
    end
end        
endmodule
   
