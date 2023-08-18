//Done
module EXMEM
(
    RegWrite_i,RegWrite_o,MemtoReg_i,MemtoReg_o,MemRead_i,MemRead_o,MemWrite_i,MemWrite_o,ALUResult_i,ALUResult_o,WriteData_i,WriteData_o,WriteReg_i,WriteReg_o,clk_i
);
input RegWrite_i,MemtoReg_i,MemRead_i,MemWrite_i;
input [31:0] ALUResult_i,WriteData_i;
input [4:0] WriteReg_i;
input clk_i;
output RegWrite_o,MemtoReg_o,MemRead_o,MemWrite_o;
output [31:0] ALUResult_o,WriteData_o;
output [4:0] WriteReg_o;

reg RegWrite_r,MemtoReg_r,MemRead_r,MemWrite_r;
reg [31:0] ALUResult_r,WriteData_r;
reg [4:0] WriteReg_r;

assign RegWrite_o=RegWrite_r, MemtoReg_o= MemtoReg_r,MemRead_o=MemRead_r,MemWrite_o=MemWrite_r,ALUResult_o=ALUResult_r,WriteData_o=WriteData_r,WriteReg_o=WriteReg_r;

initial begin
    RegWrite_r=0;
    MemtoReg_r=0;
    MemRead_r=0;
    MemWrite_r=0;
    ALUResult_r=0;
    WriteData_r=0;
    WriteReg_r=0;
end

always @ (posedge clk_i) begin
    RegWrite_r<=RegWrite_i;
    MemtoReg_r<=MemtoReg_i;
    MemRead_r<=MemRead_i;
    MemWrite_r<=MemWrite_i;
    ALUResult_r<=ALUResult_i;
    WriteData_r<=WriteData_i;
    WriteReg_r<=WriteReg_i;
end

endmodule