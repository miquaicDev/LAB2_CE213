`timescale 1ns/1ps
module tb_topmodule();
    parameter IMG_W=430, IMG_H=554;
    reg clk, rst_n, valid_input;
    reg [7:0] pixel_in;
    wire [7:0] pixel_out;
    wire valid_output;

    top_module#(.IMG_W(IMG_W), .IMG_H(IMG_H)) inst1(
        .clk(clk), .rst_n(rst_n),
        .valid_input(valid_input),
        .pixel_in(pixel_in), .pixel_out(pixel_out),
        .valid_output(valid_output)
    );

    reg [7:0] mem [0:IMG_W*IMG_H-1];
    integer i;
    integer file_out;

    initial clk=0;
    always #5 clk=~clk;
    initial begin
        $readmemh("pic_input.txt", mem);
        file_out = $fopen("pic_output.txt", "w");
        rst_n = 0;
        valid_input=0;
        pixel_in=0;
        #20;
        rst_n=1;
        #10;
        valid_input=1;
        for(i=0; i<IMG_W*IMG_H; i=i+1)begin
            @(negedge clk);
            pixel_in = mem[i];
        end
        @(negedge clk);
        valid_input=0;
        #500;
        $fclose(file_out);
        $display("DONE");
        $stop;
    end
    always@(posedge clk)begin
        if(valid_output)begin
            $fdisplay(file_out, "%02x", pixel_out);
        end
    end
endmodule