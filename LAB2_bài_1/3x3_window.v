module window_3x3 (iclock, i_data,rst_n, i_data_valid, data_out_1,data_out_2,data_out_3,done);
parameter width=430;
parameter height=554;
input iclock,i_data_valid,rst_n;
input [7:0] i_data;
output [23:0] data_out_1,data_out_2,data_out_3;
output reg done;
reg [7:0] line0 [0:width-1];
reg [7:0] line1 [0:width-1];
reg [7:0] line2 [0:width-1];
reg [7:0] line3 [0:width-1];
reg [8:0] write_pointer;
reg [8:0] read_pointer;
wire [8:0] p_left, p_right;
wire [23:0] raw_line0,raw_line1,raw_line2,raw_line3;
reg [23:0] top,mid,bot;
reg [9:0] counter;
reg [1:0] line_select;
always @(posedge iclock ) begin
if (i_data_valid) begin
    case (line_select)
        2'b00: line0[write_pointer]<=i_data;
        2'b01: line1[write_pointer]<=i_data;
        2'b10: line2[write_pointer]<=i_data;
        2'b11: line3[write_pointer]<=i_data;
    endcase
    end
end
always @(posedge iclock or negedge rst_n) begin
    if(!rst_n) begin
        write_pointer<=0;
        counter<=0;
        line_select<=0;
        done<=0;
    end
    else begin
        if(i_data_valid) begin
            if(write_pointer!=width-1) begin
            write_pointer<=write_pointer+1;
            end
            else begin
                write_pointer<=0;
                line_select<=line_select+1;
                if (line_select == 1 && done == 0) begin
                    done <= 1;
                end
                if(done) begin
                    counter<=counter+1;
                end
            end
        end
    end
end
always @ (posedge iclock or negedge rst_n) begin
    if(!rst_n) begin
        read_pointer<=0;
    end
    else
        begin
        if(i_data_valid) begin
            if(read_pointer!=width-1) 
                read_pointer<=read_pointer+1;
            else read_pointer<=0;
        end
        end
end
always @(*) begin
 case (line_select)
 2'b00: begin
    top=raw_line1;
    mid=raw_line2;
    bot=raw_line3;
 end
 2'b01: begin
    top=raw_line2;
    mid=raw_line3;
    bot=raw_line0;
 end
 2'b10: begin
    top=raw_line3;
    mid=raw_line0;
    bot=raw_line1;
end
 2'b11: begin
    top=raw_line0;
    mid=raw_line1;
    bot=raw_line2;
end
endcase
end
assign p_left=(read_pointer==0) ?9'h00: (read_pointer-1);
assign p_right=(read_pointer==width-1) ?(width-1): (read_pointer+1);
assign raw_line0 = (read_pointer==0) ? {8'h00, line0[read_pointer], line0[p_right]} : ((read_pointer==width-1) ? {line0[p_left], line0[read_pointer], 8'h00} : {line0[p_left], line0[read_pointer], line0[p_right]});
assign raw_line1 = (read_pointer==0) ? {8'h00, line1[read_pointer], line1[p_right]} : ((read_pointer==width-1) ? {line1[p_left], line1[read_pointer], 8'h00} : {line1[p_left], line1[read_pointer], line1[p_right]});
assign raw_line2 = (read_pointer==0) ? {8'h00, line2[read_pointer], line2[p_right]} : ((read_pointer==width-1) ? {line2[p_left], line2[read_pointer], 8'h00} : {line2[p_left], line2[read_pointer], line2[p_right]});
assign raw_line3 = (read_pointer==0) ? {8'h00, line3[read_pointer], line3[p_right]} : ((read_pointer==width-1) ? {line3[p_left], line3[read_pointer], 8'h00} : {line3[p_left], line3[read_pointer], line3[p_right]});

assign data_out_1= (counter==0)? 24'h000000:top;
assign data_out_2= mid;
assign data_out_3=(counter>=height-2)?24'h000000:bot;
endmodule

