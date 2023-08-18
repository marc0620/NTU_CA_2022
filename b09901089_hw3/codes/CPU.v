
module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;
wire [31:0] Inst, RS1data, RS2data, RDdata, PCValueOld,PCValueNew, Imm, ALUInput2;
wire [4:0] RS1addr, RS2addr, RDaddr;
wire [2:0] ALUCtrl;
wire [1:0] ALUOp;
wire RegWrite, ALUSrc,Zero;

assign RS1addr=Inst[19:15];
assign RS2addr=Inst[24:20];
assign RDaddr=Inst[11:7];

Control Control(
    .Op_i       (Inst[6:0]),
    .ALUOp_o    (ALUOp),
    .ALUSrc_o   (ALUSrc),
    .RegWrite_o (RegWrite)
);


Adder Add_PC(
    .data1_in   (PCValueOld),
    .data2_in   (32'h0004),
    .data_o     (PCValueNew)
);


PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (PCValueNew),
    .pc_o       (PCValueOld)
);


Instruction_Memory Instruction_Memory(
    .addr_i     (PCValueOld), 
    .instr_o    (Inst)
);

Registers Registers(
    .clk_i      (clk_i),
    .RS1addr_i   (RS1addr),
    .RS2addr_i   (RS2addr),
    .RDaddr_i   (RDaddr), 
    .RDdata_i   (RDdata),
    .RegWrite_i (RegWrite), 
    .RS1data_o   (RS1data), 
    .RS2data_o   (RS2data) 
);


MUX32 MUX_ALUSrc(
    .data1_i    (RS2data),
    .data2_i    (Imm),
    .select_i   (ALUSrc),
    .data_o     (ALUInput2)
);



Sign_Extend Sign_Extend(
    .data_i     (Inst[31:20]),
    .data_o     (Imm)
);

  

ALU ALU(
    .data1_i    (RS1data),
    .data2_i    (ALUInput2),
    .ALUCtrl_i  (ALUCtrl),
    .data_o     (RDdata),
    .Zero_o     (Zero)
);


ALU_Control ALU_Control(
    .funct_i    ({Inst[31:25],Inst[14:12]}),
    .ALUOp_i    (ALUOp),
    .ALUCtrl_o  (ALUCtrl)
);


endmodule

