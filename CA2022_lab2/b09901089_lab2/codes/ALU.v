//Done
`define AND 3'b000
`define XOR 3'b001
`define ADD 3'b010
`define SUB 3'b110
`define SLL 3'b111
`define MUL 3'b011
`define SRAI 3'b100


module ALU(data1_i, data2_i, ALUCtrl_i, data_o, Zero_o);
input signed [31:0] data1_i, data2_i;
input  [2:0]  ALUCtrl_i;
output signed [31:0] data_o;
output        Zero_o;

// TODO
reg Zero;
reg signed [31:0] data;
assign data_o=data;
assign Zero_o=Zero;

always @ (*) begin
    case(ALUCtrl_i)
        `AND:data=data1_i & data2_i;
        `XOR:data=data1_i ^ data2_i; 
        `ADD:data=data1_i + data2_i;
        `SUB:data=data1_i - data2_i;
        `SLL:data=data1_i << data2_i;
        `MUL:data=data1_i * data2_i;
        `SRAI:data=data1_i >>> data2_i[4:0];
    endcase

    if(ALUCtrl_i==`SUB && data==0) Zero=1'b1;
    else Zero=1'b0;
end
endmodule
