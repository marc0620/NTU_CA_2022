//Done
module IFID(clk_i, Inst_i,Inst_o,pc_i,pc_o,Stall_i,Flush_i);
input [31:0] Inst_i,pc_i;
input clk_i,Stall_i,Flush_i;
output [31:0] Inst_o,pc_o;

reg [31:0] Inst_R,pc_r;
assign Inst_o=Inst_R,pc_o=pc_r;

initial begin
    Inst_R=32'h0000;
    pc_r=32'h0000;
end

always @ (posedge clk_i) begin
    if(Flush_i) begin
        Inst_R<=32'h0000;
        pc_r<=32'h0000;
    end
    else if(Stall_i==0) begin
        Inst_R<=Inst_i;
        pc_r<=pc_i;
    end
    
end


endmodule