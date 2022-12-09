`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 02:18:18 PM
// Design Name: 
// Module Name: Clock_Counter_tb
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


module Clock_Counter_tb(

    );
    reg clk_in, resetn;
    reg[5:0] set;
    reg Button;
    wire [7:0] Seconds_o, Minutes_o, Hours_o;
    wire[11:0] Milli_o;
    
    Clock_Counter tb1(.Button(Button),.set(set),.clk_in(clk_in), .resetn(resetn), .milli_o(Milli_o),.Seconds_o(Seconds_o),.Hours_o(Hours_o),.Minutes_o(Minutes_o));
    
    initial clk_in = 0;
    always #1 clk_in = ~clk_in;
    
    initial begin 
    resetn = 1;
    set = 6'b000000;
    #1 resetn = 0;
    #1 resetn = 1;
    #1 set = 6'b010000;Button = 1;
    #300000 $finish;
    end
    
    
    
    
    
endmodule
