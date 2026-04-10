// convert RGB px to grayscale px 3 stage pipeline
module rgb2gray(clk, rst_n, R, G, B, BN, Y_out);
    input clk, rst_n;
    input [7:0] R, G, B;
    input signed [8:0] BN;
    output reg [7:0]Y_out;

    reg [15:0] R_out, G_out, B_out;
    reg [7:0] Y;
    wire signed [9:0] Y_temp; //Y+BN
    reg signed [8:0] BN_1, BN_2;

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            R_out <= 0;
            G_out <= 0;
            B_out <= 0;
            BN_1 <= 0;
        end
        else begin
            R_out <= 77*R;
            G_out <= 150*G;
            B_out <= 29*B;
            BN_1 <= BN;
        end
    end

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            Y <= 0;
            BN_2 <= 0;
        end
        else begin
            Y <= (R_out + G_out + B_out) >> 8;
            BN_2 <= BN_1;
        end
    end

    assign Y_temp = $signed({1'b0, Y}) + BN_2;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            Y_out <= 0;
        end
        else begin
            if(Y_temp > 10'sd255)
                Y_out <= 8'd255;
            else if(Y_temp < 10'sd0)
                Y_out <= 8'd0;
            else
                Y_out <= Y_temp[7:0];
        end
    end

endmodule