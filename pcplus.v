module pcplus4 (input [31:0] instr, input pcwrite, clk, en, output reg [31:0] next_instr);
initial begin
//next_instr = 32'b0;
end
always @(posedge clk) begin
    if (pcwrite == 1) begin
        //next_instr <= instr;
    end
    
    else if (en == 1) begin
	    next_instr <= 32'b0;
	end
	else begin
	    next_instr <= instr;
	end
end
endmodule
