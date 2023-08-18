//Done
module ForwardingUnit
(
    PRS1_i,PRS2_i, MEMRd_i, WBRegWrite_i, WBRd_i, MEMRegWrite_i, ForwardA_o, ForwardB_o
);

input [4:0] PRS1_i,PRS2_i,MEMRd_i,WBRd_i;
input MEMRegWrite_i,WBRegWrite_i;

output [1:0] ForwardA_o,ForwardB_o;
reg[1:0] ForwardA_r,ForwardB_r;

assign ForwardA_o=ForwardA_r,ForwardB_o=ForwardB_r;

always @ (*) begin
    ForwardA_r=2'b00;
    ForwardB_r=2'b00;
    if (MEMRegWrite_i && (MEMRd_i!=0) && (MEMRd_i==PRS1_i)) begin
        ForwardA_r=2'b10;
    end
    if (MEMRegWrite_i && (MEMRd_i!=0) && (MEMRd_i==PRS2_i)) begin
        ForwardB_r=2'b10;
    end
    if(WBRegWrite_i && (WBRd_i!=0) &&  !(MEMRegWrite_i && (MEMRd_i!=0) && (MEMRd_i==PRS1_i)) && (WBRd_i==PRS1_i)) begin
        ForwardA_r=2'b01;
    end
    if(WBRegWrite_i && (WBRd_i!=0) && !(MEMRegWrite_i && (MEMRd_i!=0) && (MEMRd_i==PRS2_i)) && (WBRd_i==PRS2_i)) begin
        ForwardB_r=2'b01;
    end
end
endmodule