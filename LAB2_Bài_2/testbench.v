`timescale 1ns/1ps
module tb ();
	parameter width=2048;
	parameter high=1365;
	parameter Bright= -50;
	reg clk,rst_n;
	reg signed [8:0] bright;
	reg [32759:0] pixel_in;
	reg [23:0] Ram_input [0:2795519]; 
	reg [7:0] temp_ram [0:2795519];
	wire [10919:0] Grayscale_out;
	integer i,j,k,m;
	Main_lab2 #(.Bright(Bright))
	dut
	(
       .clk(clk),.rst_n(rst_n),.pixel_in(pixel_in),
       .Grayscale_out(Grayscale_out)
    );
	always begin
		#5 clk=~clk;
	end
	initial begin
		clk=0;
		$readmemh ("input.txt",Ram_input);
		rst_n=0; 
		#12;
		rst_n=1;
		for(i=0;i<2795520; i=i+1365) begin
		      @(negedge clk);
		      pixel_in=0;
		      for(j=0;j<1365;j=j+1) begin
			     pixel_in[24*j +: 24]=Ram_input[i+j];
			end
		end
	end
initial begin
    wait(rst_n == 1);
    repeat(5) @(negedge clk);
    for (m=0; m<2048*1365; m=m+1365) begin
        #1; 
        for(k=0; k<1365; k=k+1) begin
            temp_ram[m+k] = Grayscale_out[8*k +: 8];
        end
        @(negedge clk);
    end
    $writememh("output.txt", temp_ram);
    $stop; 
end
endmodule
