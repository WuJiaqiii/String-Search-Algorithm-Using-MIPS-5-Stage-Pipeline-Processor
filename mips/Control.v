module Control(OpCode, Funct,
	PCSrc, Branch, RegWrite, RegDst, 
	MemRead, MemWrite, MemtoReg, 
	ALUSrc1, ALUSrc2, ExtOp, LuOp);
	input [5:0] OpCode;
	input [5:0] Funct;
	output reg [1:0] PCSrc;
	output reg Branch;
	output reg RegWrite;
	output reg [1:0] RegDst;
	output reg MemRead;
	output reg MemWrite;
	output reg [1:0] MemtoReg;
	output reg ALUSrc1;
	output reg ALUSrc2;
	output reg ExtOp;
	output reg LuOp;

	always @(*) begin
		case(OpCode)
		6'b100011:begin //lw
		PCSrc <= 2'b01;
		Branch <= 1'b0;
		RegWrite <= 1'b1;
		RegDst <= 2'b01;
		MemRead <= 1'b1;
		MemWrite <= 1'b0;
		MemtoReg <= 2'b01;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b0;
		ExtOp <= 1'b1;
		LuOp <= 1'b0;
		end
		6'b101011:begin //sw
		PCSrc <= 2'b01;
		Branch <= 1'b0;
		RegWrite <= 1'b0;
		RegDst <= 2'bxx;
		MemRead <= 1'b0;
		MemWrite <= 1'b1;
		MemtoReg <= 2'bxx;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b0;
		ExtOp <= 1'b1;
		LuOp <= 1'b0;
		end
		6'b001111:begin //lui
		PCSrc <= 2'b01;
		Branch <= 1'b0;
		RegWrite <= 1'b1;
		RegDst <= 2'b01;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'b00;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b0;
		ExtOp <= 1'bx;
		LuOp <= 1'b1;
		end
		6'b001000:begin //addi
		PCSrc <= 2'b01;
		Branch <= 1'b0;
		RegWrite <= 1'b1;
		RegDst <= 2'b01;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'b00;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b0;
		ExtOp <= 1'b1;
		LuOp <= 1'b0;
		end
		6'b001001:begin //addiu
		PCSrc <= 2'b01;
		Branch <= 1'b0;
		RegWrite <= 1'b1;
		RegDst <= 2'b01;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'b00;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b0;
		ExtOp <= 1'b1;
		LuOp <= 1'b0;
		end
		6'b001100:begin //andi
		PCSrc <= 2'b01;
		Branch <= 1'b0;
		RegWrite <= 1'b1;
		RegDst <= 2'b01;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'b00;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b0;
		ExtOp <= 1'b0;
		LuOp <= 1'b0;
		end
		6'b001010:begin //slti
		PCSrc <= 2'b01;
		Branch <= 1'b0;
		RegWrite <= 1'b1;
		RegDst <= 2'b01;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'b00;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b0;
		ExtOp <= 1'b1;
		LuOp <= 1'b0;
		end
		6'b001011:begin //sltiu
		PCSrc <= 2'b01;
		Branch <= 1'b0;
		RegWrite <= 1'b1;
		RegDst <= 2'b01;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'b00;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b0;
		ExtOp <= 1'b1;
		LuOp <= 1'b0;
		end
		6'b000100:begin //beq
		PCSrc <= 2'b00;
		Branch <= 1'b1;
		RegWrite <= 1'b0;
		RegDst <= 2'bxx;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'bxx;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b1;
		ExtOp <= 1'b1;
		LuOp <= 1'b0;
		end
		6'b000101:begin //bne
		PCSrc <= 2'b00;
		Branch <= 1'b1;
		RegWrite <= 1'b0;
		RegDst <= 2'bxx;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'bxx;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b1;
		ExtOp <= 1'b1;
		LuOp <= 1'b0;
		end
		6'b000111:begin //bgtz
		PCSrc <= 2'b00;
		Branch <= 1'b1;
		RegWrite <= 1'b0;
		RegDst <= 2'bxx;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'bxx;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b1;
		ExtOp <= 1'b1;
		LuOp <= 1'b0;
		end
		6'b000110:begin //blez
		PCSrc <= 2'b00;
		Branch <= 1'b1;
		RegWrite <= 1'b0;
		RegDst <= 2'bxx;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'bxx;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b1;
		ExtOp <= 1'b1;
		LuOp <= 1'b0;
		end
		6'b000001:begin //bltz
		PCSrc <= 2'b00;
		Branch <= 1'b1;
		RegWrite <= 1'b0;
		RegDst <= 2'bxx;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'bxx;
		ALUSrc1 <= 1'b1;
		ALUSrc2 <= 1'b1;
		ExtOp <= 1'b1;
		LuOp <= 1'b0;
		end
		6'b000010:begin //j
		PCSrc <= 2'b10;
		Branch <= 1'b0;
		RegWrite <= 1'b0;
		RegDst <= 2'bxx;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'bxx;
		ALUSrc1 <= 1'bx;
		ALUSrc2 <= 1'bx;
		ExtOp <= 1'bx;
		LuOp <= 1'b0;
		end
		6'b000011:begin //jal
		PCSrc <= 2'b10;
		Branch <= 1'b0;
		RegWrite <= 1'b1;
		RegDst <= 2'b10;
		MemRead <= 1'b0;
		MemWrite <= 1'b0;
		MemtoReg <= 2'b10;
		ALUSrc1 <= 1'bx;
		ALUSrc2 <= 1'bx;
		ExtOp <= 1'bx;
		LuOp <= 1'b0;
		end
		6'b000000:begin //R型指�?
		    case(Funct)
			6'b100000:begin //add
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b1;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b100001:begin //addu
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b1;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b100010:begin //sub
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b1;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b100011:begin //subu
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b1;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b100100:begin //and
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b1;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b100101:begin //or
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b1;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b100110:begin //xor
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b1;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b100111:begin //nor
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b1;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b000000:begin //sll
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b0;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b000010:begin //srl
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b0;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b000011:begin //sra
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b0;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b101010:begin //slt
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b1;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b101011:begin //sltu
			PCSrc <= 2'b01;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b00;
		    ALUSrc1 <= 1'b1;
		    ALUSrc2 <= 1'b1;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b001000:begin //jr
			PCSrc <= 2'b11;
		    Branch <= 1'b0;
		    RegWrite <= 1'b0;
		    RegDst <= 2'bxx;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'bxx;
		    ALUSrc1 <= 1'bx;
		    ALUSrc2 <= 1'bx;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			6'b001001:begin //jalr
			PCSrc <= 2'b11;
		    Branch <= 1'b0;
		    RegWrite <= 1'b1;
		    RegDst <= 2'b00;
		    MemRead <= 1'b0;
		    MemWrite <= 1'b0;
		    MemtoReg <= 2'b10;
		    ALUSrc1 <= 1'bx;
		    ALUSrc2 <= 1'bx;
	    	ExtOp <= 1'bx;
	    	LuOp <= 1'b0;
			end
			endcase
		end
		endcase
	end
endmodule