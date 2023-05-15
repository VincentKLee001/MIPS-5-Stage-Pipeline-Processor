module adder(input [31:0] a, output reg [31:0] out);
    always @ (a) begin
        out <= a + 4;
    end
endmodule