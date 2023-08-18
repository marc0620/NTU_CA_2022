//Done
module MUX2
(
    Forward_i, RSdata_i, ALUResult_i, WriteData_i, ALUParameter_o
);

input [31:0] RSdata_i,WriteData_i, ALUResult_i;
input [1:0] Forward_i;

output [31:0] ALUParameter_o;
reg [31:0] ALUParameter_r;
assign ALUParameter_o=ALUParameter_r;
always @ (*) begin
    case (Forward_i) 
        2'b00: ALUParameter_r=RSdata_i;
        2'b01: ALUParameter_r=WriteData_i;
        2'b10: ALUParameter_r=ALUResult_i;
    endcase
end
endmodule