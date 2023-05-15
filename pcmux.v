module pc_mux(input [31:0] next_instr, branch_addr, input branch, output reg [31:0] instr);

always @(*) begin
    if(branch == 1) begin
        instr <= branch_addr;
    end
    else begin
        instr <= next_instr;
    end
end

endmodule