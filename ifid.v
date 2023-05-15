module ifid (input [31:0] instr, next_instr, input clk, ifdwrite, ifflush, output reg [5:0] op, output reg [31:0] out_next_instr, jump_addr,
 			output reg [4:0] ifid_rs, ifid_rt, ifid_rd, output reg [15:0] imm, output reg [5:0] func);
reg [31:0] old_instr;
reg [31:0] pc_temp;

always @(posedge clk) begin
	if(ifflush == 1) begin
		op <= 6'b0;
		out_next_instr <= 32'b0;
		ifid_rs <= 5'b0;
		ifid_rt <= 5'b0;
		ifid_rd <= 5'b0;
		imm <= 16'b0;
	end
	else if (ifdwrite == 1) begin

	end
	else begin
		op <= instr[31:26];
		out_next_instr <= next_instr;
		ifid_rs <= instr[25:21];
		ifid_rt <= instr[20:16];
		ifid_rd <= instr[15:11];
		imm <= instr[15:0];
		jump_addr[27:0] <= instr[25:0] << 2;
		jump_addr[31:28] <= next_instr[31:28];
		
	end
	func <= instr[5:0];
end
endmodule