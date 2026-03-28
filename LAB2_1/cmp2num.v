module cmp2num(a, b, max, min);
  input [7:0] a, b;
  output [7:0] max, min;
  assign max = (a>b)? a:b;
  assign min = (a<b)? a:b;
endmodule