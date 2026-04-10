`timescale 1ns/1ps
module tb_rgb2gray();
    reg clk, rst_n;
    reg [7:0] R, G, B;
    reg signed [8:0] BN;
    wire [7:0] Y_out;

    rgb2gray dut(
        .clk(clk), .rst_n(rst_n),
        .R(R), .G(G), .B(B),
        .BN(BN), .Y_out(Y_out)
    );

    initial clk=0;
    always #5 clk=~clk;

    initial begin
        rst_n = 0;
        R = 0;
        G = 0;
        B = 0;
        BN = 0;
        repeat(2)@(negedge clk);
        rst_n = 1;
        @(negedge clk);
        R = 200;
        G = 50;
        B = 120;
        BN = 1;
        #40
        $display("Y = %02x", Y_out);
        $stop;
    end

endmodule