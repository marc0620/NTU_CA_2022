module branch_predictor
(
    clk_i, 
    rst_i,
    update_i,
	result_i,
    pc_i,
    branchtarget_i,
	predict_o,
    flush_o,
    pc_o
);
input clk_i, rst_i, update_i, result_i;
input [31:0] pc_i,branchtarget_i;
output predict_o,flush_o;
output reg [31:0] pc_o;

// TODO

reg [1:0] state,statetemp;
reg flush_r,predict_r;
assign flush_o=flush_r,predict_o=predict_r;
initial begin
    state=00;
    statetemp=00;
    predict_r=1'b1;
    flush_r=1'b0;
end

always @ (update_i or result_i) begin
    if(update_i) begin
        if(result_i==1) begin
            case(state)
                2'b00: statetemp=2'b00;
                2'b01: statetemp=2'b00;
                2'b10: statetemp=2'b01;
                2'b11: statetemp=2'b10;
            endcase
            if(state==2'b11 || state==2'b10)begin
                flush_r=1'b1;
                pc_o=branchtarget_i;
            end
            else flush_r=0;
            $display("a");
        end
        if(result_i==0) begin
            case(state)
                2'b00: statetemp=2'b01;
                2'b01: statetemp=2'b10;
                2'b10: statetemp=2'b11;
                2'b11: statetemp=2'b11;
            endcase
            if(state==2'b00 ||state== 2'b01) begin
                flush_r=1'b1;
                pc_o=pc_i+4;
            end
            $display("b");
            
        end

    end
    else begin //not branching
        flush_r=1'b0;
        pc_o=0;
    end
    case(state)
        2'b00: predict_r=1'b1;
        2'b01: predict_r=1'b1;
        2'b10: predict_r=1'b0;
        2'b11: predict_r=1'b0;
    endcase
end
always @ (posedge clk_i) begin
    state<=statetemp;
    flush_r=0;
end



endmodule
