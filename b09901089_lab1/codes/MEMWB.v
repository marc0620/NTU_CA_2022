//Done
module MEMWB
(
    RegWrite_i,RegWrite_o,MemtoReg_i,MemtoReg_o,ALUResult_i,ALUResult_o,ReadData_i,ReadData_o,PRD_i,PRD_o,clk_i
);
input RegWrite_i,MemtoReg_i;
input [31:0] ALUResult_i,ReadData_i;
input[4:0] PRD_i;
input clk_i;

output RegWrite_o,MemtoReg_o;
output [31:0] ALUResult_o,ReadData_o;
output [4:0] PRD_o;

reg RegWrite_r,MemtoReg_r;
reg [31:0] ALUResult_r,ReadData_r;
reg [4:0] PRD_r;

assign RegWrite_o= RegWrite_r, MemtoReg_o=MemtoReg_r, ALUResult_o=ALUResult_r,ReadData_o=ReadData_r,PRD_o=PRD_r;

initial begin
    RegWrite_r=0;
    MemtoReg_r=0;
    ALUResult_r=0;
    ReadData_r=0;
    PRD_r=0;
end

always @ (posedge clk_i) begin
    MemtoReg_r<=MemtoReg_i;
    RegWrite_r<=RegWrite_i;
    ALUResult_r<=ALUResult_i;
    ReadData_r<=ReadData_i;
    PRD_r<=PRD_i;
end
endmodule