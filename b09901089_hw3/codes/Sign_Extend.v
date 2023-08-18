module Sign_Extend
(
    data_i,
    data_o 
);

input [11:0] data_i;
output [31:0] data_o;
reg [31:0] data;
assign data_o= data;
always @ (*) begin
    if (data_i[11]==1'b1) begin
        data={{20{1'b1}}, data_i};
    end
    else begin
        data={{20{1'b0}}, data_i};
    end
end

endmodule