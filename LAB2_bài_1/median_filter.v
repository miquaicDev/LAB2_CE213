
module median_filter_3x3 (clk,i_data_valid,rst_n,data_in,med,done);
input [7:0] data_in;
input clk,rst_n;
input i_data_valid;
output done;
wire [23:0] data_out1,data_out2,data_out3;
output [7:0] med;
window_3x3 inst0 (.iclock(clk),.i_data_valid(i_data_valid),.i_data(data_in),.rst_n(rst_n),.data_out_1(data_out1),.data_out_2(data_out2),.data_out_3(data_out3),.done(done));
sort9 inst1 (.in1(data_out1[23:16]),.in2(data_out1[15:8]),.in3(data_out1[7:0]),.in4(data_out2[23:16]),.in5(data_out2[15:8]),.in6(data_out2[7:0]),.in7(data_out3[23:16]),.in8(data_out3[15:8]),.in9(data_out3[7:0]),.done_buffer(done),.med_final(med));
endmodule

