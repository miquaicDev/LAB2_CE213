// Get the position (x,y) of pixels
module position#(
    parameter IMG_W=430,
    parameter IMG_H=554)
(clk, rst_n, valid_in, x, y, valid_out);

    input clk, rst_n, valid_in;
    output reg [9:0]x,y;
    output valid_out;

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            x<=0;
            y<=0;
        end
        else if(valid_in)begin
            if(y==IMG_W-1)begin
                y<=0;
                if(x==IMG_H-1)
                    x<=0;
                else x<=x+1;
            end
            else y<=y+1;
        end
    end
    assign valid_out = (x>=2) && (y>=2);

endmodule