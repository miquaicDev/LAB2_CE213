module median3x3(a,b,c,d,e,f,g,h,i, median);
    input [7:0] a,b,c,d,e,f,g,h,i;
    output [7:0] median;

    wire[7:0]max1,max2,max3, max_1, max_2, max_3,
    mid1,mid2,mid3, mid_1, mid_2, mid_3,
    min1,min2,min3, min_1, min_2, min_3,
    max, min;

    cmp3num inst1(.a(a), .b(b), .c(c), .max(max1), .mid(mid1), .min(min1));
    cmp3num inst2(.a(d), .b(e), .c(f), .max(max2), .mid(mid2), .min(min2));
    cmp3num inst3(.a(g), .b(h), .c(i), .max(max3), .mid(mid3), .min(min3));
    cmp3num inst4(.a(max1), .b(max2), .c(max3), .max(max_1), .mid(mid_1), .min(min_1));
    cmp3num inst5(.a(mid1), .b(mid2), .c(mid3), .max(max_2), .mid(mid_2), .min(min_2));
    cmp3num inst6(.a(min1), .b(min2), .c(min3), .max(max_3), .mid(mid_3), .min(min_3));
    cmp3num inst7(.a(min_1), .b(mid_2), .c(max_3), .max(max), .mid(median), .min(min));

endmodule