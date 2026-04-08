`timescale 1ns/1ps
module tb_window3x3();
    reg clk, rst_n, valid_input;
    reg [7:0]pixel;
    wire [7:0]p11, p12, p13, p21, p22, p23, p31, p32, p33;
    wire valid_output;
    
    window3x3 #(5, 5)dut(
        .clk(clk), .rst_n(rst_n), .pixel(pixel), .valid_input(valid_input), .valid_output(valid_output),
        .p11(p11), .p12(p12), .p13(p13), .p21(p21), .p22(p22), .p23(p23), .p31(p31), .p32(p32), .p33(p33)
    );
    
    initial clk=0;
    always #5 clk=~clk;
    integer i;
    initial begin
        rst_n=0;
        valid_input=0;
        pixel=0;

        #20;
        rst_n=1;
        valid_input=1;
        for(i=1; i<26;i=i+1)begin
            @(negedge clk);
            pixel = i;
        end
        #40
        $stop;
    end
    always@(negedge clk)begin
        if(valid_input)begin
            $display("TIME=%0t", $time);
            $display("%d\t%d\t%d", p11, p12, p13);
            $display("%d\t%d\t%d", p21, p22, p23);
            $display("%d\t%d\t%d", p31, p32, p33);
            $display("Valid? %d", valid_output);
        end
    end
endmodule