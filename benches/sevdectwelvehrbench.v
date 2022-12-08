module sevdectwelvehrbench(

    );
    reg [7:0] a_in;
    wire [13:0] out;
    
    sevdectwelvehr F1(.a_in(a_in),.out(out));
    initial begin
        a_in = 0;
    end 
    always begin 
        #5 a_in <= a_in + 1'b1;
        if (out == 14'b10011111001111) begin
            #5 a_in <= 0;
            #5 a_in <= a_in + 1'b1;
            #5 a_in <= a_in + 1'b1;
            #100 $finish;
        end
    end   
endmodule
