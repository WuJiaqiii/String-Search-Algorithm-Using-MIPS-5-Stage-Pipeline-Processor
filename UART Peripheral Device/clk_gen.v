module clk_gen(
    clk, 
    reset, 
    clk_out
);

input           clk;
input           reset;
output          clk_out;

reg             clk_out;

parameter   CNT = 16'd5000;

reg     [15:0]  count;

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        clk_out <= 1'b0;
        count <= 16'd0;
    end
    else begin
        count <= (count==CNT-16'd1) ? 16'd0 : count + 16'd1;
        clk_out <= (count==16'd0) ? ~clk_out : clk_out;
    end
end

endmodule