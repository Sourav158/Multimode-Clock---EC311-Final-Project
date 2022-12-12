`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 10:33:31 PM
// Design Name: 
// Module Name: TOP
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


module TOP(
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,
    input [5:0]set,
    input mode,
    input Button,
    input Start_Stop,   
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [3:0] VGA_R,    // 4-bit VGA red output
    output wire [3:0] VGA_G,    // 4-bit VGA green output
    output wire [3:0] VGA_B 
    );
    wire w0;
   
    wire w00;
    wire clk1s;
    wire clkslower;
    wire [6:0]w1,s1,s2;
    wire [7:0]Seconds,SecondsA,SecondsB,SecondsC,Hours,HoursA,HoursB,HoursC,Minutes,MinutesA,MinutesB,MinutesC;
    wire [11:0]Milli,MilliA,MilliB,MilliC;
    wire [6:0]digit0,digit1,digit2,digit3,digit4,digit5,digit6,digit7a,digit8a;
    wire[ 13:0]digit78b;
    wire [62:0]con;
    wire [6:0]AP;
    wire STOP_START1;
    wire STOP_START2;
    Clock_Divider_to_1sec C1(CLK,clk1s);
    Clock_divider_slower(CLK,clkslower);
    debouncer G0(CLK,RST_BTN,mode,w0);
    debouncer G20(clkls,RST_BTN,button,w00);
    counter G1(w0,RST_BTN,w1); 
    assign s1 = ((w1 == 2'b00)|(w1 == 2'b01))?set:6'b000000;
    assign s2 = (w1 == 2'b10)?set:6'b000000;
    
    /////w1 if 00 24 hr 01 12hr 10 timer 11 stopwatch
    
    
    assign STOP_START1 = (w1==2'b10)?Start_Stop:1'b0;
    assign STOP_START2 = (w1==2'b11)?Start_Stop:1'b0;
  
    
    Clock_Counter G2(w00,clk1s,s1,RST_BTN,SecondsA,MinutesA,HoursA,MilliA);
    
    Timer_Clock   B1(.Button(w00),.Stop_Start(STOP_START1),.set(s2),.clk(clk1s), .resetn(RST_BTN),.Milli_o(MilliB),.Seconds_o(SecondsB),.Minutes_o(MinutesB),.Hours_o(HoursB));
    Stopwatch_counter B2(clk1s,RST_BTN,STOP_START2,SecondsC,MinutesC,HoursC,MilliC);
    
    assign Milli = (w1 ==2'b10)?MilliB:(w1 == 2'b11)?MilliC:MilliA;
    assign Seconds = (w1 ==2'b10)?SecondsB:(w1 == 2'b11)?SecondsC:SecondsA;
    assign Minutes = (w1 ==2'b10)?MinutesB:(w1 == 2'b11)?MinutesC:MinutesA;
    assign Hours = (w1 ==2'b10)?HoursB:(w1 == 2'b11)?HoursC:HoursA;
    
    seven_segment G3(Milli[3:0],digit0);
    seven_segment G4(Milli[7:4],digit1);
    seven_segment G5(Milli[11:8],digit2);
    seven_segment G6(Seconds[3:0],digit3);
    seven_segment G7(Seconds[7:4],digit4);
    seven_segment G8(Minutes[3:0],digit5);
    seven_segment G9(Minutes[7:4],digit6);
    seven_segment G10(Hours[3:0],digit7a);
    seven_segment G11(Hours[7:4],digit8a);
    seven_segment12 G12(Hours,digit78b);
    
    
    
    assign AP = ((w1 == 2'b01)&(Hours[7:0]>=8'b00010010))?7'b0011000:((w1 == 2'b01)&(Hours[7:0]<8'b00010010))?7'b0001000:7'b1111111;
    
    assign con = (w1 == 2'b01)?{digit78b,digit6,digit5,digit4,digit3,digit2,digit1,digit0}:{digit8a,digit7a,digit6,digit5,digit4,digit3,digit2,digit1,digit0};
    
    
    
    
    
    disp_clock G13( CLK,RST_BTN,con,AP,VGA_HS_O,VGA_VS_O,VGA_R,VGA_G,VGA_B); 
    
    
endmodule
