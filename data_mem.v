module data_mem(input [31:0] address, input [31:0] wr_data, input MemWrite, MemRead, output reg [31:0] read_data);
    //reg [31:0] mem_array [255:0];
	//initial mem_array [5] = 32'b111;
    reg [7:0] mem_array [255:0];
    always @ (address, MemWrite, MemRead, wr_data) begin
        //if (MemWrite == 1) mem_array[address] <= wr_data;
	if (MemWrite == 1) begin
	mem_array[address+3] <= wr_data[7:0];
	mem_array[address+2] <= wr_data[15:8];
	mem_array[address+1] <= wr_data[23:16];
	mem_array[address] <= wr_data[31:24];
	end
        //else if (MemRead == 1) read_data <= mem_array[address]; 
	else if (MemRead == 1) read_data <= {mem_array[address], mem_array[address+1], mem_array[address+2], mem_array[address+3]};
    end
endmodule