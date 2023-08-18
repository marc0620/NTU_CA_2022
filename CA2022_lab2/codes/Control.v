//Done
module Control
(
    Op_i       ,
    ALUOp_o    ,
    ALUSrc_o   ,
    RegWrite_o ,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    Branch_o,
    NoOp_i,

);

input [6:0] Op_i;
input NoOp_i;
output [1:0] ALUOp_o;
output ALUSrc_o,RegWrite_o,MemtoReg_o ,MemRead_o,MemWrite_o,Branch_o;
reg [1:0] ALUOp;
reg RegWrite, ALUSrc, MemtoReg, MemRead, MemWrite,Branch;

assign RegWrite_o = RegWrite;
assign ALUOp_o = ALUOp;
assign ALUSrc_o = ALUSrc;
assign MemtoReg_o = MemtoReg, MemRead_o=MemRead, MemWrite_o=MemWrite,Branch_o=Branch;
initial begin
            ALUOp=1'b0;
            ALUSrc=1'b0;
            RegWrite=0;
            MemtoReg=0;
            MemRead=0;
            MemWrite=0;
            Branch=0;
end

always @ (*) begin
    if(NoOp_i) begin
            ALUOp=1'b0;
            ALUSrc=1'b0;
            RegWrite=0;
            MemtoReg=0;
            MemRead=0;
            MemWrite=0;
            Branch=0;
    end
    else begin
        case (Op_i)
            //R-type
            7'b0110011: begin
                ALUOp=2'b10;
                ALUSrc=1'b0;
                RegWrite=1'b1;
                MemtoReg=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                Branch=1'b0;
            end
            //srai
            7'b0010011: begin
                ALUOp=2'b00;
                ALUSrc=1'b1;
                RegWrite=1'b1;
                MemtoReg=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                Branch=1'b0;
            end
            //load word
            7'b0000011: begin
                ALUOp=2'b00;
                ALUSrc=1'b1;
                RegWrite=1'b1;
                MemtoReg=1'b1;
                MemRead=1'b1;
                MemWrite=1'b0;
                Branch=1'b0;

            end
            //store word
            7'b0100011: begin
                ALUOp=2'b00;
                ALUSrc=1'b1;
                RegWrite=1'b0;
                MemtoReg=1'b0;
                MemRead=1'b0;
                MemWrite=1'b1;
                Branch=1'b0;
            end
            //beq
            7'b1100011: begin
                ALUOp=2'b01;
                ALUSrc=1'b0;
                RegWrite=1'b0;
                MemtoReg=1'b0;
                MemRead=1'b0;
                MemWrite=1'b0;
                Branch=1'b1;
            end
            default: begin
                ALUOp=0;
                ALUSrc=0;
                RegWrite=0;
                MemtoReg=0;
                MemRead=0;
                MemWrite=0;
                Branch=0;
            end
        endcase
    end
end
endmodule