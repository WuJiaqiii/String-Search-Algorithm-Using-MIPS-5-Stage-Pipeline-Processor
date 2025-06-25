module ID_EX(
    clk,
    reset,
    IF_ID_PC_add4,
    ID_EX_Hazard,
    ID_RegWrite,
    ID_RegDst,
    ID_MemRead,
    ID_MemWrite,
    ID_MemtoReg,
    ID_ALUSrc1,
    ID_ALUSrc2,
    ID_RegData1,
    ID_RegData2,
    ID_ImmExtOut,
    IF_ID_Rs,
    IF_ID_Rt,
    IF_ID_Rd,
    IF_ID_Shamt,
    ID_ALUConf,
    ID_Sign,

    ID_EX_RegWrite,
    ID_EX_RegDst,
    ID_EX_MemRead,
    ID_EX_MemWrite,
    ID_EX_MemtoReg,
    ID_EX_ALUSrc1,
    ID_EX_ALUSrc2,
    ID_EX_RegData1,
    ID_EX_RegData2,
    ID_EX_ImmExtOut,
    ID_EX_Rs,
    ID_EX_Rt,
    ID_EX_Rd,
    ID_EX_PC_add4,
    ID_EX_Shamt,
    ID_EX_ALUConf,
    ID_EX_Sign,
    Hazard_Delay
);

    input clk;
    input reset;
    input ID_RegWrite;
    input [1:0] ID_EX_Hazard;
    input [1:0] ID_RegDst;
    input ID_MemRead;
    input ID_MemWrite;
    input [1:0] ID_MemtoReg;
    input ID_ALUSrc1;
    input ID_ALUSrc2;
    input [31:0] ID_RegData1;
    input [31:0] ID_RegData2;
    input [31:0] ID_ImmExtOut;
    input [4:0]  IF_ID_Rs;
    input [4:0]  IF_ID_Rt;
    input [4:0]  IF_ID_Rd;
    input [4:0]  IF_ID_Shamt;
    input [4:0]  ID_ALUConf;
    input [31:0] IF_ID_PC_add4;
    input ID_Sign;
    input Hazard_Delay;

    output reg ID_EX_RegWrite;
    output reg [1:0] ID_EX_RegDst;
    output reg ID_EX_MemRead;
    output reg ID_EX_MemWrite;
    output reg [1:0] ID_EX_MemtoReg;
    output reg ID_EX_ALUSrc1;
    output reg ID_EX_ALUSrc2;
    output reg [31:0] ID_EX_RegData1;
    output reg [31:0] ID_EX_RegData2;
    output reg [31:0] ID_EX_ImmExtOut;
    output reg [4:0]  ID_EX_Rs;
    output reg [4:0]  ID_EX_Rt;
    output reg [4:0]  ID_EX_Rd;
    output reg [4:0]  ID_EX_Shamt;
    output reg [4:0]  ID_EX_ALUConf;
    output reg [31:0] ID_EX_PC_add4;
    output reg ID_EX_Sign;

    always @(posedge clk or posedge reset)
    begin
        if(reset) begin
            ID_EX_RegWrite <= 1'b0;
            ID_EX_RegDst <= 2'b0;
            ID_EX_MemRead <= 1'b0;
            ID_EX_MemWrite <= 1'b0;
            ID_EX_MemtoReg <= 2'b0;
            ID_EX_ALUSrc1 <= 1'b0;
            ID_EX_ALUSrc2 <= 1'b0;
            ID_EX_RegData1 <= 32'b0;
            ID_EX_RegData2 <= 32'b0;
            ID_EX_ImmExtOut <= 32'b0;
            ID_EX_Rs <= 5'b0;
            ID_EX_Rt <= 5'b0;
            ID_EX_Rd <= 5'b0;
            ID_EX_PC_add4 <= 32'b0;
            ID_EX_Shamt <= 5'b0;
            ID_EX_ALUConf <= 5'b0;
            ID_EX_Sign <= 1'b0;
        end
        else begin
            if(Hazard_Delay) begin
                ID_EX_RegWrite <= 1'b0;
                ID_EX_RegDst <= 2'b0;
                ID_EX_MemRead <= 1'b0;
                ID_EX_MemWrite <= 1'b0;
                ID_EX_MemtoReg <= 2'b0;
                ID_EX_ALUSrc1 <= 1'b0;
                ID_EX_ALUSrc2 <= 1'b0;
                ID_EX_RegData1 <= 32'b0;
                ID_EX_RegData2 <= 32'b0;
                ID_EX_ImmExtOut <= 32'b0;
                ID_EX_Rs <= 5'b0;
                ID_EX_Rt <= 5'b0;
                ID_EX_Rd <= 5'b0;
                ID_EX_PC_add4 <= 32'b0;
                ID_EX_Shamt <= 5'b0;
                ID_EX_ALUConf <= 5'b0;
                ID_EX_Sign <= 1'b0;
            end
            else begin
            case(ID_EX_Hazard)
            2'b00:begin
                ID_EX_RegWrite <= 1'b0;
                ID_EX_RegDst <= 2'b0;
                ID_EX_MemRead <= 1'b0;
                ID_EX_MemWrite <= 1'b0;
                ID_EX_MemtoReg <= 2'b0;
                ID_EX_ALUSrc1 <= 1'b0;
                ID_EX_ALUSrc2 <= 1'b0;
                ID_EX_RegData1 <= 32'b0;
                ID_EX_RegData2 <= 32'b0;
                ID_EX_ImmExtOut <= 32'b0;
                ID_EX_Rs <= 5'b0;
                ID_EX_Rt <= 5'b0;
                ID_EX_Rd <= 5'b0;
                ID_EX_PC_add4 <= 32'b0;
                ID_EX_Shamt <= 5'b0;
                ID_EX_ALUConf <= 5'b0;
                ID_EX_Sign <= 1'b0;
            end
            2'b01:begin
                ID_EX_RegWrite <= ID_RegWrite;
                ID_EX_RegDst <= ID_RegDst;
                ID_EX_MemRead <= ID_MemRead;
                ID_EX_MemWrite <= ID_MemWrite;
                ID_EX_MemtoReg <= ID_MemtoReg;
                ID_EX_ALUSrc1 <= ID_ALUSrc1;
                ID_EX_ALUSrc2 <= ID_ALUSrc2;
                ID_EX_RegData1 <= ID_RegData1;
                ID_EX_RegData2 <= ID_RegData2;
                ID_EX_ImmExtOut <= ID_ImmExtOut;
                ID_EX_Rs <= IF_ID_Rs;
                ID_EX_Rt <= IF_ID_Rt;
                ID_EX_Rd <= IF_ID_Rd;
                ID_EX_PC_add4 <= IF_ID_PC_add4;
                ID_EX_Shamt <= IF_ID_Shamt;
                ID_EX_ALUConf <= ID_ALUConf;
                ID_EX_Sign <= ID_Sign;
            end
            default: begin end
            endcase
            end
        end
    end
endmodule