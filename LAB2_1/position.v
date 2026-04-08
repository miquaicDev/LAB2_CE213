// Get the position (x,y) of pixels for p22
module position#(
    parameter IMG_W=430,
    parameter IMG_H=554)
(clk, rst_n, valid_in, x, y, valid_out);

    input clk, rst_n, valid_in;
    output reg [9:0]x,y;
    output valid_out;
    reg [8:0]delay; // delay W+1 for p22
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            x<=0;
            y<=0;
            delay<=0;
        end
        else if(valid_in)begin
            if(delay == IMG_W+1)begin
                if(y==IMG_W-1)begin
                    y<=0;
                    if(x==IMG_H-1)
                        x<=0;
                    else x<=x+1;
                end
                else y<=y+1;
            end
            else delay <= delay+1;
        end
    end
    assign valid_out = (delay==IMG_W+1)? valid_in : 0;

endmodule