`timescale 1ns/1ps
module tb_window3x3();
    reg clk, rst_n, valid_in;
    reg [7:0]pixel;
    wire [7:0]p11, p12, p13, p21, p22, p23, p31, p32, p33;
    wire valid_out;
    
    window3x3 #(5)dut(clk, rst_n, pixel, valid_in, valid_out, p11, p12, p13, p21, p22, p23, p31, p32, p33);

    initial clk=0;
    always #5 clk=~clk;
    integer i;
    initial begin
        rst_n=0;
        valid_in=0;
        pixel=0;

        #20;
        rst_n=1;
        valid_in=1;
        for(i=1; i<26;i=i+1)begin
            @(posedge clk);
            pixel = i;
        end
        #260;
        $stop;
    end
    always@(posedge clk)begin
        if(valid_out)begin
            $display("TIME=%0t", $time);
            $display("%d\t%d\t%d", p11, p12, p13);
            $display("%d\t%d\t%d", p21, p22, p23);
            $display("%d\t%d\t%d", p31, p32, p33);
            $display("Valid? %d", valid_out);
        end
    end
endmodule