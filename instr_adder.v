module instr_addr (input [31:0] imm, next_instr, output reg [31:0] add_instr);
always @(*)begin
    add_instr <= (imm << 2) + next_instr;
end
endmodule