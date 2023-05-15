module sign_extend(input [15:0] inst, output reg [31:0] inst_out);
always @ (inst) begin
    inst_out[15:0] <= inst[15:0];
    inst_out[31:16] <= {16{inst[15]}};
end
endmodule
