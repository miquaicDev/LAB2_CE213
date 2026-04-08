module median3x3_pipeline(clk, rst_n, a,b,c,d,e,f,g,h,i, median_out);
    input clk, rst_n;
    input [7:0] a,b,c,d,e,f,g,h,i;
    output reg [7:0] median_out;

    wire[7:0]max1,max2,max3, max_1, max_2, max_3,
    mid1,mid2,mid3, mid_1, mid_2, mid_3,
    min1,min2,min3, min_1, min_2, min_3,
    max, min, median;
    //stage 1:
    reg[7:0] s1_max1, s1_mid1, s1_min1,
    s1_max2, s1_mid2, s1_min2,
    s1_max3, s1_mid3, s1_min3;
    //stage 2:
    reg[7:0] s2_max_1, s2_max_2, s2_max_3,
    s2_mid_1, s2_mid_2, s2_mid_3,
    s2_min_1, s2_min_2, s2_min_3;

    cmp3num inst1(.a(a), .b(b), .c(c), .max(max1), .mid(mid1), .min(min1));
    cmp3num inst2(.a(d), .b(e), .c(f), .max(max2), .mid(mid2), .min(min2));
    cmp3num inst3(.a(g), .b(h), .c(i), .max(max3), .mid(mid3), .min(min3));
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n) begin
            {s1_max1, s1_mid1, s1_min1,
            s1_max2, s1_mid2, s1_min2,
            s1_max3, s1_mid3, s1_min3} <= 0;
        end
        else begin
            {s1_max1, s1_mid1, s1_min1,
            s1_max2, s1_mid2, s1_min2,
            s1_max3, s1_mid3, s1_min3} <= {
                max1, mid1, min1,
                max2, mid2, min2,
                max3, mid3, min3
            };
        end
    end

    cmp3num inst4(.a(s1_max1), .b(s1_max2), .c(s1_max3), .max(max_1), .mid(mid_1), .min(min_1));
    cmp3num inst5(.a(s1_mid1), .b(s1_mid2), .c(s1_mid3), .max(max_2), .mid(mid_2), .min(min_2));
    cmp3num inst6(.a(s1_min1), .b(s1_min2), .c(s1_min3), .max(max_3), .mid(mid_3), .min(min_3));
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n) begin
            {s2_max_1, s2_max_2, s2_max_3,
            s2_mid_1, s2_mid_2, s2_mid_3,
            s2_min_1, s2_min_2, s2_min_3} <= 0;
        end
        else begin
            {s2_max_1, s2_max_2, s2_max_3,
            s2_mid_1, s2_mid_2, s2_mid_3,
            s2_min_1, s2_min_2, s2_min_3} <= {
                max_1, max_2, max_3,
                mid_1, mid_2, mid_3,
                min_1, min_2, min_3
            };
        end
    end

    cmp3num inst7(.a(s2_min_1), .b(s2_mid_2), .c(s2_max_3), .max(max), .mid(median), .min(min));
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            median_out <= 0;
        end
        else begin
            median_out <= median;
        end
    end
endmodule