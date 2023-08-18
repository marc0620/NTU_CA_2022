//Done

module AND
(
    data0_i,
    data1_i,
    data_o
);

input data0_i , data1_i;
output data_o;
assign data_o=(data0_i & data1_i);

endmodule