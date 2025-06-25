module top(
    System_clk,
    BTNU,
    ano,
    BCDs,
    LEDs
);

input System_clk;
input BTNU;

output [7:0] BCDs;
output [3:0] ano;
output [7:0] LEDs;

wire [7:0] LEDs_cpuout;
wire [11:0] BCDs_cpuout;

Pipeline cpu
(
    .clk(System_clk),
    .reset(BTNU),
    .LEDs(LEDs_cpuout),
    .BCDs(BCDs_cpuout)
);

assign LEDs = LEDs_cpuout;
assign ano = BCDs_cpuout[11:8];
assign BCDs = BCDs_cpuout[7:0];
endmodule