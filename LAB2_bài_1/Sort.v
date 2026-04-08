module sort3 (data_a,data_b,data_c,max,med,min);
input [7:0] data_a,data_b,data_c;
output [7:0] max,med,min;
wire [7:0] high1, high2, low1;
comparator inst0 (.data_a(data_a),.data_b(data_b),.max(high1),.min(low1));
comparator inst1 (.data_a(low1),.data_b(data_c),.max(high2),.min(min));
comparator inst2 (.data_a(high1),.data_b(high2),.max(max),.min(med));
endmodule

