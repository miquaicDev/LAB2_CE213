
module Main_lab2 (clk,rst_n,pixel,bright,out);
parameter width=2048;
parameter height=1365;
input [383:0] pixel;
input clk, rst_n;
input wire signed [8:0] bright;
output [127:0] out;
genvar i;
generate 
    for (i=0; i<16; i=i+1) begin: rgb_grayscale
        RGB inst (.clk(clk),.rst_n(rst_n),.data_in(pixel[24*i +: 24]),.Bright(bright),.Y(out[8*i +: 8]));
    end
endgenerate 
endmodule