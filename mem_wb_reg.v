module mem_wb_reg (clk, reset, regwrite_in, MemtoReg_in, read_data_in, address_in, write_reg_addr_in, read_data_out, address_out, 
			regwrite_out, MemtoReg_out, write_reg_addr_out);


input clk, reset, regwrite_in, MemtoReg_in;
input [31:0] read_data_in, address_in;
input [4:0] write_reg_addr_in;
output reg regwrite_out, MemtoReg_out;
output reg [31:0] read_data_out, address_out;
output reg [4:0] write_reg_addr_out;

always @ (reset) begin
	regwrite_out <= 0;		//wb
	MemtoReg_out <= 0;		//wb
	read_data_out <= 0;
	address_out <= 0;
	write_reg_addr_out <= 0;
end

always @ (posedge clk) begin
	regwrite_out <= regwrite_in;		//wb
	MemtoReg_out <= MemtoReg_in;		//wb
	read_data_out <= read_data_in;
	address_out <= address_in;
	write_reg_addr_out <= write_reg_addr_in;
end

endmodule
