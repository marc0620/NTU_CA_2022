//Done
module MUX1
(
    ctrl_i,
    data0_i,
    data1_i,
    data_o
);

input [31:0] data0_i,data1_i;
input ctrl_i;
output [31:0] data_o;

reg [31:0]data_r;
assign data_o=data_r;
always @ (*) begin
    data_r=(ctrl_i ? data1_i:data0_i);
end
endmodule
