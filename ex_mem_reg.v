module ex_mem_reg (reset, clk, regwrite_in, MemtoReg_in, branch_in, MemRead_in, MemWrite_in, next_instr_in, alu_result_in, read_data2_in, write_reg_addr_in,
			regwrite_out, MemtoReg_out, branch_out, MemRead_out, MemWrite_out, next_instr_out, alu_result_out, read_data2_out, write_reg_addr_out,
			jump_addr_in, jump_addr_out, zero_in, zero_out, jump_in);
//zero inp outp
input reset, clk, regwrite_in, MemtoReg_in, branch_in, MemRead_in, MemWrite_in, zero_in, jump_in;
input [31:0] next_instr_in, alu_result_in, read_data2_in, jump_addr_in;
input [4:0] write_reg_addr_in;
output reg regwrite_out, MemtoReg_out, branch_out, MemRead_out, MemWrite_out, zero_out;
output reg [31:0] next_instr_out, alu_result_out, read_data2_out, jump_addr_out;
output reg [4:0] write_reg_addr_out;

always @ (reset) begin
	next_instr_out <= 0;
	alu_result_out <= 0;
	read_data2_out <= 0;
	write_reg_addr_out <= 0;
	regwrite_out <= 0;		//wb
	MemtoReg_out <= 0;		//wb
	branch_out <= 0;		//m
	MemRead_out <= 0;		//m
	MemWrite_out <= 0;		//m
end

always @ (posedge clk) begin
	regwrite_out <= regwrite_in;		//wb
	MemtoReg_out <= MemtoReg_in;		//wb
	branch_out <= branch_in;		//m
	MemRead_out <= MemRead_in;		//m
	MemWrite_out <= MemWrite_in;		//m

	//next_instr_out <= next_instr_in;
	alu_result_out <= alu_result_in;
	read_data2_out <= read_data2_in;
	write_reg_addr_out <= write_reg_addr_in;
	//jump_addr_out <= jump_addr_in;
	//zero_out <= zero_in;
	if (jump_in) next_instr_out <= jump_addr_in;
	else next_instr_out <= next_instr_in;
end

endmodule