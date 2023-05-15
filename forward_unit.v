module forward_unit (input ex_mem_rw, mem_wb_rw, input [4:0] id_ex_rs, id_ex_rt, ex_mem_rd, mem_wb_rd, output [1:0] fwd_a, fwd_b);
	//ex_mem_rw and mem_wb_rw are control signals
	reg [1:0] fwd_a_temp, fwd_b_temp;
	always @ (ex_mem_rw, mem_wb_rw, id_ex_rs, id_ex_rt, ex_mem_rd, mem_wb_rd) begin
		if (ex_mem_rw == 1 && ex_mem_rd != 0 && ex_mem_rd == id_ex_rs) begin
			fwd_a_temp <= 2'b10;
		end
		else if (mem_wb_rw == 1 && mem_wb_rd != 0 && mem_wb_rd == id_ex_rs) begin
			fwd_a_temp <= 2'b01;
		end


		if (ex_mem_rw == 1 && ex_mem_rd != 0 && ex_mem_rd == id_ex_rt) begin
			fwd_b_temp <= 2'b10;
		end
		else if (mem_wb_rw == 1 && mem_wb_rd != 0 && mem_wb_rd == id_ex_rt) begin
			fwd_b_temp <= 2'b01;
		end
	end
	assign fwd_a = fwd_a_temp;
	assign fwd_b = fwd_b_temp;
	
endmodule
