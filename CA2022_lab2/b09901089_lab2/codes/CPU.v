module CPU
(
    clk_i,
    rst_i,
    start_i
);
input clk_i,rst_i,start_i;
wire [31:0] PCValueNew,PCValueOld,PCAM,IFInst,IDInst,IDPC,IDRS1data,IDRS2data,IDImm,EXImm,EXRS1data,EXRS2data,MEMALUResult,EXALUResult,ALUParameter1,ALUParameter2,WBWriteData,ALUParameter3,DMWriteData,MEMReadData,WBWriteData0,WBWriteData1,BranchPC,EXPC,EXBranchPC,PCRight,PCValueNewNew;

wire [9:0] EXFucnt;
wire Stall,Zero,IDRegWrite,EXRegWrite,MEMRegWrite,WBRegWrite,IDMemtoReg,EXMemtoReg,MEMMemtoReg,WBMemtoReg,IDMemRead,EXMemRead,MEMMemRead,IDMemWrite,EXMemWrite,MEMMemWrite,IDALUSrc,EXALUSrc,Branch,PCWrite,NoOp,PredFlush,result,prediction,EXBranch,PCMUXCtrl,Flush;
wire [1:0] IDALUOp,EXALUOp,ForwardA,ForwardB;
wire [4:0] IDRS1addr,EXRS1addr,EXRS2addr,IDRS2addr,IDRDaddr,WBRDaddr,EXRDaddr,MEMRDaddr;
wire [2:0] EXALUCtrl;
assign IDRS1addr=IDInst[19:15],IDRS2addr=IDInst[24:20],IDRDaddr=IDInst[11:7];

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .pc_i       (PCValueNewNew),
    .pc_o       (PCValueOld),
    .PCWrite_i  (PCWrite)
);
MUX1 PCMUX(
    .ctrl_i     (PCMUXCtrl),
    .data0_i    (PCAM),
    .data1_i    (BranchPC),
    .data_o     (PCValueNew)
);

