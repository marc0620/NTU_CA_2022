module Sign_Extend
(
    data_i,
    data_o 
);

input [31:0] data_i;
output [31:0] data_o;
reg [31:0] data;
assign data_o= data;
reg [11:0] Imm12;
wire [9:0] funct;
assign funct ={data_i[14:12],data_i[6:0]};
always @ (*) begin
    if(funct==10'b0100000011 || funct==10'b0000010011) begin
        Imm12=data_i[31:20];
    end
    else if (funct==10'b0100100011) begin
        Imm12={data_i[31:25],data_i[11:7]};
    end
    else if (funct==10'b1010010011) begin
        Imm12={7'b0000000,data_i[24:20]};
    end
    else begin
        Imm12={data_i[31],data_i[7],data_i[30:25],data_i[11:8]};
    end

    if (Imm12[11]==1'b1) begin
        data={{20{1'b1}}, Imm12};
    end
    else begin
        data={{20{1'b0}}, Imm12};
    end
end

endmodule