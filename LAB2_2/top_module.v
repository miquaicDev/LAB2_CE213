module top_module(clk, rst_n, valid_in, col_in, BN, valid_out, col_out);
    input clk;
    input rst_n;
    input valid_in;
    input [1365*24-1:0] col_in;
    input signed [8:0] BN;
    output valid_out;
    output [1365*8-1:0] col_out;

    wire [1365*8-1:0] col_temp;
    genvar i;
    generate
        for(i = 0; i < 1365; i = i + 1) begin: pixel_loop
            wire [7:0] R_in = col_in[i*24+16 +: 8];
            wire [7:0] G_in = col_in[i*24+8 +: 8];
            wire [7:0] B_in = col_in[i*24+0  +: 8];            
            wire [7:0] Y_out_pixel;
            rgb2gray inst_n(
                .clk(clk),
                .rst_n(rst_n),
                .R(R_in),
                .G(G_in),
                .B(B_in),
                .BN(BN),
                .Y_out(Y_out_pixel)
            );
            assign col_temp[i*8+0 +: 8] = Y_out_pixel;
        end
    endgenerate

    reg [2:0] valid_pipeline;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            valid_pipeline <= 3'b0;
        else
            valid_pipeline <= {valid_pipeline[1:0], valid_in};
    end

    assign valid_out = valid_pipeline[2];
    assign col_out = valid_out ? col_temp : 0;

endmodule