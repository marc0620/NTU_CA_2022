//done
module Comparator
(
    data0_i,
    data1_i,
    data_o
);

input [31:0] data0_i,data1_i;
output data_o;
assign data_o=(data0_i==data1_i)?1'b1:1'b0;

endmodule