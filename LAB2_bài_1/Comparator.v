module comparator (data_a, data_b, max,min);
input [7:0] data_a,data_b;
output [7:0] max,min;
assign min= (data_a<=data_b)?data_a:data_b;
assign max=(data_a>data_b)? data_a:data_b;
endmodule
