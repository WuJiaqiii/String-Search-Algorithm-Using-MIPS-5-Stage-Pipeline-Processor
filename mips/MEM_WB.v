module MEM_WB
(
    clk,
    reset,
    MEM_WB_Hazard,
    EX_MEM_MemtoReg,
    EX_MEM_RegWrite,
    EX_MEM_RegWrAddr,
    EX_MEM_ALUOut,
    EX_MEM_PC_add4,
    MEM_MemOut,

    MEM_WB_MemtoReg,
    MEM_WB_RegWrite,
    MEM_WB_RegWrAddr,
    MEM_WB_ALUOut,
    MEM_WB_PC_add4,
    MEM_WB_MemOut,
    Hazard_Delay
);
    input clk;
    input reset;
    input [1:0] MEM_WB_Hazard;
    input [1:0] EX_MEM_MemtoReg;
    input EX_MEM_RegWrite;
    input [4:0] EX_MEM_RegWrAddr;
    input [31:0] EX_MEM_ALUOut;
    input [31:0] MEM_MemOut;
    input [31:0] EX_MEM_PC_add4;
    input Hazard_Delay;

    output reg [1:0] MEM_WB_MemtoReg;
    output reg MEM_WB_RegWrite;
    output reg [4:0] MEM_WB_RegWrAddr;
    output reg [31:0] MEM_WB_ALUOut;
    output reg [31:0] MEM_WB_MemOut;
    output reg [31:0] MEM_WB_PC_add4;

    always @(posedge clk or posedge reset)
    begin
        if(reset) begin
            MEM_WB_MemtoReg <= 2'b0;
            MEM_WB_RegWrite <= 1'b0;
            MEM_WB_RegWrAddr <= 5'b0;
            MEM_WB_ALUOut <= 32'b0;
            MEM_WB_MemOut <= 32'b0;
            MEM_WB_PC_add4 <= 32'b0;
        end
        else begin
            if(Hazard_Delay)begin
                MEM_WB_MemtoReg <= EX_MEM_MemtoReg;
                MEM_WB_RegWrite <= EX_MEM_RegWrite;
                MEM_WB_RegWrAddr <= EX_MEM_RegWrAddr;
                MEM_WB_ALUOut <= EX_MEM_ALUOut;
                MEM_WB_MemOut <= MEM_MemOut;
                MEM_WB_PC_add4 <= EX_MEM_PC_add4;
            end
            else begin
            case(MEM_WB_Hazard)
            2'b00:begin
                MEM_WB_MemtoReg <= 2'b0;
                MEM_WB_RegWrite <= 1'b0;
                MEM_WB_RegWrAddr <= 5'b0;
                MEM_WB_ALUOut <= 32'b0;
                MEM_WB_MemOut <= 32'b0;
                MEM_WB_PC_add4 <= 32'b0;
            end
            2'b01:begin
                MEM_WB_MemtoReg <= EX_MEM_MemtoReg;
                MEM_WB_RegWrite <= EX_MEM_RegWrite;
                MEM_WB_RegWrAddr <= EX_MEM_RegWrAddr;
                MEM_WB_ALUOut <= EX_MEM_ALUOut;
                MEM_WB_MemOut <= MEM_MemOut;
                MEM_WB_PC_add4 <= EX_MEM_PC_add4;
            end
            default: begin end
            endcase
            end
        end
    end
endmodule