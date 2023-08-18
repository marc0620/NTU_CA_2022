module Hazard_Detection
(
    MemRead_i,
    PRD_i,
    RS1addr_i,
    RS2addr_i,
    Stall_o,
    PCWrite_o,
    NoOp_o
);

input MemRead_i;
input [4:0] PRD_i,RS1addr_i,RS2addr_i;

output NoOp_o,Stall_o,PCWrite_o;

reg PCWrite_r,Stall_r,NoOp_r;
assign PCWrite_o=PCWrite_r,Stall_o=Stall_r,NoOp_o=NoOp_r;



always @ (*) begin
    if (MemRead_i && ((PRD_i==RS1addr_i) || (PRD_i==RS2addr_i))) begin
        NoOp_r=1'b1;
        Stall_r=1'b1;
        PCWrite_r=1'b0;
    end
    else begin
        NoOp_r=1'b0;
        Stall_r=1'b0;
        PCWrite_r=1'b1;
    end
end
endmodule