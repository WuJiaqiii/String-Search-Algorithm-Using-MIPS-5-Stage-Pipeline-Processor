module IF_ID(
    clk,
    reset,
    IF_ID_Hazard,
    PC_add4_in,
    Instruction,
    PC_add4_out,
    OpCode,
    Rs,
    Rt,
    Rd,
    Shamt,
    Funct,
    Imm_16,
    Hazard_Delay
);

    input clk;
    input reset;
    input [31:0] PC_add4_in;
    input [31:0] Instruction;
    input [1:0] IF_ID_Hazard;
    input Hazard_Delay;
    output reg [31:0] PC_add4_out;
    output reg [5:0] OpCode;
    output reg [4:0] Rs;
    output reg [4:0] Rt;
    output reg [4:0] Rd;
    output reg [4:0] Shamt;
    output reg [5:0] Funct;
    output reg [15:0] Imm_16;

    always @(posedge clk or posedge reset)
    begin
        if(reset) begin //重置清零寄存器
            PC_add4_out <= 32'b0;
            OpCode <= 6'b0;
            Rs <= 5'b0;
            Rt <= 5'b0;
            Rd <= 5'b0;
            Shamt <= 5'b0;
            Funct <= 6'b0;
            Imm_16 <= 16'b0;
        end
        else begin
            if(Hazard_Delay) begin end //延迟一个时钟周期，也即flush两个周期，IF_ID寄存器不做操作
            else begin
            case(IF_ID_Hazard) 
            2'b00:begin  // Hazard为0，清零寄存器
                PC_add4_out <= 32'b0;
                OpCode <= 6'b0;
                Rs <= 5'b0;
                Rt <= 5'b0;
                Rd <= 5'b0;
                Shamt <= 5'b0;
                Funct <= 6'b0;
                Imm_16 <= 16'b0;
            end
            2'b01:begin  // Hazard为1，寄存器更新
                PC_add4_out <= PC_add4_in;
                OpCode <= Instruction[31:26];
                Rs <= Instruction[25:21];
                Rt <= Instruction[20:16];
                Rd <= Instruction[15:11];
                Shamt <= Instruction[10:6];
                Funct <= Instruction[5:0];
                Imm_16 <= Instruction[15:0];
            end
            default:begin end // Hazard为2，保存寄存器的值
            endcase
            end
        end
    end

endmodule