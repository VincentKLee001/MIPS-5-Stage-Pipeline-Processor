module hazard(input [4:0] ifid_regRs, ifid_regRt, idex_regRt, input idex_memread, flush, output reg ifdwrite, pcwrite, bubble);

always @(*) begin
    if (idex_memread && ((idex_regRt == ifid_regRs) || (idex_regRt == ifid_regRt))) begin
        ifdwrite <= 1;
        pcwrite <= 1;
        bubble <= 1;
    end
    else if (flush) begin
        ifdwrite <= 1;
        pcwrite <= 1;
        bubble <= 1;
    end
    else begin
    ifdwrite <= 0;
    pcwrite <= 0;
    bubble <= 0;
    end
end


endmodule
