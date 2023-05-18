`timescale 1ns/100ps

module processor_top_tb;
	reg enable;
	reg clk;
	reg [31:0] instr;

	processor_top processor_top1(.clk(clk), .enable(enable), .instr_in(instr));
	initial begin
		clk = 0;
		enable = 1;
		/*
		instr = {6'b1000,5'b0, 5'b01, 16'b11};	//r1 = 4
		#1
		instr = {6'b1000,5'b0, 5'b10, 16'b10}; //r2 = 2
		#1
		instr = {6'b0,5'b01,5'b10,5'b11,5'b0,6'b011010}; //[r1/r2] = r3
		#1
		instr = {6'b0,5'b11,5'b10,5'b11,5'b0,6'b011000}; //r3 x r2 = r3
		#1
		instr = {6'b0,5'b11,5'b01,5'b100,5'b0,6'b100010}; //r3 - r1 = r4
		#20
		enable = 0;
		*/
		instr = {6'b1000,5'b0, 5'b10, 16'b100}; //addi r2, 4
		#1
		instr = {6'b0,5'b10,5'b10,5'b11,5'b0,6'b100000}; //add r3, r2, r2
		#1
		instr = {6'b101011, 5'b10, 5'b11, 16'b0}; //sw r3, 0(r2)
		#1
		instr = {6'b100011, 5'b10, 5'b01, 16'b0}; //lw r1, 0(r2)
		#1
		instr = {6'b0,5'b01,5'b11,5'b100,5'b0,6'b100100}; //and r4, r1, r3
		#20
		enable = 0;

	end
	
	always #10 clk = ~clk;
endmodule
