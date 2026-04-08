module RGB (clk,rst_n,data_in,Bright, Y);

input wire signed [8:0] Bright;
input [23:0] data_in;
input clk,rst_n;

wire [7:0] data_in_R = data_in[23:16];
wire [7:0] data_in_G = data_in[15:8];
wire [7:0] data_in_B = data_in[7:0];

output reg [7:0] Y;

reg [10:0] R_out;
reg [11:0] G_out;
reg [8:0]  B_out;

reg signed [12:0] state_1;
reg signed [9:0]  state_2;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        R_out   <= 0;
        G_out   <= 0;
        B_out   <= 0;
    end else begin
        R_out   <= (data_in_R << 2) + data_in_R;
        G_out   <= (data_in_G << 3) + data_in_G;
        B_out   <= (data_in_B << 1);
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        state_1 <= 0;
    else
        state_1 <= R_out + B_out + G_out;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        state_2 <= 0;
    else
        state_2 <= $signed(state_1 >> 4) + Bright;
end
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        Y <= 0;
    else begin
        if(state_2 > 10'sd255)
            Y <= 8'd255;
        else if(state_2 < 10'sd0)
            Y <= 8'd0;
        else
            Y <= state_2[7:0];
    end
end
endmodule