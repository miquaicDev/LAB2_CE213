
module Main_lab2 (clk,rst_n,pixel_in,Grayscale_out);
parameter signed Bright=0;
parameter width=2048;
parameter height=1365;
input [32759:0] pixel_in;
input clk, rst_n;
output [10919:0] Grayscale_out;
genvar i;
generate 
    for (i=0; i<height; i=i+1) begin: rgb_grayscale
        RGB_to_Grayscale #(.Bright(Bright)) inst (.clk(clk),.rst_n(rst_n),
        .data_in(pixel_in[24*i +: 24]),.pixel_grayscale(Grayscale_out[8*i +: 8]));
    end
endgenerate 
endmodule
