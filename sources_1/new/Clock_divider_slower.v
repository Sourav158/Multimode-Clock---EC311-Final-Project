`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 03:05:18 AM
// Design Name: 
// Module Name: Clock_divider_slower
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


module Clock_divider_slower(
    input clk_in,
    output reg clk_o
    );
reg [50:0] counter = 50'd0;
parameter Divider = 50'd100000;
always @ (posedge clk_in) begin
    counter<= counter + 50'd1;
    
    if ( counter >= (Divider - 1))
        counter <= 50'd0;
    
    clk_o <= (counter<Divider/2)?1'b1:1'b0;
     
end
endmodule
