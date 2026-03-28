module median3x3(a,b,c,d,e,f,g,h,i, median);
    input [7:0]a,b,c,d,e,f,g,h,i;
    output [7:0]median;
    wire[7:0]max1,max2,max3, max_1, max_2, max_3,
    mid1,mid2,mid3, mid_1, mid_2, mid_3,
    min1,min2,min3, min_1, min_2, min_3,
    max, min;
    cmp3num inst1(a,b,c,max1,mid1,min1);
    cmp3num inst2(d,e,f,max2,mid2,min2);
    cmp3num inst3(g,h,i,max3,mid3,min3);

    cmp3num inst4(max1, max2, max3, max_1, mid_1, min_1);
    cmp3num inst5(mid1, mid2, mid3, max_2, mid_2, min_2);
    cmp3num inst6(min1, min2, min3, max_3, mid_3, min_3);

    cmp3num inst7(min_1, mid_2, max_3, max, median, min);

endmodule