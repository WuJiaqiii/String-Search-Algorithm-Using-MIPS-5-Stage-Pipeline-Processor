module BCD7(
	input [3:0] din,
    input [1:0] ch,
	output [7:0] dout,
    output [3:0] ano
);

assign dout = (din==4'h0)?8'b11000000:
              (din==4'h1)?8'b11111001:
              (din==4'h2)?8'b10100100:
              (din==4'h3)?8'b10110000:
              (din==4'h4)?8'b10011001:
              (din==4'h5)?8'b10010010:
              (din==4'h6)?8'b10000010:
              (din==4'h7)?8'b11111000:
              (din==4'h8)?8'b10000000:
              (din==4'h9)?8'b10010000:
              (din==4'ha)?8'b10001000:
              (din==4'hb)?8'b10000011:
              (din==4'hc)?8'b11000110:
              (din==4'hd)?8'b10100001:
              (din==4'he)?8'b10000110:8'b11111111;

assign ano = (ch == 2'b00)?4'b1110:
             (ch == 2'b01)?4'b1101:
             (ch == 2'b10)?4'b1011:4'b0111;

endmodule

