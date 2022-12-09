`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2022 03:32:39 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
input clk, resetn, button,
output reg out

);
reg [25:0] deb_count;
reg [1:0] current,next;
reg deb_count_start, output_exist;

parameter [25:0]MAX = 100000;

initial begin
deb_count = 0;
out = 0;
end
always @(posedge clk or negedge resetn) begin
    if (!resetn)begin
        deb_count <= 0;
        out <= 0;
    end else begin
      
  
        if(!button)begin
            deb_count_start =0;
            deb_count = 0;
            output_exist = 0;
        end else if (output_exist)begin
            out = 0;
        end else begin
            deb_count <= deb_count + 1'b1;
            if(deb_count_start == 0)begin
                deb_count_start = 1;
            end  
        
  
  
 
//second block  
            if(deb_count == MAX)begin
            out = 1;
            deb_count_start = 0;
            deb_count = 0;
            output_exist = 1;
            end 
       end
    end
 
 end
 

endmodule