module sevdectwentyfhrbench(

);
    reg [7:0] a_in;
    wire [13:0] out;
    
    sevdectwentyfhr F2(.a_in(a_in),.out(out));
    initial begin
        a_in = 0;
    end 
    always begin 
        #5 a_in <= a_in + 1'b1;
        if (out == 14'b00100101001100) begin
            #5 a_in <= 0;
            #5 a_in <= a_in + 1'b1;
            #5 a_in <= a_in + 1'b1;
            #100 $finish;
        end
    end   
endmodule
