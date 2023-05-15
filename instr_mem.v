module instr_mem(input reg [31:0] address, instr_in, output reg [31:0] instr); //user input 32 bits
	//reg [31:0] mem_array [255:0];
	reg [7:0] mem_array [255:0];
	reg [255:0] counter;

	initial counter = 0;

	always @ (instr_in) begin
	mem_array[counter+3] <= instr_in[7:0];
	mem_array[counter+2] <= instr_in[15:8];
	mem_array[counter+1] <= instr_in[23:16];
	mem_array[counter] <= instr_in[31:24];
	counter <= counter + 4;
	end

	initial begin
		//lw $s1, 0($s3) <-- ??

		//addi simulation
		//mem_array[0]={6'b1000,5'b0, 5'b01, 16'b101};
		//mem_array[4]={6'b1000,5'b0, 5'b10, 16'b100};

		//add simulation with forwarding working
		//mem_array[0]={6'b0,5'b01,5'b10,5'b11,5'b0,6'b100000};
		//mem_array[4]={6'b0,5'b11,5'b1,5'b100,5'b0,6'b100000};

		//sub
		//mem_array[0]={6'b0,5'b01,5'b10,5'b11,5'b0,6'b100010};

		//and
		//mem_array[4]={6'b0,5'b01,5'b10,5'b100,5'b0,6'b100100};

		//or
		//mem_array[8]={6'b0,5'b01,5'b10,5'b101,5'b0,6'b100101};

		//slt
		//mem_array[12]={6'b0,5'b01,5'b10,5'b110,5'b0,6'b101010};

		//mult
		//mem_array[0]={6'b0,5'b01,5'b10,5'b111,5'b0,6'b011000};

		//div
		//mem_array[0]={6'b0,5'b01,5'b10,5'b11,5'b0,6'b011010};

		//nor
		//mem_array[24]={6'b0,5'b01,5'b10,5'b1001,5'b0,6'b100111};

		//sw r1, 0(r2)
		//mem_array[0] = {6'b101011, 5'b10, 5'b01, 16'b0};

		//lw r1, 0(r2) 		r1 should have value 7
		//add r4, r1, r3	r1 + r3 stored in r4 
		//Data Hazard Working
		//mem_array[0] = {6'b100011, 5'b10, 5'b01, 16'b0};
		//mem_array[4]={6'b0,5'b01,5'b11,5'b100,5'b0,6'b100000};

		//branch
		//mem_array[0] = {6'b100, 5'b10, 5'b01, 16'b1000};
		//mem_array[36]={6'b0,5'b01,5'b10,5'b11,5'b0,6'b100000};

		//jump
		//mem_array[0] = {6'b10, 26'b1000};
		//mem_array[36]={6'b0,5'b01,5'b10,5'b11,5'b0,6'b100000};

		//mfhi mflo
		//mem_array[0]={6'b0,5'b01,5'b10,5'b11,5'b0,6'b011000};
		//mem_array[4]={6'b0,5'b0,5'b00,5'b100,5'b0,6'b001100};
		
	end
	always @ (address) begin
		instr <= {mem_array[address], mem_array[address + 1], mem_array[address + 2], mem_array[address + 3]};
	end
endmodule
