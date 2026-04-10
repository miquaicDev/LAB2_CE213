`timescale 1ns/1ps
module tb_topmodule();
    reg clk;
    reg rst_n;
    reg valid_in;
    reg [1365*24-1:0] col_in;
    reg signed [8:0] BN;
    wire valid_out;
    wire [1365*8-1:0] col_out;

    top_module dut(clk, rst_n, valid_in, col_in, BN, valid_out, col_out);

    initial clk=0;
    always #5 clk=~clk;
    reg [23:0] mem [0:2795520-1];
    integer i, j, k;

    initial begin
        $readmemh("image_data.hex", mem);
        BN = 9'sd0;
        col_in = 0;
        rst_n = 0;
        valid_in = 0;
        #20
        rst_n=1;
        #10
        valid_in = 1;
        for(i=0; i<2048; i=i+1)begin
            @(negedge clk);
            for(j=0; j<1365; j=j+1)begin
                col_in[j*24+0 +: 24] <= mem[i*1365+j];
            end
        end
        // flush
        for(i=0; i<3; i=i+1)begin
            @(negedge clk);
            valid_in <= 0;
            col_in <= 0;
        end 
    end
    
    integer col_count = 0;
    reg [7:0] out_mem [0:2795520-1];
    always @(posedge clk) begin
        if(valid_out) begin
            for(k=0; k<1365; k=k+1)begin
                out_mem[1365*col_count + k] = col_out[8*k+0 +: 8];
            end
            col_count = col_count + 1;
                if(col_count == 2048) begin
                    $display("XONG! Dang ghi ra file hex...");
                    $writememh("bitmap_output.hex", out_mem);
                    $display("DONE!");
                    $stop;
                end
        end
    end

endmodule