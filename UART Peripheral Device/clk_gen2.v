module clk_gen2(
    clk, 
    reset, 
    clk_out
);

input           clk;
input           reset;
output          clk_out;

reg             clk_out;

parameter   CNT = 32'd5000000;

reg     [32:0]  count;

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        clk_out <= 1'b0;
        count <= 32'd0;
    end
    else begin
        count <= (count==CNT-32'd1) ? 32'd0 : count + 32'd1;
        clk_out <= (count==32'd0) ? ~clk_out : clk_out;
    end
end

endmodule