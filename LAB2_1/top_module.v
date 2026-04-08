module top_module#(parameter IMG_W=430, IMG_H=554)(
    clk, rst_n, pixel_in, pixel_out, valid_input, valid_output
);
    input clk, rst_n, valid_input;
    input [7:0] pixel_in;
    output [7:0] pixel_out;
    output valid_output;
    
    wire [7:0]p11, p12, p13, p21, p22, p23, p31, p32, p33;
    wire valid_window;

    window3x3#(.IMG_W(IMG_W), .IMG_H(IMG_H))window(
        .clk(clk), .rst_n(rst_n), .pixel(pixel_in),
        .valid_input(valid_input), .valid_output(valid_window),
        .p11(p11), .p12(p12), .p13(p13), .p21(p21), .p22(p22),
        .p23(p23), .p31(p31), .p32(p32), .p33(p33)
    );
    median3x3 filter(
        .a(p11), .b(p12), .c(p13),
        .d(p21), .e(p22), .f(p23),
        .g(p31), .h(p32), .i(p33), .median(pixel_out));

    assign valid_output = valid_window;

endmodule