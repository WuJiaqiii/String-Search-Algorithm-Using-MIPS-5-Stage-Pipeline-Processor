module Pipeline(
    reset,
    clk,
    ano,
    BCDs,
    LEDs,
    Rx_Serial,
    Tx_Serial
    );

    input clk;
    input reset;
    input Rx_Serial;
    output Tx_Serial;
    output [3:0] ano;
    output [7:0] BCDs;
    output [7:0] LEDs;

    wire [7:0] LEDs_memout;
    wire [11:0] BCDs_memout;

    assign LEDs = LEDs_memout;
    assign ano = BCDs_memout[11:8];
    assign BCDs = BCDs_memout[7:0];

    wire [31:0] PC_IF;
    wire [31:0] PC_ID;
    wire [31:0] PC_EX;
    wire [31:0] PC_MEM;
    wire [31:0] PC_WB;

    wire [31:0] Inst_mem_out;
    wire [31:0] IF_PC_out;
    wire [31:0] IF_PC_out_add4;
    wire [31:0] PC_in;
    wire [31:0] PC_Jump;

    wire [31:0] IF_ID_PC_add4;
    wire [5:0]  IF_ID_OpCode;
    wire [4:0]  IF_ID_Rs;
    wire [4:0]  IF_ID_Rt;
    wire [4:0]  IF_ID_Rd;
    wire [4:0]  IF_ID_Shamt;
    wire [5:0]  IF_ID_Funct;
    wire [15:0] IF_ID_Imm_16;

    wire Branch_Jump;
    wire [1:0] ID_PCSrc;
    wire ID_Branch;
    wire ID_RegWrite;
    wire [1:0] ID_RegDst;
    wire ID_MemRead;
    wire ID_MemWrite;
    wire [1:0] ID_MemtoReg;
    wire ID_ALUSrc1;
    wire ID_ALUSrc2;
    wire ID_ExtOp;
    wire ID_LuOp;
    wire [31:0] ID_ImmExtOut;
    wire [31:0] ID_ImmExtShift;
    wire [31:0] ID_RegData1;
    wire [31:0] ID_RegData2;
    wire [4:0]  ID_ALUConf;
    wire ID_Sign;

    wire [31:0] ID_EX_PC_add4;
    wire ID_EX_RegWrite;
    wire [1:0] ID_EX_RegDst;
    wire ID_EX_MemRead;
    wire ID_EX_MemWrite;
    wire [1:0] ID_EX_MemtoReg;
    wire ID_EX_ALUSrc1;
    wire ID_EX_ALUSrc2;
    wire [31:0] ID_EX_RegData1;
    wire [31:0] ID_EX_RegData2;
    wire [31:0] ID_EX_ImmExtOut;
    wire [4:0] ID_EX_Rs;
    wire [4:0] ID_EX_Rt;
    wire [4:0] ID_EX_Rd;
    wire [4:0] ID_EX_Shamt;
    wire [4:0] ID_EX_ALUConf;
    wire ID_EX_Sign;

    wire [31:0] EX_ALUOut;
    wire [31:0] A_Multi_Out;
    wire [31:0] B_Multi_Out;
    wire [31:0] EX_ALU_In1;
    wire [31:0] EX_ALU_In2;
    wire [4:0]  EX_RegWrAddr;

    wire [31:0] EX_MEM_PC_add4;
    wire EX_MEM_MemRead;
    wire EX_MEM_MemWrite;
    wire Data_Mem_MemWrite;
    wire [1:0] EX_MEM_MemtoReg;
    wire EX_MEM_RegWrite;
    wire [31:0] EX_MEM_ALUOut;
    wire [4:0] EX_MEM_RegWrAddr;
    wire [31:0] EX_MEM_WriteData;
    wire [31:0] MEM_MemOut;
    wire [4:0] EX_MEM_Rt;

    wire [31:0] Data_Mem_Address;
    wire [31:0] Data_Mem_WriteData;
    wire [1:0] AddressSrc;

    wire [31:0] MEM_MemIn_Data;
    wire [31:0] MEM_WB_PC_add4;
    wire [1:0] MEM_WB_MemtoReg;
    wire MEM_WB_RegWrite;
    wire [4:0] MEM_WB_RegWrAddr;
    wire [31:0] MEM_WB_ALUOut;
    wire [31:0] MEM_WB_MemOut;
    wire [31:0] WB_WB;
    wire [1:0] ForwardA;
    wire [1:0] ForwardB;
    wire [1:0] ForwardC;
    wire [1:0] ForwardD;
    wire ForwardE;
    wire ForwardF;
    wire [31:0] C_Multi_Out;
    wire [31:0] D_Multi_Out;

    wire [1:0] IF_ID_Hazard;
    wire [1:0] ID_EX_Hazard;
    wire [1:0] EX_MEM_Hazard;
    wire [1:0] MEM_WB_Hazard;
    wire PC_Hazard;
    wire delay;
    reg  Hazard_Delay;

    reg  Finish_flag;
    wire [31:0] Final_result;
    wire [31:0] BCDs_data;
    wire [31:0] LEDs_data;
    wire [31:0] Counter;
    wire [31:0] Final;

    parameter CLKS_PER_BIT = 16'd10417;  // 100M/9600
    parameter MEM_SIZE = 512;

    wire recv_done;
    reg recv1_done;
    reg recv2_done;
    reg send_done;   
    assign recv_done = recv1_done && recv2_done; 
    /*--------------------------------UART RX-------------------------*/
    wire Rx_DV;
    wire [7:0] Rx_Byte;     
    /*--------------------------------UART TX-------------------------*/
    reg Tx_DV;
    reg [7:0] Tx_Byte;
    wire Tx_Active;
    wire Tx_Done;  
    /*----------------------------------MEM----------------------------*/
    // str memory
    reg [15:0] addr0;
    reg wr_en0;
    reg [31:0] wdata0;
    // pattern memory
    reg [15:0] addr1;
    reg wr_en1;
    reg [31:0] wdata1;
    /*----------------------------------MEM Control----------------------------*/
    reg [31:0] word;
    reg [31:0] cntByteTime;

    assign IF_PC_out_add4 = IF_PC_out + 32'd4;
    assign A_Multi_Out = (ForwardA == 2'b00)? ID_EX_RegData1 :
                         (ForwardA == 2'b01)? EX_MEM_ALUOut :
                         WB_WB;
    assign B_Multi_Out = (ForwardB == 2'b00)? ID_EX_RegData2 :
                         (ForwardB == 2'b01)? EX_MEM_ALUOut :
                         WB_WB;
    assign EX_ALU_In1 = (ID_EX_ALUSrc1)? A_Multi_Out : ID_EX_Shamt;
    assign EX_ALU_In2 = (ID_EX_ALUSrc2)? B_Multi_Out : ID_EX_ImmExtOut;

    assign EX_RegWrAddr = (ID_EX_RegDst == 2'b00)? ID_EX_Rd :
                          (ID_EX_RegDst == 2'b01)? ID_EX_Rt :
                                                   5'b11111;

    assign WB_WB = (MEM_WB_MemtoReg == 2'b00)? MEM_WB_ALUOut :
                   (MEM_WB_MemtoReg == 2'b01)? MEM_WB_MemOut :
                                               MEM_WB_PC_add4; // PC + 8?

    assign PC_in = (recv_done)? 
                  ((Hazard_Delay)? IF_PC_out:
                   (PC_Hazard)? IF_PC_out:
                   (ID_PCSrc == 2'b01)? IF_PC_out_add4:
                   (ID_PCSrc == 2'b00)? ((Branch_Jump)? IF_ID_PC_add4 + ID_ImmExtShift : IF_PC_out_add4):
                   (ID_PCSrc == 2'b10)? PC_Jump:
                   (ForwardE)? EX_MEM_PC_add4 : ID_RegData1// PC + 8?
                  )
                  :32'hfffffffc;

    assign PC_Jump = {IF_ID_PC_add4[31:28], IF_ID_Rs, IF_ID_Rt, IF_ID_Imm_16, 2'b00}; 

    assign C_Multi_Out = (ForwardC == 2'b00)? ID_RegData1:
                         (ForwardC == 2'b01)? EX_MEM_ALUOut:
                         WB_WB;

    assign D_Multi_Out = (ForwardD == 2'b00)? ID_RegData2:
                         (ForwardD == 2'b01)? EX_MEM_ALUOut:
                         WB_WB;

    assign Branch_Jump = ID_Branch && ((IF_ID_OpCode == 6'h04)? (C_Multi_Out == D_Multi_Out) :
                                       (IF_ID_OpCode == 6'h07)? (C_Multi_Out > 0) :
                                       (IF_ID_OpCode == 6'h06)? (C_Multi_Out <= 0) :
                                       (IF_ID_OpCode == 6'h01)? (C_Multi_Out < 0) : 
                                       (IF_ID_OpCode == 6'h05)? !(C_Multi_Out == D_Multi_Out) : 0);

    assign PC_IF = IF_PC_out;
    assign PC_ID = IF_ID_PC_add4 - 32'd4;
    assign PC_EX = ID_EX_PC_add4 - 32'd4;
    assign PC_MEM = EX_MEM_PC_add4 - 32'd4;
    assign PC_WB = MEM_WB_PC_add4 - 32'd4;

    assign Final_result = Final;

    assign MEM_MemIn_Data = (ForwardF)? WB_WB : EX_MEM_WriteData;

    assign BCDs_data[7:0] = (Final_result[3:0] == 4'h0)?8'b11000000:
                            (Final_result[3:0] == 4'h1)?8'b11111001:
                            (Final_result[3:0] == 4'h2)?8'b10100100:
                            (Final_result[3:0] == 4'h3)?8'b10110000:
                            (Final_result[3:0] == 4'h4)?8'b10011001:
                            (Final_result[3:0] == 4'h5)?8'b10010010:
                            (Final_result[3:0] == 4'h6)?8'b10000010:
                            (Final_result[3:0] == 4'h7)?8'b11111000:
                            (Final_result[3:0] == 4'h8)?8'b10000000:
                            (Final_result[3:0] == 4'h9)?8'b10010000:
                            (Final_result[3:0] == 4'ha)?8'b10001000:
                            (Final_result[3:0] == 4'hb)?8'b10000011:
                            (Final_result[3:0] == 4'hc)?8'b11000110:
                            (Final_result[3:0] == 4'hd)?8'b10100001:
                            (Final_result[3:0] == 4'he)?8'b10000110:8'b11111111;
    
    assign BCDs_data[15:8] = (Final_result[7:4] == 4'h0)?8'b11000000:
                             (Final_result[7:4] == 4'h1)?8'b11111001:
                             (Final_result[7:4] == 4'h2)?8'b10100100:
                             (Final_result[7:4] == 4'h3)?8'b10110000:
                             (Final_result[7:4] == 4'h4)?8'b10011001:
                             (Final_result[7:4] == 4'h5)?8'b10010010:
                             (Final_result[7:4] == 4'h6)?8'b10000010:
                             (Final_result[7:4] == 4'h7)?8'b11111000:
                             (Final_result[7:4] == 4'h8)?8'b10000000:
                             (Final_result[7:4] == 4'h9)?8'b10010000:
                             (Final_result[7:4] == 4'ha)?8'b10001000:
                             (Final_result[7:4] == 4'hb)?8'b10000011:
                             (Final_result[7:4] == 4'hc)?8'b11000110:
                             (Final_result[7:4] == 4'hd)?8'b10100001:
                             (Final_result[7:4] == 4'he)?8'b10000110:8'b11111111;

    assign BCDs_data[23:16] = (Final_result[11:8] == 4'h0)?8'b11000000:
                              (Final_result[11:8] == 4'h1)?8'b11111001:
                              (Final_result[11:8] == 4'h2)?8'b10100100:
                              (Final_result[11:8] == 4'h3)?8'b10110000:
                              (Final_result[11:8] == 4'h4)?8'b10011001:
                              (Final_result[11:8] == 4'h5)?8'b10010010:
                              (Final_result[11:8] == 4'h6)?8'b10000010:
                              (Final_result[11:8] == 4'h7)?8'b11111000:
                              (Final_result[11:8] == 4'h8)?8'b10000000:
                              (Final_result[11:8] == 4'h9)?8'b10010000:
                              (Final_result[11:8] == 4'ha)?8'b10001000:
                              (Final_result[11:8] == 4'hb)?8'b10000011:
                              (Final_result[11:8] == 4'hc)?8'b11000110:
                              (Final_result[11:8] == 4'hd)?8'b10100001:
                              (Final_result[11:8] == 4'he)?8'b10000110:8'b11111111;

    assign BCDs_data[31:24] = (Final_result[15:12] == 4'h0)?8'b11000000:
                              (Final_result[15:12] == 4'h1)?8'b11111001:
                              (Final_result[15:12] == 4'h2)?8'b10100100:
                              (Final_result[15:12] == 4'h3)?8'b10110000:
                              (Final_result[15:12] == 4'h4)?8'b10011001:
                              (Final_result[15:12] == 4'h5)?8'b10010010:
                              (Final_result[15:12] == 4'h6)?8'b10000010:
                              (Final_result[15:12] == 4'h7)?8'b11111000:
                              (Final_result[15:12] == 4'h8)?8'b10000000:
                              (Final_result[15:12] == 4'h9)?8'b10010000:
                              (Final_result[15:12] == 4'ha)?8'b10001000:
                              (Final_result[15:12] == 4'hb)?8'b10000011:
                              (Final_result[15:12] == 4'hc)?8'b11000110:
                              (Final_result[15:12] == 4'hd)?8'b10100001:
                              (Final_result[15:12] == 4'he)?8'b10000110:8'b11111111;

    assign LEDs_data = {30'b0, recv2_done, recv1_done};
    
    assign Data_Mem_Address = (AddressSrc == 2'b00)? EX_MEM_ALUOut:
                              (AddressSrc == 2'b01)? 32'h4000000C: //访问LEDs
                              (AddressSrc == 2'b10)? 32'h40000010: //访问BCDs
                              32'h40000014; //访问系统时钟计数器
    
    assign AddressSrc = (Finish_flag)? (Counter[18]? 2'b10 : 2'b01) : 2'b00;
    // assign AddressSrc = (Finish_flag)? 2'b10: 2'b00;

    assign Data_Mem_MemWrite = (Finish_flag)? 1'b1 : EX_MEM_MemWrite;

    assign Data_Mem_WriteData = (Finish_flag)? ((AddressSrc == 2'b10)?
                                                                    ((Counter[20:19] == 2'b00)? {20'b0, 4'b1110, BCDs_data[7:0]}:
                                                                     (Counter[20:19] == 2'b01)? {20'b0, 4'b1101, BCDs_data[15:8]}:
                                                                     (Counter[20:19] == 2'b10)? {20'b0, 4'b1011, BCDs_data[23:16]}:
                                                                     (Counter[20:19] == 2'b11)? {20'b0, 4'b0111, BCDs_data[31:24]}:{20'b0, 12'b1})
                                                :(AddressSrc == 2'b01)? LEDs_data : 32'b0
                                               ) : MEM_MemIn_Data;

    RegTemp PC
    (
        .clk(clk),
        .reset(reset),
        .Data_i(PC_in),
        .Data_o(IF_PC_out)
    );

    InstructionMemory_str Mem_Inst
    (
        .Address(IF_PC_out),
        .Instruction(Inst_mem_out)
    );

    IF_ID IFID
    (
        .Hazard_Delay(Hazard_Delay),
        .clk(clk),
        .reset(reset),
        .IF_ID_Hazard(IF_ID_Hazard),
        .PC_add4_in(IF_PC_out_add4),
        .Instruction(Inst_mem_out),
        .PC_add4_out(IF_ID_PC_add4),
        .OpCode(IF_ID_OpCode),
        .Rs(IF_ID_Rs),
        .Rt(IF_ID_Rt),
        .Rd(IF_ID_Rd),
        .Shamt(IF_ID_Shamt),
        .Funct(IF_ID_Funct),
        .Imm_16(IF_ID_Imm_16)
    );

    Control Ctrl_unit
    (
        .OpCode(IF_ID_OpCode),
        .Funct(IF_ID_Funct),
        .PCSrc(ID_PCSrc),        //ID  
        .Branch(ID_Branch),      //ID
        .RegWrite(ID_RegWrite),  //WB
        .RegDst(ID_RegDst),      //EX
        .MemRead(ID_MemRead),    //MEM
        .MemWrite(ID_MemWrite),  //MEM
        .MemtoReg(ID_MemtoReg),  //WB
        .ALUSrc1(ID_ALUSrc1),    //EX
        .ALUSrc2(ID_ALUSrc2),    //EX
        .ExtOp(ID_ExtOp),        //ID
        .LuOp(ID_LuOp)           //ID
    );

    RegisterFile Regs
    (
        .reset(reset),
        .clk(clk),
        .Finish_flag(Finish_flag),
        .RegWrite(MEM_WB_RegWrite),
        .Read_register1(IF_ID_Rs),
        .Read_register2(IF_ID_Rt),
        .Write_register(MEM_WB_RegWrAddr),
        .Write_data(WB_WB),
        .Read_data1(ID_RegData1),
        .Read_data2(ID_RegData2),
        .Final(Final)
    );

    ImmProcess ImmProcess_0
    (
        .ExtOp(ID_ExtOp),
        .LuiOp(ID_LuOp),
        .Immediate(IF_ID_Imm_16),
        .ImmExtOut(ID_ImmExtOut),
        .ImmExtShift(ID_ImmExtShift)
    );

    ALUControl ALUControl_0
    (
        .OpCode(IF_ID_OpCode),
        .Funct(IF_ID_Funct),
        .ALUConf(ID_ALUConf),
        .Sign(ID_Sign)
    );

    ID_EX IDEX
    (
        .clk(clk),
        .reset(reset),
        .ID_EX_Hazard(ID_EX_Hazard),
        .Hazard_Delay(Hazard_Delay),
        .ID_RegWrite(ID_RegWrite),
        .ID_RegDst(ID_RegDst),
        .ID_MemRead(ID_MemRead),
        .ID_MemWrite(ID_MemWrite),
        .ID_MemtoReg(ID_MemtoReg),
        .ID_ALUSrc1(ID_ALUSrc1),
        .ID_ALUSrc2(ID_ALUSrc2),
        .ID_RegData1(ID_RegData1),
        .ID_RegData2(ID_RegData2),
        .ID_ImmExtOut(ID_ImmExtOut),
        .ID_ALUConf(ID_ALUConf),
        .ID_Sign(ID_Sign),
        .IF_ID_Rs(IF_ID_Rs),
        .IF_ID_Rt(IF_ID_Rt),
        .IF_ID_Rd(IF_ID_Rd),
        .IF_ID_PC_add4(IF_ID_PC_add4),
        .IF_ID_Shamt(IF_ID_Shamt),
        .ID_EX_RegWrite(ID_EX_RegWrite),
        .ID_EX_RegDst(ID_EX_RegDst),
        .ID_EX_MemRead(ID_EX_MemRead),
        .ID_EX_MemWrite(ID_EX_MemWrite),
        .ID_EX_MemtoReg(ID_EX_MemtoReg),
        .ID_EX_ALUSrc1(ID_EX_ALUSrc1),
        .ID_EX_ALUSrc2(ID_EX_ALUSrc2),
        .ID_EX_RegData1(ID_EX_RegData1),
        .ID_EX_RegData2(ID_EX_RegData2),
        .ID_EX_ImmExtOut(ID_EX_ImmExtOut),
        .ID_EX_Rs(ID_EX_Rs),
        .ID_EX_Rt(ID_EX_Rt),
        .ID_EX_Rd(ID_EX_Rd),
        .ID_EX_PC_add4(ID_EX_PC_add4),
        .ID_EX_Shamt(ID_EX_Shamt),
        .ID_EX_ALUConf(ID_EX_ALUConf),
        .ID_EX_Sign(ID_EX_Sign)
    );

    ALU ALU_0
    (
        .ALUConf(ID_EX_ALUConf),
        .Sign(ID_EX_Sign),
        .In1(EX_ALU_In1),
        .In2(EX_ALU_In2),
        .Result(EX_ALUOut)
    );

    EX_MEM EXMEM
    (
        .clk(clk),
        .reset(reset),
        .Hazard_Delay(Hazard_Delay),
        .EX_MEM_Hazard(EX_MEM_Hazard),
        .ID_EX_MemRead(ID_EX_MemRead),
        .ID_EX_MemWrite(ID_EX_MemWrite),
        .ID_EX_MemtoReg(ID_EX_MemtoReg),
        .ID_EX_RegWrite(ID_EX_RegWrite),
        .ID_EX_RegData2(ID_EX_RegData2),
        .ID_EX_PC_add4(ID_EX_PC_add4),
        .ID_EX_Rt(ID_EX_Rt),
        .EX_ALUOut(EX_ALUOut),
        .EX_RegWrAddr(EX_RegWrAddr),
        .EX_MEM_MemRead(EX_MEM_MemRead),
        .EX_MEM_MemWrite(EX_MEM_MemWrite),
        .EX_MEM_MemtoReg(EX_MEM_MemtoReg),
        .EX_MEM_RegWrite(EX_MEM_RegWrite),
        .EX_MEM_ALUOut(EX_MEM_ALUOut),
        .EX_MEM_PC_add4(EX_MEM_PC_add4),
        .EX_MEM_RegWrAddr(EX_MEM_RegWrAddr),
        .EX_MEM_WriteData(EX_MEM_WriteData),
        .EX_MEM_Rt(EX_MEM_Rt)
    );

    DataMemory Mem_Data
    (
        .reset(reset),
        .clk(clk),
        .Address(Data_Mem_Address),
        .Write_data(Data_Mem_WriteData),
        .Read_data(MEM_MemOut),
        .MemRead(EX_MEM_MemRead),
        .MemWrite(Data_Mem_MemWrite),
        .LEDs(LEDs_memout),
        .BCDs(BCDs_memout),
        .Counter(Counter)
    );

    MEM_WB MEMWB
    (
        .clk(clk),
        .reset(reset),
        .Hazard_Delay(Hazard_Delay),
        .EX_MEM_PC_add4(EX_MEM_PC_add4),
        .MEM_WB_Hazard(MEM_WB_Hazard),
        .EX_MEM_MemtoReg(EX_MEM_MemtoReg),
        .EX_MEM_RegWrite(EX_MEM_RegWrite),
        .EX_MEM_RegWrAddr(EX_MEM_RegWrAddr),
        .EX_MEM_ALUOut(EX_MEM_ALUOut),
        .MEM_MemOut(MEM_MemOut),
        .MEM_WB_MemtoReg(MEM_WB_MemtoReg),
        .MEM_WB_RegWrite(MEM_WB_RegWrite),
        .MEM_WB_RegWrAddr(MEM_WB_RegWrAddr),
        .MEM_WB_ALUOut(MEM_WB_ALUOut),
        .MEM_WB_PC_add4(MEM_WB_PC_add4),
        .MEM_WB_MemOut(MEM_WB_MemOut)
    );

    Forwarding Forward
    (
        .IF_ID_Funct(IF_ID_Funct),
        .IF_ID_OpCode(IF_ID_OpCode),
        .ID_EX_Rt(ID_EX_Rt),
        .ID_EX_Rs(ID_EX_Rs),
        .IF_ID_Rs(IF_ID_Rs),
        .IF_ID_Rt(IF_ID_Rt),
        .EX_MEM_Rt(EX_MEM_Rt),
        .EX_MEM_RegWrite(EX_MEM_RegWrite),
        .MEM_WB_RegWrite(MEM_WB_RegWrite),
        .EX_MEM_RegWrAddr(EX_MEM_RegWrAddr),
        .MEM_WB_RegWrAddr(MEM_WB_RegWrAddr),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB),
        .ForwardC(ForwardC),
        .ForwardD(ForwardD),
        .ForwardE(ForwardE),
        .ForwardF(ForwardF)
    );

    Hazard Hazard_0
    (
        .EX_RegWrAddr(EX_RegWrAddr),
        .Inst_mem_out(Inst_mem_out),
        .Branch_Jump(Branch_Jump),
        .ID_Branch(ID_Branch),
        .IF_ID_OpCode(IF_ID_OpCode),
        .IF_ID_Funct(IF_ID_Funct),
        .ID_EX_MemRead(ID_EX_MemRead),
        .ID_EX_RegWrite(ID_EX_RegWrite),
        .ID_EX_Rt(ID_EX_Rt),
        .IF_ID_Rs(IF_ID_Rs),
        .IF_ID_Rt(IF_ID_Rt),
        .IF_ID_Hazard(IF_ID_Hazard),
        .ID_EX_Hazard(ID_EX_Hazard),
        .EX_MEM_Hazard(EX_MEM_Hazard),
        .MEM_WB_Hazard(MEM_WB_Hazard),
        .PC_Hazard(PC_Hazard),
        .delay(delay)
    );

    uart_rx #(.CLKS_PER_BIT(CLKS_PER_BIT)) uart_rx_inst
        (.i_Clock(clk),
         .i_Rx_Serial(Rx_Serial),
         .o_Rx_DV(Rx_DV),
         .o_Rx_Byte(Rx_Byte)
         );

    uart_tx #(.CLKS_PER_BIT(CLKS_PER_BIT)) uart_tx_inst
        (.i_Clock(clk),
         .i_Tx_DV(Tx_DV),
         .i_Tx_Byte(Tx_Byte),
         .o_Tx_Active(Tx_Active),
         .o_Tx_Serial(Tx_Serial),
         .o_Tx_Done(Tx_Done)
         );

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            Hazard_Delay <= 1'b0;
            Finish_flag <= 1'b0;
            addr0 <= 16'd0;
            wr_en0 <= 1'b0;
            wdata0 <= 32'd0;
            addr1 <= 16'd0;
            wr_en1 <= 1'b0;
            wdata1 <= 32'd0;
            word <= 32'd0;
            cntByteTime <= 32'd0;
            recv1_done <= 1'b0;
            recv2_done <= 1'b0;
            Tx_DV <= 1'b0;
            Tx_Byte <= 8'd0;
            send_done <= 1'b0;
        end
        else begin
            if(IF_PC_out == 32'h1d4) begin
                Finish_flag <= 1'b1; 
            end
            if(Hazard_Delay == 1'b1) begin
                Hazard_Delay <= 1'b0;
            end
            if(delay == 1'b1) begin
                Hazard_Delay <= 1'b1;
            end
            // uart to memory
            if(Rx_DV)begin
                word <= {24'b0, Rx_Byte};
                // receive str
                if(word != 32'd10 && recv1_done == 1'b0) begin
                    addr0 <= addr0 + 3'd4;
                    wr_en0 <= 1'b1;
                    wr_en1 <= 1'b0;
                    wdata0 <= word;
                end
                // receive data
                else begin
                    recv1_done <= 1'b1;
                    if(word != 32'd10 && recv2_done == 1'b0)begin
                        addr1 <= addr1 + 3'd4;
                        wr_en0 <= 1'b0;
                        wr_en1 <= 1'b1;
                        wdata1 <= word;
                    end
                    else begin
                        recv2_done <= 1'b1;
                    end
                end
            end
            // memory to uart
            if(Finish_flag == 1'b1)
            begin
                if(cntByteTime == CLKS_PER_BIT*20 && send_done==1'b0) begin  // 1Byte time
                    cntByteTime <= 32'd0;
                    Tx_DV <= 1'b1;
                    Tx_Byte <= Final_result;
                    send_done <= 1'b1;
                end
                else begin
                    cntByteTime <= cntByteTime+1'b1;         
                    Tx_DV <= 1'b0;
                end
            end       
        end
    end

endmodule