`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2022 10:32:14 PM
// Design Name: 
// Module Name: counter
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


module counter(
    input increment,
    input resetn,
    output reg [1:0] out
    );
    initial
    out = 2'b00;
    
    reg [1:0] next = 2'b00;
    always @ (posedge increment or negedge resetn)begin
            if (!resetn)
            out <= 0;
            else 
            out <= next;
    
    end
    always @ (*)begin
            next <= out + 1'b1;
    end
endmodule