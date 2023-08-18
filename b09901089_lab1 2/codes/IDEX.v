//Done
module IDEX
(
    //WriteReg for data to write register, RegWrite for RegWrite signal; PRS1,2 are Instruction[19:15] 
    //and Instruction[24:20],PRDf is for instruction[11-7]
    RS1data_i, RS2data_i, Imm_i, Funct_i, RegWrite_i, MemtoReg_i, MemRead_i, MemWrite_i, ALUOp_i,
    ALUSrc_i,PRS1_i, PRS2_i, PRD_i,clk_i,

    RS1data_o, RS2data_o, Imm_o, Funct_o, RegWrite_o, MemtoReg_o, MemRead_o, MemWrite_o,
    ALUOp_o, ALUSrc_o, PRS1_o, PRS2_o, PRD_o
);
input [31:0] RS1data_i, RS2data_i, Imm_i;
input RegWrite_i, MemtoReg_i, MemRead_i, MemWrite_i, ALUSrc_i, clk_i;
input [1:0] ALUOp_i;
input [4:0] PRS1_i,PRS2_i,PRD_i;
input [9:0] Funct_i;

output [31:0] RS1data_o, RS2data_o, Imm_o;
output RegWrite_o, MemtoReg_o, MemRead_o, MemWrite_o, ALUSrc_o;
output [1:0] ALUOp_o;
output [4:0] PRS1_o,PRS2_o,PRD_o;
output [9:0] Funct_o;

reg [31:0] RS1data_r, RS2data_r, Imm_r;
reg RegWrite_r, MemtoReg_r, MemRead_r, MemWrite_r, ALUSrc_r;
reg [1:0] ALUOp_r;
reg [4:0] PRS1_r, PRS2_r, PRD_r;
reg [9:0] Funct_r;
initial begin
    RS1data_r=0;
    RS2data_r=0;
    Imm_r=0;
    RegWrite_r=0;
    MemtoReg_r=0;
    MemRead_r=0;
    MemWrite_r=0;
    ALUSrc_r=0;
    ALUOp_r=0;
    PRS1_r=0;
    PRS2_r=0;
    PRD_r=0;
    Funct_r=0;
end

assign RS1data_o = RS1data_r, RS2data_o = RS2data_r, Imm_o=Imm_r, RegWrite_o=RegWrite_r,MemtoReg_o=MemtoReg_r,MemRead_o=MemRead_r, MemWrite_o=MemWrite_r,ALUSrc_o=ALUSrc_r,ALUOp_o=ALUOp_r,PRS1_o=PRS1_r,PRS2_o=PRS2_r,PRD_o=PRD_r,Funct_o=Funct_r;

always @ (posedge clk_i) begin
    RS1data_r<=RS1data_i;
    RS2data_r<=RS2data_i;
    Imm_r<=Imm_i;
    RegWrite_r<=RegWrite_i;
    MemtoReg_r<=MemtoReg_i;
    MemRead_r<=MemRead_i;
    MemWrite_r<=MemWrite_i;
    ALUSrc_r<=ALUSrc_i;
    ALUOp_r<=ALUOp_i;
    PRS1_r<=PRS1_i;
    PRS2_r<=PRS2_i;
    PRD_r<=PRD_i;
    Funct_r<=Funct_i;

end

endmodule