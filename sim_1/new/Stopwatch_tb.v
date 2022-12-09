`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 07:27:47 PM
// Design Name: 
// Module Name: Stopwatch_tb
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


module Stopwatch_tb(

    );
    reg clk_in, resetn,Start_Stop;
    wire [7:0] Seconds_o, Minutes_o, Hours_o;
    wire[11:0] Milli_o;
    
    Stopwatch_counter tb1(.Start_Stop(Start_Stop),.clk_in(clk_in), .resetn(resetn), .milli_o(Milli_o),.Seconds_o(Seconds_o),.Hours_o(Hours_o),.Minutes_o(Minutes_o));
    
    initial clk_in = 0;
    always #1 clk_in = ~clk_in;
    
    initial begin 
    resetn = 1;
    Start_Stop = 1;
    #1 resetn = 0;
    #1 resetn = 1;
    #50 Start_Stop = 0;
    #50 Start_Stop = 1;
    #300000 $finish;
    end
    
    
    
    
    
endmodule