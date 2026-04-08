module cmp3num(a, b, c, max, mid, min);
    input [7:0]a, b, c;
    output [7:0]max, mid,min;
    wire [7:0] low1, low2, high;

    cmp2num cmp1(.a(a), .b(b), .max(high), .min(low1));
    cmp2num cmp2(.a(high), .b(c), .max(max), .min(low2));
    cmp2num cmp3(.a(low1), .b(low2), .max(mid), .min(min));
endmodule