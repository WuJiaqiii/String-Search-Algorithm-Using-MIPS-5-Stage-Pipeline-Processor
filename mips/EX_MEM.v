module EX_MEM
(
    clk,
    reset,
    EX_MEM_Hazard,
    ID_EX_MemRead,
    ID_EX_MemWrite,
    ID_EX_MemtoReg,
    ID_EX_RegWrite,
    ID_EX_RegData2,
    ID_EX_PC_add4,
    EX_ALUOut,
    EX_RegWrAddr,
    ID_EX_Rt,

    EX_MEM_MemRead,
    EX_MEM_MemWrite,
    EX_MEM_MemtoReg,
    EX_MEM_RegWrite,
    EX_MEM_ALUOut,
    EX_MEM_PC_add4,
    EX_MEM_RegWrAddr,
    EX_MEM_WriteData,
    Hazard_Delay,
    EX_MEM_Rt
);

    input clk;
    input reset;
    input [1:0] EX_MEM_Hazard;
    input ID_EX_MemRead;
    input ID_EX_MemWrite;
    input [1:0] ID_EX_MemtoReg;
    input ID_EX_RegWrite;
    input [31:0] ID_EX_RegData2;
    input [31:0] EX_ALUOut;
    input [31:0] ID_EX_PC_add4;
    input [4:0] EX_RegWrAddr;
    input Hazard_Delay;
    input [4:0] ID_EX_Rt;

    output reg EX_MEM_MemRead;
    output reg EX_MEM_MemWrite;
    output reg [1:0] EX_MEM_MemtoReg;
    output reg EX_MEM_RegWrite;
    output reg [31:0] EX_MEM_ALUOut;
    output reg [4:0] EX_MEM_RegWrAddr;
    output reg [31:0] EX_MEM_PC_add4;
    output reg [31:0] EX_MEM_WriteData;
    output reg [4:0] EX_MEM_Rt;

    always @(posedge clk or posedge reset)
    begin
        if(reset) begin
            EX_MEM_MemRead <= 1'b0;
            EX_MEM_MemWrite <= 1'b0;
            EX_MEM_MemtoReg <= 2'b0;
            EX_MEM_RegWrite <= 1'b0;
            EX_MEM_ALUOut <= 32'b0;
            EX_MEM_RegWrAddr <= 5'b0;
            EX_MEM_WriteData <= 32'b0;
            EX_MEM_PC_add4 <= 32'b0;
            EX_MEM_Rt <= 5'b0;
        end
        else begin
            if(Hazard_Delay) begin
                EX_MEM_MemRead <= ID_EX_MemRead;
                EX_MEM_MemWrite <= ID_EX_MemWrite;
                EX_MEM_MemtoReg <= ID_EX_MemtoReg;
                EX_MEM_RegWrite <= ID_EX_RegWrite;
                EX_MEM_ALUOut <= EX_ALUOut;
                EX_MEM_RegWrAddr <= EX_RegWrAddr;
                EX_MEM_WriteData <= ID_EX_RegData2;
                EX_MEM_PC_add4 <= ID_EX_PC_add4;
                EX_MEM_Rt <= ID_EX_Rt;
            end
            else begin
            case(EX_MEM_Hazard) 
            2'b00:begin
                EX_MEM_MemRead <= 1'b0;
                EX_MEM_MemWrite <= 1'b0;
                EX_MEM_MemtoReg <= 2'b0;
                EX_MEM_RegWrite <= 1'b0;
                EX_MEM_ALUOut <= 32'b0;
                EX_MEM_RegWrAddr <= 5'b0;
                EX_MEM_WriteData <= 32'b0;
                EX_MEM_PC_add4 <= 32'b0;
                EX_MEM_Rt <= 5'b0;
            end
            2'b01: begin
                EX_MEM_MemRead <= ID_EX_MemRead;
                EX_MEM_MemWrite <= ID_EX_MemWrite;
                EX_MEM_MemtoReg <= ID_EX_MemtoReg;
                EX_MEM_RegWrite <= ID_EX_RegWrite;
                EX_MEM_ALUOut <= EX_ALUOut;
                EX_MEM_RegWrAddr <= EX_RegWrAddr;
                EX_MEM_WriteData <= ID_EX_RegData2;
                EX_MEM_PC_add4 <= ID_EX_PC_add4;
                EX_MEM_Rt <= ID_EX_Rt;
            end
            default: begin end
            endcase
            end
        end
    end
endmodule