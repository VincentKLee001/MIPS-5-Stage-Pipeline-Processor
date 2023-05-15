module alu(input [31:0] a, b, input [3:0] aluOP, output reg [31:0] result, output reg zero);
	reg [63:0] holding_reg;
	always @(a, b, aluOP) begin
		case (aluOP)
	 4'b0000 : result <= a & b; //Logical AND
         4'b0001 : result <= a | b; //Logical OR
         4'b0010 : result <= a + b; //Addition
         4'b0110 : result <= a - b; //Subtraction
         4'b0111 : result <= (a < b ? 1 : 0); //Set less than
         4'b1000 : begin
		result <= (a * b); //mult
		holding_reg <= (a * b);
	 end 
         4'b1001 : begin
		if (b != 0) begin
		result <= (a / b); //div
		holding_reg <= (a / b);
		end
	 end  
         4'b1100 : result <= ~(a | b); //nor
         4'b1010 : result <= (a + b); // addi
         4'b0011 : result <= holding_reg[63:32]; // mfhi
         4'b0100 : result <= holding_reg[31:0]; // mflo
         default : result <= 0;
       endcase
			zero = (result == 0) ? 1 : 0;
	end
endmodule
