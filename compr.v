module compr(input [31:0] data1, data2, input branch, output reg flush, pcsrc);
    reg temp;
    always @ (data1, data2) begin
        temp <= data1 - data2;
        if (branch && (temp == 0)) begin
            flush <= 1;
            pcsrc <= 1;
        end
        else begin
            flush <= 0;
            pcsrc <= 0;
        end
    end
endmodule