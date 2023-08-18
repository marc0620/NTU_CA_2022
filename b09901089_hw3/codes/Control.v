module Control
(
    Op_i       ,
    ALUOp_o    ,
    ALUSrc_o   ,
    RegWrite_o 
);
integer outfile;

input [6:0] Op_i;
output [1:0] ALUOp_o;
output ALUSrc_o;
output RegWrite_o;
reg [1:0] ALUOp;
reg RegWrite, ALUSrc;
assign RegWrite_o=RegWrite;
assign ALUOp_o = ALUOp;
assign ALUSrc_o = ALUSrc;

always @ (Op_i) begin
    case (Op_i)
        7'b0110011: begin
            ALUOp=2'b10;
            ALUSrc=1'b0;
            RegWrite=1'b1;
        end
        7'b0010011: begin
            ALUOp=2'b00;
            ALUSrc=1'b1;
            RegWrite=1'b1;
        end
    endcase
    
end
endmodule