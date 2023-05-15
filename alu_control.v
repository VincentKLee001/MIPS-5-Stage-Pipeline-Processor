module alu_control (input [5:0] func, input [1:0] aluOP, output reg [3:0] alu_contr);
	always @ (func, aluOP) begin
		case (aluOP)
			2'b10:case(func)
				6'b100000:alu_contr = 4'b0010; //add
				6'b100010:alu_contr = 4'b0110; //sub
				6'b100100:alu_contr = 4'b0000; //and
				6'b100101:alu_contr = 4'b0001; //or
				6'b101010:alu_contr = 4'b0111; //slt
				6'b011000:alu_contr = 4'b1000; //mult
				6'b011010:alu_contr = 4'b1001; //div
				6'b100111:alu_contr = 4'b1100; //nor
				6'b001000:alu_contr = 4'b1010; //addi
				6'b001010:alu_contr = 4'b0011; //mfhi
				6'b001100:alu_contr = 4'b0100; //mflo
			endcase
			2'b00:alu_contr = 4'b0010; //add (lw, sw)
			2'b01:alu_contr = 4'b0110; //sub (beq)
			2'b11:alu_contr = 4'b1111; //j
		endcase
	end
endmodule
