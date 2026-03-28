module cmp3num(a, b, c, max, mid, min);
    input [7:0]a, b, c;
    output [7:0]max, mid,min;
    wire [7:0] low1, low2, high;

    cmp2num cmp1(a, b, high, low1);
    cmp2num cmp2(high, c, max, low2);
    cmp2num cmp3(low1, low2, mid, min);
endmodule