module main_controller(inst, opcode, ALUop, RegDest, Branch, MemRead, MemToReg, MemWrite, ALUsrc, RegWrite, jump);
	input [31:0] inst;
	input [5:0] opcode;

	output reg [1:0] ALUop;
	output reg RegDest, Branch, MemRead, MemToReg, MemWrite, ALUsrc, RegWrite, jump;

	always @ (opcode) begin
	if (inst == 32'b0) begin
		ALUop <= 2'b0;
		RegDest <= 1'b0;
		Branch <= 1'b0;
		MemRead <= 1'b0;
		MemToReg <= 1'b0;
		MemWrite <= 1'b0;
		ALUsrc <= 1'b0;
		RegWrite <= 1'b0;
		jump <= 1'b0;
	end

	else begin
			case(opcode) 
	6'b000000:begin		//RType
		ALUop <= 2'b10;
		RegDest <= 1'b1;
		Branch <= 1'b0;
		MemRead <= 1'b0;
		MemToReg <= 1'b1;
		MemWrite <= 1'b0;
		ALUsrc <= 1'b0;
		RegWrite <= 1'b1;
		jump <= 1'b0;
	end

	6'b100011:begin		//lw
		ALUop <= 2'b0;
		RegDest <= 1'b0;
		Branch <= 1'b0;
		MemRead <= 1'b1;
		MemToReg <= 1'b0;
		MemWrite <= 1'b0;
		ALUsrc <= 1'b1;
		RegWrite <= 1'b1;
	end

	6'b101011:begin		//sw
		ALUop <= 2'b0;
		RegDest <= 1'b0;
		Branch <= 1'b0;
		MemRead <= 1'b0;
		MemToReg <= 1'b0;
		MemWrite <= 1'b1;
		ALUsrc <= 1'b1;
		RegWrite <= 1'b0;
	end

	6'b000100:begin		//beq
		ALUop <= 2'b01;
		RegDest <= 1'b0;
		Branch <= 1'b1;
		MemRead <= 1'b0;
		MemToReg <= 1'b0;
		MemWrite <= 1'b0;
		ALUsrc <= 1'b0;
		RegWrite <= 1'b0;
		jump <= 1'b0;
	end

	6'b001000:begin		//addi
		ALUop <= 2'b0;
		RegDest <= 1'b0;
		Branch <= 1'b0;
		MemRead <= 1'b0;
		MemToReg <= 1'b1;
		MemWrite <= 1'b0;
		ALUsrc <= 1'b1;
		RegWrite <= 1'b1;
		jump <= 1'b0;
	end

	6'b000010:begin		//jump
		ALUop <= 2'b11;
		RegDest <= 1'b0;
		Branch <= 1'b1;
		MemRead <= 1'b0;
		MemToReg <= 1'b0;
		MemWrite <= 1'b0;
		ALUsrc <= 1'b0;
		RegWrite <= 1'b0;
		jump <= 1'b1;
	end

	endcase

	end

	end
endmodule
