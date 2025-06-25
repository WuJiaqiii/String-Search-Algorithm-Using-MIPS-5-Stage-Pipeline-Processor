module Hazard
(
    EX_RegWrAddr,
    Inst_mem_out,
    Branch_Jump,
    ID_Branch,
    IF_ID_OpCode,
    IF_ID_Funct,
    ID_EX_MemRead,
    ID_EX_RegWrite,
    ID_EX_Rt,
    IF_ID_Rs,
    IF_ID_Rt,
    IF_ID_Hazard,
    ID_EX_Hazard,
    EX_MEM_Hazard,
    MEM_WB_Hazard,
    PC_Hazard,
    delay
);

    input [4:0] EX_RegWrAddr;
    input ID_EX_RegWrite;
    input [31:0] Inst_mem_out;
    input Branch_Jump;
    input ID_Branch;
    input [5:0] IF_ID_OpCode;
    input [5:0] IF_ID_Funct;
    input ID_EX_MemRead;
    input [4:0] ID_EX_Rt;
    input [4:0] IF_ID_Rs;
    input [4:0] IF_ID_Rt;

    output reg [1:0] IF_ID_Hazard;
    output reg [1:0] ID_EX_Hazard;
    output reg [1:0] EX_MEM_Hazard;
    output reg [1:0] MEM_WB_Hazard;
    output reg PC_Hazard;
    output reg delay;

    wire type1;
    wire type2;
    wire type3;
    wire type4;
    wire type5;

    assign type1 = ID_EX_MemRead && ((ID_EX_Rt == IF_ID_Rs) || (ID_EX_Rt == IF_ID_Rt));
    assign type2 = IF_ID_OpCode == 6'h02  || IF_ID_OpCode == 6'h03 || (IF_ID_OpCode == 6'h00 && IF_ID_Funct == 6'h08) || (IF_ID_OpCode == 6'h00 && IF_ID_Funct == 6'h09);
    assign type3 = ID_Branch && ID_EX_RegWrite && (ID_EX_MemRead == 1'b0) && (IF_ID_Rs == EX_RegWrAddr || IF_ID_Rt == EX_RegWrAddr);
    assign type4 = ID_Branch && ID_EX_RegWrite && ID_EX_MemRead && (IF_ID_Rs == EX_RegWrAddr || IF_ID_Rt == EX_RegWrAddr);
    assign type5 = ID_Branch && Branch_Jump;

    always @(*) begin
        if(ID_EX_MemRead && ((ID_EX_Rt == IF_ID_Rs) || (ID_EX_Rt == IF_ID_Rt)) && ~ID_Branch) 
        begin //load-use Hazard
            IF_ID_Hazard <= 2'b10;
            ID_EX_Hazard <= 2'b00;
            EX_MEM_Hazard <= 2'b01;
            MEM_WB_Hazard <= 2'b01;
            PC_Hazard <= 1'b1;
            delay <= 1'b0;
        end
        else if(IF_ID_OpCode == 6'h02  || IF_ID_OpCode == 6'h03 || (IF_ID_OpCode == 6'h00 && IF_ID_Funct == 6'h08) || (IF_ID_OpCode == 6'h00 && IF_ID_Funct == 6'h09)) 
        begin // j-Hazard
            IF_ID_Hazard <= 2'b00;
            ID_EX_Hazard <= 2'b01;
            EX_MEM_Hazard <= 2'b01;
            MEM_WB_Hazard <= 2'b01;
            PC_Hazard <= 1'b0;
            delay <= 1'b0;
        end
        else if(ID_Branch && ID_EX_RegWrite && (ID_EX_MemRead == 1'b0) && (IF_ID_Rs == EX_RegWrAddr || IF_ID_Rt == EX_RegWrAddr))
        begin // beq_Hazard
            IF_ID_Hazard <= 2'b10;
            ID_EX_Hazard <= 2'b00;
            EX_MEM_Hazard <= 2'b01;
            MEM_WB_Hazard <= 2'b01;
            PC_Hazard <= 1'b1;
            delay <= 1'b0;
        end
        else if(ID_Branch && ID_EX_RegWrite && ID_EX_MemRead && (IF_ID_Rs == EX_RegWrAddr || IF_ID_Rt == EX_RegWrAddr))
        begin // lw + beq hazard
            IF_ID_Hazard <= 2'b10;
            ID_EX_Hazard <= 2'b00;
            EX_MEM_Hazard <= 2'b01;
            MEM_WB_Hazard <= 2'b01;
            PC_Hazard <= 1'b1;
            delay <= 1'b1;
        end
        else if(ID_Branch && Branch_Jump) 
        begin // Branch_Jump-Hazard
            IF_ID_Hazard <= 2'b00;
            ID_EX_Hazard <= 2'b01;
            EX_MEM_Hazard <= 2'b01;
            MEM_WB_Hazard <= 2'b01;
            PC_Hazard <= 1'b0;
            delay <= 1'b0;
        end
        else begin IF_ID_Hazard <= 2'b01;ID_EX_Hazard <= 2'b01;EX_MEM_Hazard <= 2'b01;MEM_WB_Hazard <= 2'b01;PC_Hazard <= 1'b0;end
    end
endmodule