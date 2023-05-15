module writereg_mux (input [4:0] rt, rd, input regdst, output reg [4:0] out_reg);
always @(*)begin
    if (regdst == 1)begin
        out_reg <= rd;
    end
    else begin
        out_reg <= rt;
    end
end
endmodule