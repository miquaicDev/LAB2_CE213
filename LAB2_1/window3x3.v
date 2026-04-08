// reset asynchronous active low
// use concatenation for lineBuffer
module window3x3#(parameter IMG_W=430, IMG_H=554)(
    clk, rst_n, pixel, valid_input, valid_output,
    p11, p12, p13, p21, p22, p23, p31, p32, p33, x, y
);
    input clk, rst_n, valid_input;
    input [7:0]pixel;
    output reg [7:0]p11, p12, p13, p21, p22, p23, p31, p32, p33;
    output reg valid_output;
    output [9:0]x, y;

    wire valid_out_pos;
    reg [(8*IMG_W)-1:0] lineBuffer1, lineBuffer2;

    position#(.IMG_W(IMG_W), .IMG_H(IMG_H))pos(
        .clk(clk), .rst_n(rst_n), .valid_in(valid_input),
        .x(x), .y(y), .valid_out(valid_out_pos)
    );

    // lineBuffer
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            lineBuffer1 <= 0;
            lineBuffer2 <= 0;
        end
        else if(valid_input) begin
            lineBuffer1 <= {pixel,lineBuffer1[8*(IMG_W)-1:8]};
            lineBuffer2 <= {lineBuffer1[7:0],lineBuffer2[8*(IMG_W)-1:8]};
        end
    end

    wire [7:0]r2 = lineBuffer1[7:0];
    wire [7:0]r1 = lineBuffer2[7:0];

    //window
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            {p11, p12, p13, p21, p22, p23, p31, p32, p33} <= 0;
            valid_output <= 1'b0;
        end
        else if(valid_input)begin
            p33<=pixel; p32<=p33; p31<=p32;
            p23<=r2; p22<=p23; p21<=p22;
            p13<=r1; p12<=p13; p11<=p12;
            valid_output <= valid_out_pos;
        end
        else valid_output<=1'b0;
    end

endmodule