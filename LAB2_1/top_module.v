// zero padding
module top_module#(parameter IMG_W=430, IMG_H=554)(
    clk, rst_n, pixel_in, pixel_out, valid_input, valid_output
);
    input clk, rst_n, valid_input;
    input [7:0] pixel_in;
    output [7:0] pixel_out;
    output valid_output;
    
    wire [7:0]p11, p12, p13, p21, p22, p23, p31, p32, p33;
    wire [7:0] m11, m12, m13, m21, m22, m23, m31, m32, m33;
    wire valid_window;
    wire [9:0] x, y;

    window3x3#(.IMG_W(IMG_W), .IMG_H(IMG_H))window(
        .clk(clk), .rst_n(rst_n), .pixel(pixel_in),
        .valid_input(valid_input), .valid_output(valid_window),
        .p11(p11), .p12(p12), .p13(p13), .p21(p21), .p22(p22),
        .p23(p23), .p31(p31), .p32(p32), .p33(p33), .x(x), .y(y)
    );
    assign m11 = (x==0 || y==0) ? 0 : p11;
    assign m12 = (x==0) ? 0 : p12;
    assign m13 = (x==0 || y==IMG_W-1) ? 0 : p13;
    assign m21 = (y==0) ? 0 : p21;
    assign m22 = p22;
    assign m23 = (y==IMG_W-1) ? 0 : p23;
    assign m31 = (x==IMG_H-1 || y==0) ? 0 : p31;
    assign m32 = (x==IMG_H-1) ? 0 : p32;
    assign m33 = (x==IMG_H-1 || y==IMG_W-1) ? 0 : p33;

    median3x3_pipeline filter(
        .clk(clk), .rst_n(rst_n),
        .a(m11), .b(m12), .c(m13),
        .d(m21), .e(m22), .f(m23),
        .g(m31), .h(m32), .i(m33), 
        .median_out(pixel_out)
    );

    reg [2:0] valid_pipeline; // delay 3 clk median
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            valid_pipeline <= 3'b0000;
        else
            valid_pipeline <= {valid_pipeline[1:0], valid_window}; 
    end

    assign valid_output = valid_pipeline[2];

endmodule