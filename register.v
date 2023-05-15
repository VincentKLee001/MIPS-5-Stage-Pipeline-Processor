module register (input [31:0] in_data, input [4:0] reg1, reg2, w_reg, input reg_write, clk, output reg [31:0] data1, data2);
	reg [31:0] registers [31:0];
	initial begin
	registers [0] = 32'b00000000000000000000000000000000;
	//registers [1] = 32'b11111111111111111111111111111111;
	//registers [2] = 32'b100;
	//registers [3] = 32'b1;
	end

	always @ (negedge clk) begin
		if (reg_write == 1)	registers[w_reg] <= in_data;
	end

	always @(reg1, reg2) begin
		data1 <= registers[reg1];
		data2 <= registers[reg2];
	end
endmodule
