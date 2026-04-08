module sort9 (in1,in2,in3,in4,in5,in6,in7,in8,in9,done_buffer,med_final);
input [7:0] in1,in2,in3,in4,in5,in6,in7,in8,in9;
input done_buffer;
output [7:0] med_final;
wire [7:0] med;
wire [7:0] max0,min0,med0, max1,min1,med1,max2,min2,med2;
wire [7:0] max3,min3,med3,max4,min4,med4,max5,min5,med5;
sort3 inst0(.data_a(in1),.data_b(in2),.data_c(in3),.max(max0),.med(med0),.min(min0));
sort3 inst1(.data_a(in4),.data_b(in5),.data_c(in6),.max(max1),.med(med1),.min(min1));
sort3 inst2(.data_a(in7),.data_b(in8),.data_c(in9),.max(max2),.med(med2),.min(min2));

sort3 inst3(.data_a(min0),.data_b(min1),.data_c(min2),.max(max3),.med(med3),.min(min3));
sort3 inst4 (.data_a(max0),.data_b(max1),.data_c(max2),.max(max4),.med(med4),.min(min4));
sort3 inst5 (.data_a(med0),.data_b(med1),.data_c(med2),.max(max5),.med(med5),.min(min5));
sort3 final (.data_a(max3),.data_b(med5),.data_c(min4),.max(),.med(med),.min());
assign med_final=(done_buffer==1'b1)? med: 8'h00;
endmodule
