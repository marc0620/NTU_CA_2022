module IF_ID (
    clk_i, rst_i, flush_i, stall_i, 
    inst_i, PC_i,
    inst_o, PC_o
);
input         clk_i, rst_i, flush_i, stall_i;
input  [31:0] inst_i, PC_i;
output reg [31:0] inst_o, PC_o;

// TODO 
initial begin
    inst_o=32'h0000;
    PC_o=32'h0000;
end

always @ (posedge clk_i) begin
    if(flush_i) begin
        inst_o<=32'h0000;
        PC_o<=32'h0000;
        $display("flushed");
    end
    else if(stall_i==0) begin
        inst_o<=inst_i;
        PC_o<=PC_i;
    end
    
end

endmodule
