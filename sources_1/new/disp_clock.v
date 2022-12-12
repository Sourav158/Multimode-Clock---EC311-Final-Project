`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 09:08:59 PM
// Design Name: 
// Module Name: disp_clock
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


module disp_clock(
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,
    input wire [62:0]con, 
    input wire [6:0]AP,  
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [3:0] VGA_R,    // 4-bit VGA red output
    output wire [3:0] VGA_G,    // 4-bit VGA green output
    output wire [3:0] VGA_B     // 4-bit VGA blue output
    );
    wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video
    

    // generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pix_stb;
    always @(posedge CLK)
        {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000

    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511

    vga640x480 display (
        .i_clk(CLK),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y)
    );

    // Wires to hold regions on FPGA
    wire SQ1,SQ2,SQ3,SQ4,SQ5,SQ6,SQ7,SQ1B,SQ2B,SQ3B,SQB,SQ5B,SQ6B,SQ7B,C1,C2,SQ1C,SQ2C,SQ3C,SQ4C,SQ5C,SQ6C,SQ7C,SQ1D,SQ2D,SQ3D,SQ4D,SQ5D,SQ6D,SQ7D,C3,C4,SQ1E,SQ2E,SQ3E,SQ4E,SQ5E,SQ6E,SQ7E,SQ1F,SQ2F,SQ3F,SQ4F,SQ5F,SQ6F,SQ7F,C5,SQ1G,SQ2G,SQ3G,SQ4G,SQ5G,SQ6G,SQ7G,SQ1H,SQ2H,SQ3H,SQ4H,SQ5H,SQ6H,SQ7H,SQ1I,SQ2I,SQ3I,SQ4I,SQ5I,SQ6I,SQ7I;
	
	
	wire AP0,AP1,AP2,AP3,AP4,AP5,AP6;
    //Registers for entities
	reg green,grid;
	
	// Creating Regions on the VGA Display represented as wires (640x480)
    
    assign SQ1 = ((con[62]==0)&(x > 30) & (y > 195) & (x < 70) & (y < 200)) ? 1 : 0;
    assign SQ2 = ((con[61]==0)&(x > 70) & (y > 200) & (x < 75) & (y < 240)) ? 1 : 0;     //assign SQ2 = ((x > 180) & (y > 60) & (x < 280) & (y < 420)) ? 1 : 0; 
    assign SQ3 = ((con[60]==0)&(x > 70) & (y > 245) & (x < 75) & (y < 285)) ? 1 : 0; 
    assign SQ4 = ((con[59]==0)&(x > 30) & (y > 285) & (x < 70) & (y < 290)) ? 1 : 0; // Red Square
    assign SQ5 = ((con[58]==0)&(x > 25) & (y > 245) & (x < 30) & (y < 285)) ? 1 : 0; // Red Square
    assign SQ6 = ((con[57]==0)&(x > 25) & (y > 200) & (x < 30) & (y < 240)) ? 1 : 0; // Red Square
    assign SQ7 = ((con[56]==0)&(x > 30) & (y > 240) & (x < 70) & (y < 245)) ? 1 : 0;
    
    assign SQ1B = ((con[55]==0)&(x > 95) & (y > 195) & (x < 135) & (y < 200)) ? 1 : 0;
    assign SQ2B = ((con[54]==0)&(x > 135) & (y > 200) & (x < 140) & (y < 240)) ? 1 : 0;     //assign SQ2 = ((x > 180) & (y > 60) & (x < 280) & (y < 420)) ? 1 : 0; 
    assign SQ3B = ((con[53]==0)&(x > 135) & (y > 245) & (x < 140) & (y < 285)) ? 1 : 0; 
    assign SQ4B = ((con[52]==0)&(x > 95) & (y > 285) & (x < 135) & (y < 290)) ? 1 : 0; // Red Square
    assign SQ5B = ((con[51]==0)&(x > 90) & (y > 245) & (x < 95) & (y < 285)) ? 1 : 0; // Red Square
    assign SQ6B = ((con[50]==0)&(x > 90) & (y > 200) & (x < 95) & (y < 240)) ? 1 : 0; // Red Square
    assign SQ7B = ((con[49]==0)&(x > 95) & (y > 240) & (x < 135) & (y < 245)) ? 1 : 0;
    
    assign C1 = ((x > 155) & (y > 260) & (x < 165) & (y < 270)) ? 1 : 0;
    assign C2 = ((x > 155) & (y > 220) & (x < 165) & (y < 230)) ? 1 : 0;

    assign SQ1C = ((con[48]==0)&(x > 185) & (y > 195) & (x < 225) & (y < 200)) ? 1 : 0;
    assign SQ2C = ((con[47]==0)&(x > 225) & (y > 200) & (x < 230) & (y < 240)) ? 1 : 0;     //assign SQ2 = ((x > 180) & (y > 60) & (x < 280) & (y < 420)) ? 1 : 0; 
    assign SQ3C = ((con[46]==0)&(x > 225) & (y > 245) & (x < 230) & (y < 285)) ? 1 : 0; 
    assign SQ4C = ((con[45]==0)&(x > 185) & (y > 285) & (x < 225) & (y < 290)) ? 1 : 0; // Red Square
    assign SQ5C = ((con[44]==0)&(x > 180) & (y > 245) & (x < 185) & (y < 285)) ? 1 : 0; // Red Square
    assign SQ6C = ((con[43]==0)&(x > 180) & (y > 200) & (x < 185) & (y < 240)) ? 1 : 0; // Red Square
    assign SQ7C = ((con[42]==0)&(x > 185) & (y > 240) & (x < 225) & (y < 245)) ? 1 : 0;
    
    assign SQ1D = ((con[41]==0)&(x > 250) & (y > 195) & (x < 290) & (y < 200)) ? 1 : 0;
    assign SQ2D = ((con[40]==0)&(x > 290) & (y > 200) & (x < 295) & (y < 240)) ? 1 : 0;     //assign SQ2 = ((x > 180) & (y > 60) & (x < 280) & (y < 420)) ? 1 : 0; 
    assign SQ3D = ((con[39]==0)&(x > 290) & (y > 245) & (x < 295) & (y < 285)) ? 1 : 0; 
    assign SQ4D = ((con[38]==0)&(x > 250) & (y > 285) & (x < 290) & (y < 290)) ? 1 : 0; // Red Square
    assign SQ5D = ((con[37]==0)&(x > 245) & (y > 245) & (x < 250) & (y < 285)) ? 1 : 0; // Red Square
    assign SQ6D = ((con[36]==0)&(x > 245) & (y > 200) & (x < 250) & (y < 240)) ? 1 : 0; // Red Square
    assign SQ7D = ((con[35]==0)&(x > 250) & (y > 240) & (x < 290) & (y < 245)) ? 1 : 0;
    
    assign C3 = ((x > 310) & (y > 260) & (x < 320) & (y < 270)) ? 1 : 0;
    assign C4 = ((x > 310) & (y > 220) & (x < 320) & (y < 230)) ? 1 : 0;
    
    assign SQ1E = ((con[34]==0)&(x > 340) & (y > 195) & (x < 380) & (y < 200)) ? 1 : 0;
    assign SQ2E = ((con[33]==0)&(x > 380) & (y > 200) & (x < 385) & (y < 240)) ? 1 : 0;     //assign SQ2 = ((x > 180) & (y > 60) & (x < 280) & (y < 420)) ? 1 : 0; 
    assign SQ3E = ((con[32]==0)&(x > 380) & (y > 245) & (x < 385) & (y < 285)) ? 1 : 0; 
    assign SQ4E = ((con[31]==0)&(x > 340) & (y > 285) & (x < 380) & (y < 290)) ? 1 : 0; // Red Square
    assign SQ5E = ((con[30]==0)&(x > 335) & (y > 245) & (x < 340) & (y < 285)) ? 1 : 0; // Red Square
    assign SQ6E = ((con[29]==0)&(x > 335) & (y > 200) & (x < 340) & (y < 240)) ? 1 : 0; // Red Square
    assign SQ7E = ((con[28]==0)&(x > 340) & (y > 240) & (x < 380) & (y < 245)) ? 1 : 0;
    
    assign SQ1F = ((con[27]==0)&(x > 405) & (y > 195) & (x < 445) & (y < 200)) ? 1 : 0;
    assign SQ2F = ((con[26]==0)&(x > 445) & (y > 200) & (x < 450) & (y < 240)) ? 1 : 0;     //assign SQ2 = ((x > 180) & (y > 60) & (x < 280) & (y < 420)) ? 1 : 0; 
    assign SQ3F = ((con[25]==0)&(x > 445) & (y > 245) & (x < 450) & (y < 285)) ? 1 : 0; 
    assign SQ4F = ((con[24]==0)&(x > 405) & (y > 285) & (x < 445) & (y < 290)) ? 1 : 0; // Red Square
    assign SQ5F = ((con[23]==0)&(x > 400) & (y > 245) & (x < 405) & (y < 285)) ? 1 : 0; // Red Square
    assign SQ6F = ((con[22]==0)&(x > 400) & (y > 200) & (x < 405) & (y < 240)) ? 1 : 0; // Red Square
    assign SQ7F = ((con[21]==0)&(x > 405) & (y > 240) & (x < 445) & (y < 245)) ? 1 : 0;
    
    assign C5 = ((x > 465) & (y > 280) & (x < 475) & (y < 290)) ? 1 : 0;

    assign SQ1G = ((con[20]==0)&(x > 495) & (y > 235) & (x < 515) & (y < 240)) ? 1 : 0;
    assign SQ2G = ((con[19]==0)&(x > 515) & (y > 240) & (x < 520) & (y < 260)) ? 1 : 0;     //assign SQ2 = ((x > 180) & (y > 60) & (x < 280) & (y < 420)) ? 1 : 0; 
    assign SQ3G = ((con[18]==0)&(x > 515) & (y > 265) & (x < 520) & (y < 285)) ? 1 : 0; 
    assign SQ4G = ((con[17]==0)&(x > 495) & (y > 285) & (x < 515) & (y < 290)) ? 1 : 0; // Red Square
    assign SQ5G = ((con[16]==0)&(x > 490) & (y > 265) & (x < 495) & (y < 285)) ? 1 : 0; // Red Square
    assign SQ6G = ((con[15]==0)&(x > 490) & (y > 240) & (x < 495) & (y < 260)) ? 1 : 0; // Red Square
    assign SQ7G = ((con[14]==0)&(x > 495) & (y > 260) & (x < 515) & (y < 265)) ? 1 : 0;
    
    assign SQ1H = ((con[13]==0)&(x > 530) & (y > 235) & (x < 550) & (y < 240)) ? 1 : 0;
    assign SQ2H = ((con[12]==0)&(x > 550) & (y > 240) & (x < 555) & (y < 260)) ? 1 : 0;     //assign SQ2 = ((x > 180) & (y > 60) & (x < 280) & (y < 420)) ? 1 : 0; 
    assign SQ3H = ((con[11]==0)&(x > 550) & (y > 265) & (x < 555) & (y < 285)) ? 1 : 0; 
    assign SQ4H = ((con[10]==0)&(x > 530) & (y > 285) & (x < 550) & (y < 290)) ? 1 : 0; // Red Square
    assign SQ5H = ((con[9]==0)&(x > 525) & (y > 265) & (x < 530) & (y < 285)) ? 1 : 0; // Red Square
    assign SQ6H = ((con[8]==0)&(x > 525) & (y > 240) & (x < 530) & (y < 260)) ? 1 : 0; // Red Square
    assign SQ7H = ((con[7]==0)&(x > 530) & (y > 260) & (x < 550) & (y < 265)) ? 1 : 0;
    
    assign SQ1I = ((con[6]==0)&(x > 565) & (y > 235) & (x < 585) & (y < 240)) ? 1 : 0;
    assign SQ2I = ((con[5]==0)&(x > 585) & (y > 240) & (x < 590) & (y < 260)) ? 1 : 0;     //assign SQ2 = ((x > 180) & (y > 60) & (x < 280) & (y < 420)) ? 1 : 0; 
    assign SQ3I = ((con[4]==0)&(x > 585) & (y > 265) & (x < 590) & (y < 285)) ? 1 : 0; 
    assign SQ4I = ((con[3]==0)&(x > 565) & (y > 285) & (x < 585) & (y < 290)) ? 1 : 0; // Red Square
    assign SQ5I = ((con[2]==0)&(x > 560) & (y > 265) & (x < 565) & (y < 285)) ? 1 : 0; // Red Square
    assign SQ6I = ((con[1]==0)&(x > 560) & (y > 240) & (x < 565) & (y < 260)) ? 1 : 0; // Red Square
    assign SQ7I = ((con[0]==0)&(x > 565) & (y > 260) & (x < 585) & (y < 265)) ? 1 : 0;
    
    

    
    assign AP0 = ((AP[6]==0)&(x > 565) & (y > 180) & (x < 585) & (y < 185)) ? 1 : 0;
    assign AP1 = ((AP[5]==0)&(x > 585) & (y > 185) & (x < 590) & (y < 205)) ? 1 : 0;     //assign SQ2 = ((x > 180) & (y > 60) & (x < 280) & (y < 420)) ? 1 : 0; 
    assign AP2 = ((AP[4]==0)&(x > 585) & (y > 210) & (x < 590) & (y < 230)) ? 1 : 0; 
    assign AP3 = ((AP[3]==0)&(x > 565) & (y > 230) & (x < 585) & (y < 235)) ? 1 : 0; // Red Square
    assign AP4 = ((AP[2]==0)&(x > 560) & (y > 210) & (x < 565) & (y < 230)) ? 1 : 0; // Red Square
    assign AP5 = ((AP[1]==0)&(x > 560) & (y > 185) & (x < 565) & (y < 205)) ? 1 : 0; // Red Square
    assign AP6 = ((AP[0]==0)&(x > 565) & (y > 205) & (x < 585) & (y < 210)) ? 1 : 0;
    
    
 // Assign the registers to the VGA 3rd output. This will display strong red on the Screen when 
 // grid = 1, and strong green on the screen when green = 1;
 assign VGA_R[3] = grid;
 assign VGA_G[3] = green;
  
  always @ (*)
  begin 
	//At start of every input change reset the screen and grid. Check inputs and update grid accordingly
	
	//Green = 0 means that there will be no values of x/y on the VGA that will display green
    green = 0;
	//This statement makes it so that within SQ1, a 3x3 grid of squares appears, with the middle square blacked out
    grid =  SQ1 + SQ2 + SQ3 + SQ4 + SQ5 + SQ6 + SQ7 + SQ1B + SQ2B + SQ3B + SQ4B + SQ5B + SQ6B + SQ7B + C1 + C2 + SQ1C + SQ2C + SQ3C + SQ4C + SQ5C + SQ6C + SQ7C + SQ1D + SQ2D + SQ3D + SQ4D + SQ5D + SQ6D + SQ7D + C3 + C4 + SQ1E + SQ2E + SQ3E + SQ4E + SQ5E + SQ6E + SQ7E +SQ1F + SQ2F + SQ3F + SQ4F + SQ5F + SQ6F + SQ7F + C5 + SQ1G + SQ2G + SQ3G + SQ4G + SQ5G + SQ6G + SQ7G + SQ1H + SQ2H + SQ3H + SQ4H + SQ5H + SQ6H + SQ7H + SQ1I + SQ2I + SQ3I + SQ4I + SQ5I + SQ6I + SQ7I +AP0+AP1+AP2+AP3+AP4+AP5+AP6;
   end
endmodule
