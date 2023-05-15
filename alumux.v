module alu_mux (input [31:0] data_in, imm, input alusrc, output reg [31:0] alu_in);
always @(*)begin
    if (alusrc == 1) begin
        alu_in <= imm;
    end
    else begin
        alu_in <= data_in;
    end
end
endmodule