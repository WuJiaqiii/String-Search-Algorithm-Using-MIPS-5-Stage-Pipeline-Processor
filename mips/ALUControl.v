module ALUControl
(
    OpCode,
    Funct, 
    ALUConf, 
    Sign
);
	input [5:0] OpCode;
	input [5:0] Funct;
	output reg [4:0] ALUConf;
	output reg Sign;

    always@(*) begin

    case(OpCode)

        6'h0:begin
        case(Funct)
        6'b100000 :begin //add
        ALUConf <= 5'b00000;
        Sign <= 1;
        end
        6'b100001 :begin //addu
        ALUConf <= 5'b00000;
        Sign <= 0;
        end
        6'b100010 :begin //sub
        ALUConf <= 5'b00001;
        Sign <= 1;
        end
        6'b100011 :begin //subu
        ALUConf <= 5'b00001;
        Sign <= 0;
        end
        6'b100100 :begin //and
        ALUConf <= 5'b00010;
        Sign <= 0;
        end
        6'b100101 :begin //or
        ALUConf <= 5'b00011;
        Sign <= 0;
        end
        6'b100110 :begin //xor
        ALUConf <= 5'b00100;
        Sign <= 0;
        end
        6'b100111 :begin //nor
        ALUConf <= 5'b00101;
        Sign <= 0;
        end
        6'b000000 :begin //sll
        ALUConf <= 5'b00110;
        Sign <= 0;
        end
        6'b000010 :begin //srl
        ALUConf <= 5'b00111;
        Sign <= 0;
        end
        6'b000011 :begin //sra
        ALUConf <= 5'b01000;
        Sign <= 0;
        end
        6'b101010 :begin //slt
        ALUConf <= 5'b01001;
        Sign <= 1;
        end
        6'b101011 :begin //sltu
        ALUConf <= 5'b01001;
        Sign <= 0;
        end
        6'b101011 :begin //jr
        ALUConf <= 5'b00000;
        Sign <= 0;
        end
        6'b101011 :begin //jalr
        ALUConf <= 5'b00000;
        Sign <= 0;
        end
        endcase
        end

        6'h23,6'h2b,6'h08,6'h09,6'h0f:begin
        ALUConf <= 5'b00000;
        Sign <= 0;
        end

        6'h0c: begin
        ALUConf <= 5'b00010;
        Sign <= 0;
        end

        6'h0a: begin
        ALUConf <= 5'b01001;
        Sign <= 1;
        end

        6'h0b: begin
        ALUConf <= 5'b01001;
        Sign <= 0;
        end
        
        default:begin
	    ALUConf <= 5'b11111;
        Sign <= 0;
	end
    endcase
    end
endmodule
