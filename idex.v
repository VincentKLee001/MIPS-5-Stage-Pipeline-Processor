module idex (input clk, input [4:0] ifid_rs, ifid_rt, ifid_rd, input [31:0] data1, data2, imm, next_instr, jump_addr_in, input [1:0] in_aluOP, 
input in_regdst, in_alusrc, in_regwrite, in_memtoreg, in_memwrite, in_memread, in_branch, in_jump, 
output reg [1:0] aluOP, output reg regdst, alusrc, regwrite, memtoreg, memwrite, memread, branch, jump, 
output reg [4:0] idex_rs, idex_rt, idex_rd, output reg [31:0] out_data1, out_data2, out_next_instr, out_imm, jump_addr_out, output reg [5:0] func);

always @(posedge clk)begin
    out_next_instr <= next_instr;
    out_data1 <= data1;
    out_data2 <= data2;
    idex_rs <= ifid_rs;
    idex_rt <= ifid_rt;
    idex_rd <= ifid_rd;
    func <= imm[5:0];
    aluOP <= in_aluOP;
    regdst <= in_regdst;
    alusrc <= in_alusrc;
    regwrite <= in_regwrite;
    memtoreg <= in_memtoreg;
    memwrite <= in_memwrite;
    memread <= in_memread;
    branch <= in_branch;
    jump <= in_jump;
    out_imm <= imm;
    jump_addr_out <= jump_addr_in;
end
endmodule