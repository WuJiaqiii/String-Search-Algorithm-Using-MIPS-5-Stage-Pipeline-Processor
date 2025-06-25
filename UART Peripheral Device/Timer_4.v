module Timer_4(
    input clk,
    input reset,
    output reg [1:0] ch
);

always @(posedge clk or posedge reset)
begin
    if(reset) ch <= 0;
    else begin
        if(ch == 3)
        ch <= 0;
        else
        ch <= ch + 1;
    end
end

endmodule