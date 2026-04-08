`timescale 1ns/1ps
module tb ();
	parameter width=2048;
	parameter high=1365;
	reg clk,rst_n;
	reg signed [8:0] bright;
	reg [383:0] pixel;
	reg [23:0] Ram_input [0:2795519]; 
	reg [7:0] temp_ram [0:2795519];
	wire [127:0] out;
	integer i,j,k;
	Main_lab2 dut (
       .clk(clk),.rst_n(rst_n),.pixel(pixel),.bright(bright),.out(out)
    );
	always begin
		#5 clk=~clk;
	end
	initial begin
		clk=0;
		$readmemh ("input.txt",Ram_input);
		bright=0;
		rst_n=0; 
		#15;
		rst_n=1;
		for(i=0;i<2795520; i=i+16) begin
		      pixel=0;
		      for(j=0;j<16;j=j+1) begin
			     pixel[24*j +: 24]=Ram_input[i+j];
			end
			repeat(4)@(posedge clk);
			#1;
			 for (k=0; k<16; k=k+1) begin
			     temp_ram[i+k]=out[8*k +: 8];
			 end
		end
		$writememh("output.txt",temp_ram);
		$stop;
	end
endmodule