module windowGen#(parameter IMG_WIDTH=430)
(clk, rst_n, pixel, valid_in, valid_out, p11, p12, p13, p21, p22, p23, p31, p32, p33);
    input clk, rst_n, valid_in;
    input [7:0] pixel;
    output reg [7:0] p11, p12, p13, p21, p22, p23, p31, p32, p33; //3X3 WINDOW
    output reg valid_out;

    reg [7:0]lineBuffer1[0:IMG_WIDTH-1];
    reg [7:0]lineBuffer2[0:IMG_WIDTH-1];
    integer i;

    // buffer
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            for(i=0; i<IMG_WIDTH; i=i+1)begin
                lineBuffer1[i] <= 0;
                lineBuffer2[i] <= 0;
            end
        end
        else if(valid_in)begin
            lineBuffer1[0] <= pixel;
            for(i=0; i<IMG_WIDTH-1; i=i+1)begin
                lineBuffer1[i+1] <= lineBuffer1[i];
            end
            lineBuffer2[0] <= lineBuffer1[IMG_WIDTH-1];
            for(i=0; i<IMG_WIDTH-1; i=i+1)begin
                lineBuffer2[i+1] <= lineBuffer2[i];
            end
        end
    end

    //window
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            p11 <= 0; p12 <= 0; p13 <= 0;
            p21 <= 0; p22 <= 0; p23 <= 0;
            p31 <= 0; p32 <= 0; p33 <= 0;
            valid_out <= 1'b0;
        end
        else if(valid_in)begin
            p33 <= pixel;
            p23 <= lineBuffer1[IMG_WIDTH-1];
            p13 <= lineBuffer2[IMG_WIDTH-1];
            p32 <= p33; p31 <= p32;
            p22 <= p23; p21 <= p22;
            p12 <= p13; p11 <= p12;
            valid_out <= 1'b1;
        end
        else
            valid_out <= 1'b0;

    end
endmodule