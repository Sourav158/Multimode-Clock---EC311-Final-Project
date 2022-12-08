`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 09:42:41 PM
// Design Name: 
// Module Name: sevendecoderbench
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


module sevendecoderbench(

    );
    reg [3:0] a_in;
    wire [6:0] out;
    
    sevdecoder F0(.a_in(a_in),.out(out));
    initial begin
        a_in = 0;
    end 
    always begin 
        #5 a_in <= a_in + 1'b1;
        if (out == 7'b0000100) begin
            #5 a_in <= 0;
            #5 a_in <= a_in + 1'b1;
            #5 a_in <= a_in + 1'b1;
            #10 $finish;
        end
    end   
endmodule

