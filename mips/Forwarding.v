module Forwarding
(
    IF_ID_OpCode,
    IF_ID_Funct,
    ID_EX_Rt,
    ID_EX_Rs,
    IF_ID_Rs,
    IF_ID_Rt,
    EX_MEM_Rt,
    EX_MEM_RegWrite,
    MEM_WB_RegWrite,
    EX_MEM_RegWrAddr,
    MEM_WB_RegWrAddr,
    ForwardA,
    ForwardB,
    ForwardC,
    ForwardD,
    ForwardE,
    ForwardF
);
    input [5:0] IF_ID_Funct;
    input [5:0] IF_ID_OpCode;
    input [4:0] ID_EX_Rt;
    input [4:0] ID_EX_Rs;
    input [4:0] IF_ID_Rs;
    input [4:0] IF_ID_Rt;
    input [4:0] EX_MEM_Rt;
    input EX_MEM_RegWrite;
    input MEM_WB_RegWrite;
    input [4:0] EX_MEM_RegWrAddr;
    input [4:0] MEM_WB_RegWrAddr;
    output reg [1:0] ForwardA;
    output reg [1:0] ForwardB;
    output reg [1:0] ForwardC;
    output reg [1:0] ForwardD;
    output reg ForwardE;
    output reg ForwardF;

    always @(*) begin
        if(EX_MEM_RegWrite && (EX_MEM_RegWrAddr != 0) && (EX_MEM_RegWrAddr == ID_EX_Rs)) 
            begin ForwardA <= 2'b01; end
        else if(MEM_WB_RegWrite && (MEM_WB_RegWrAddr != 0) && (MEM_WB_RegWrAddr == ID_EX_Rs) && ((EX_MEM_RegWrAddr != ID_EX_Rs) || (~EX_MEM_RegWrite)))
            begin ForwardA <= 2'b10; end
        else 
            begin ForwardA <= 2'b00; end

        if(EX_MEM_RegWrite && (EX_MEM_RegWrAddr != 0) && (EX_MEM_RegWrAddr == ID_EX_Rt))
            begin ForwardB <= 2'b01; end
        else if(MEM_WB_RegWrite && (MEM_WB_RegWrAddr != 0) && (MEM_WB_RegWrAddr == ID_EX_Rt) && ((EX_MEM_RegWrAddr != ID_EX_Rt) || (~EX_MEM_RegWrite)))
            begin ForwardB <= 2'b10; end
        else
            begin ForwardB <= 2'b00; end

        if(EX_MEM_RegWrite && (EX_MEM_RegWrAddr != 0) && EX_MEM_RegWrAddr == IF_ID_Rs) //beq系列指令转发
            begin ForwardC <= 2'b01; end
        else if(MEM_WB_RegWrite && (MEM_WB_RegWrAddr != 0) && (MEM_WB_RegWrAddr == IF_ID_Rs) && ((EX_MEM_RegWrAddr != IF_ID_Rs) || (~EX_MEM_RegWrite)))
            begin ForwardC <= 2'b10; end
        else
            begin ForwardC <= 2'b00; end

        if(EX_MEM_RegWrite && (EX_MEM_RegWrAddr != 0) && EX_MEM_RegWrAddr == IF_ID_Rt) //beq系列指令转发
            begin ForwardD <= 2'b01; end
        else if(MEM_WB_RegWrite && (MEM_WB_RegWrAddr != 0) && (MEM_WB_RegWrAddr == IF_ID_Rt) && ((EX_MEM_RegWrAddr != IF_ID_Rt) || (~EX_MEM_RegWrite)))
            begin ForwardD <= 2'b10; end
        else
            begin ForwardD <= 2'b00; end
            
        if(EX_MEM_RegWrAddr == IF_ID_Rs && (IF_ID_OpCode == 6'h00 && (IF_ID_Funct == 6'h08 || IF_ID_Funct == 6'h09))) //jal接jr
            begin ForwardE <= 1'b1; end
        else
            begin ForwardE <= 1'b0; end

        if(MEM_WB_RegWrite && (MEM_WB_RegWrAddr != 0) && (MEM_WB_RegWrAddr == EX_MEM_Rt)) //sw指令转发
            begin ForwardF <= 1'b1; end
        else
            begin ForwardF <= 1'b0; end

    end
endmodule