Adder Add_PC(
    .data1_in   (32'h0004),
    .data2_in   (PCValueOld),
    .data_o     (PCAM)
);
Instruction_Memory Instruction_Memory(
    .addr_i     (PCValueOld),
    .instr_o    (IFInst)
);
IF_ID IF_ID(
    .inst_i     (IFInst),
    .PC_i       (PCValueOld),
    .clk_i      (clk_i),
    .stall_i    (Stall),
    .flush_i    (Flush),
    .inst_o     (IDInst),
    .PC_o       (IDPC),
    .rst_i      (rst_i)
);
assign Flush=PredFlush||PCMUXCtrl;
Registers Registers(
    .clk_i      (clk_i),
    .RS1addr_i  (IDRS1addr),
    .RS2addr_i  (IDRS2addr),
    .RDaddr_i   (WBRDaddr),
    .RDdata_i   (WBWriteData),
    .RegWrite_i (WBRegWrite),
    .RS1data_o  (IDRS1data),
    .RS2data_o  (IDRS2data)
);

Control Control(
    .Op_i        (IDInst[6:0]),
    .ALUOp_o     (IDALUOp),
    .ALUSrc_o    (IDALUSrc),
    .RegWrite_o  (IDRegWrite),
    .MemtoReg_o  (IDMemtoReg),
    .MemRead_o   (IDMemRead),
    .MemWrite_o  (IDMemWrite),
    .Branch_o    (Branch),
    .NoOp_i      (NoOp)
);

IDEX ID_EX(
    .RS1data_i   (IDRS1data),
    .RS2data_i   (IDRS2data),
    .Imm_i       (IDImm),
    .Funct_i     ({IDInst[31:25],IDInst[14:12]}),
    .RegWrite_i  (IDRegWrite),
    .MemtoReg_i  (IDMemtoReg),
    .MemRead_i   (IDMemRead),
    .MemWrite_i  (IDMemWrite),
    .ALUOp_i     (IDALUOp),
    .ALUSrc_i    (IDALUSrc),
    .PRS1_i      (IDRS1addr),
    .PRS2_i      (IDRS2addr),
    .PRD_i       (IDRDaddr),
    .clk_i       (clk_i),
    .RS1data_o   (EXRS1data),
    .RS2data_o   (EXRS2data),
    .Imm_o       (EXImm),
    .Funct_o     (EXFucnt),
    .RegWrite_o  (EXRegWrite),
    .MemtoReg_o  (EXMemtoReg),
    .MemRead_o   (EXMemRead),
    .MemWrite_o  (EXMemWrite),
    .ALUOp_o     (EXALUOp),
    .ALUSrc_o    (EXALUSrc),
    .PRS1_o      (EXRS1addr),
    .PRS2_o      (EXRS2addr),
    .PRD_o       (EXRDaddr),
    .pc_i        (IDPC),
    .pc_o        (EXPC),
    .Branch_i    (Branch),
    .Branch_o    (EXBranch),
    .BranchPC_i  (BranchPC),
    .BranchPC_o  (EXBranchPC),

    .flush_i     (PredFlush)


);

MUX2 MUX2A(
    .Forward_i   (ForwardA),
    .RSdata_i    (EXRS1data),
    .ALUResult_i (MEMALUResult),
    .WriteData_i (WBWriteData),
    .ALUParameter_o (ALUParameter1)
);

MUX2 MUX2B(
    .Forward_i   (ForwardB),
    .RSdata_i    (EXRS2data),
    .ALUResult_i (MEMALUResult),
    .WriteData_i (WBWriteData),
    .ALUParameter_o (ALUParameter2)
);

MUX1 EXMUX(
    .ctrl_i      (EXALUSrc),
    .data0_i     (ALUParameter2),
    .data1_i     (EXImm),
    .data_o      (ALUParameter3)
);

ALU_Control ALU_Control(
    .Funct_i     (EXFucnt),
    .ALUOp_i     (EXALUOp),
    .ALUCtrl_o   (EXALUCtrl)
);

ALU ALU(
    .data1_i     (ALUParameter1),
    .data2_i     (ALUParameter3),
    .ALUCtrl_i   (EXALUCtrl),
    .data_o      (EXALUResult),
    .Zero_o      (Zero)
);

EXMEM EXMEM(
    .RegWrite_i  (EXRegWrite),
    .RegWrite_o  (MEMRegWrite),
    .MemtoReg_i  (EXMemtoReg),
    .MemtoReg_o  (MEMMemtoReg),
    .MemRead_i   (EXMemRead),
    .MemRead_o   (MEMMemRead),
    .MemWrite_i  (EXMemWrite),
    .MemWrite_o   (MEMMemWrite),
    .ALUResult_i (EXALUResult),
    .ALUResult_o (MEMALUResult),
    .WriteData_i (ALUParameter2),
    .WriteData_o (DMWriteData),
    .WriteReg_i  (EXRDaddr),
    .WriteReg_o  (MEMRDaddr),
    .clk_i       (clk_i)
);

Data_Memory Data_Memory(
    .clk_i      (clk_i), 
    .addr_i     (MEMALUResult),
    .MemRead_i  (MEMMemRead),
    .MemWrite_i (MEMMemWrite),
    .data_i     (DMWriteData),
    .data_o     (MEMReadData)
);
MEMWB MEMWB(
    .RegWrite_i (MEMRegWrite),
    .RegWrite_o (WBRegWrite),
    .MemtoReg_i (MEMMemtoReg),
    .MemtoReg_o (WBMemtoReg),
    .ALUResult_i (MEMALUResult),
    .ALUResult_o (WBWriteData0),
    .ReadData_i (MEMReadData),
    .ReadData_o (WBWriteData1),
    .PRD_i      (MEMRDaddr),
    .PRD_o      (WBRDaddr),
    .clk_i      (clk_i)
);

MUX1 WBMUX(
    .ctrl_i     (WBMemtoReg),
    .data0_i    (WBWriteData0),
    .data1_i    (WBWriteData1),
    .data_o     (WBWriteData)
);

ForwardingUnit ForwardingUnit(
    .PRS1_i     (EXRS1addr),
    .PRS2_i     (EXRS2addr),
    .MEMRegWrite_i (MEMRegWrite),
    .MEMRd_i    (MEMRDaddr),
    .WBRegWrite_i (WBRegWrite),
    .WBRd_i     (WBRDaddr),
    .ForwardA_o (ForwardA),
    .ForwardB_o (ForwardB)
);


Adder Adder(
    .data1_in   ({IDImm[30:0],1'b0}),
    .data2_in   (IDPC),
    .data_o     (BranchPC)
);

Sign_Extend ImmGen(
    .data_i     (IDInst),
    .data_o     (IDImm)
);

Hazard_Detection Hazard_Detection(
    .MemRead_i   (EXMemRead),
    .PRD_i       (EXRDaddr),
    .RS1addr_i   (IDRS1addr),
    .RS2addr_i   (IDRS2addr),
    .Stall_o     (Stall),
    .PCWrite_o   (PCWrite),
    .NoOp_o      (NoOp)
);

MUX1 PREDMUX(
    .ctrl_i     (PredFlush),
    .data0_i    (PCValueNew),
    .data1_i    (PCRight),
    .data_o     (PCValueNewNew)
);
branch_predictor branch_predictor(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .update_i   (EXBranch),
    .result_i   (result),
    .pc_i       (EXPC),
    .branchtarget_i (EXBranchPC),
    .flush_o    (PredFlush),
    .pc_o       (PCRight),
    .predict_o  (prediction)
);

AND AND1(
    .data0_i    (EXBranch),
    .data1_i    (Zero),
    .data_o     (result)
);
AND AND2(
    .data0_i    (Branch),
    .data1_i    (prediction),
    .data_o     (PCMUXCtrl)
);

endmodule
