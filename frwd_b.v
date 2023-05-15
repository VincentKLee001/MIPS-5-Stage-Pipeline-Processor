module frwd_b (input [31:0] idex_rt, exmem_rs, mem_data, input [1:0] forward, output reg [31:0] out_data);
always @(*)begin
    if(forward == 2'b10) begin
        out_data <= exmem_rs;
    end
    else if(forward == 2'b01) begin
        out_data <= mem_data;
    end
    else begin
        out_data <= idex_rt;
    end
end
endmodule