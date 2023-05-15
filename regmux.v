module reg_mux (input [31:0] alu, data_mem, input memtoreg, output reg [31:0] data);
always @(alu, data_mem, memtoreg) begin
    if (memtoreg == 0)begin
        data <= data_mem;
    end
    else begin
        data <= alu;
    end
end
endmodule
