`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 07:56:39 PM
// Design Name: 
// Module Name: Timer_tb
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


module Timer_tb( );
    reg Stop_Start, clk, resetn;
    reg [5:0] set;
    wire [7:0]  Seconds_o, Minutes_o, Hours_o;
    wire [11:0]  Milli_o;

Timer_Clock tb2(.Stop_Start(Stop_Start),.clk(clk),.resetn(resetn),.set(set),.Seconds_o(Seconds_o),.Minutes_o(Minutes_o),.Hours_o(Hours_o),.Milli_o(Milli_o));

initial clk = 0;
    always #1 clk = ~clk;
    
    
initial begin 
    resetn = 1;
    set = 6'b000000;
    Stop_Start = 0;
    #1 resetn = 0;
    #1 resetn = 1;
    
    #30000 $finish;    
    

end

endmodule
