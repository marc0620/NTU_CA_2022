//Done
`define AND 3'b000
`define XOR 3'b001
`define ADD 3'b010
`define SUB 3'b110
`define SLL 3'b111
`define MUL 3'b011
`define SRAI 3'b100
module ALU_Control
(
    Funct_i,
    ALUOp_i,
    ALUCtrl_o
);
input [9:0] Funct_i;
input [1:0] ALUOp_i;
output [2:0] ALUCtrl_o;
reg [2:0] ALUCtrl;
assign ALUCtrl_o=ALUCtrl;
always@(Funct_i or ALUOp_i) begin
    if(ALUOp_i==2'b00 ) begin
        case(Funct_i)
            10'b0100000101:ALUCtrl=`SRAI;
            //default: lw, beq, sw
            default: ALUCtrl=`ADD;
        endcase
    end
    else if (ALUOp_i==2'b01) begin
        ALUCtrl=`SUB;
    end
    else begin
        case (Funct_i)
            10'b0000000111:ALUCtrl=`AND;
            10'b0000000100:ALUCtrl=`XOR;
            10'b0000000001:ALUCtrl=`SLL;
            10'b0000000000:ALUCtrl=`ADD;
            10'b0100000000:ALUCtrl=`SUB;
            10'b0000001000:ALUCtrl=`MUL;
        endcase
    end
end

endmodule



