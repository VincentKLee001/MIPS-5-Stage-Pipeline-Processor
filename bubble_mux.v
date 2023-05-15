module bubble_mux (input [1:0]in_aluOP, input in_regdst, in_alusrc, in_regwrite, in_memtoreg, in_memwrite, in_memread, in_branch, in_jump, flush,
output reg [1:0] aluOP, output reg regdst, alusrc, regwrite, memtoreg, memwrite, memread, branch, jump);
always@(*)begin
    if(flush == 0)begin
        aluOP <= in_aluOP;
        regdst <= in_regdst;
        alusrc <= in_alusrc;
        regwrite <= in_regwrite;
        memtoreg <= in_memtoreg;
        memwrite <= in_memwrite;
        memread <= in_memread;
        branch <= in_branch;
        jump <= in_jump;
    end
    else begin
        aluOP <= 2'b00;
        regdst <= 1'b0;
        alusrc <= 1'b0;
        regwrite <= 1'b0; 
        memtoreg <= 1'b0;
        memwrite <= 1'b0;
        memread <= 1'b0;
        branch <= 1'b0;
        jump <= 1'b0;
    end

end
endmodule