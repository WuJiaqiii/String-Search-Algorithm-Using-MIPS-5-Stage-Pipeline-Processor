module ALU(ALUConf, Sign, In1, In2, Result);
    // Control Signals
    input [4:0] ALUConf;
    input Sign;
    // Input Data Signals
    input [31:0] In1;
    input [31:0] In2;
    // Output 
    output reg [31:0] Result;

    //--------------Your code below-----------------------

    parameter add = 5'b00000;
    parameter sub = 5'b00001;
    parameter And = 5'b00010;
    parameter Or  = 5'b00011;
    parameter Xor = 5'b00100;
    parameter Nor = 5'b00101;
    parameter sll = 5'b00110;
    parameter srl = 5'b00111;
    parameter sra = 5'b01000;
    parameter slt = 5'b01001;
    
always @(*) begin 
    case(ALUConf)
    add : begin Result <= In1 + In2;            end
    sub : begin Result <= In1 + ~In2 + 1 ;      end
    And : begin Result <= In1 & In2;            end
    Or  : begin Result <= In1 | In2;            end
    Xor : begin Result <= In1 ^ In2;            end
    Nor : begin Result <= ~(In1 | In2);         end
    sll : begin Result <= In2 << In1;           end
    srl : begin Result <= In2 >> In1;           end
    sra : begin Result <= $signed(In2) >>> In1; end
    slt : begin
        if(Sign == 0) Result <= (In1 < In2)? 1:0;
        else Result <= (In1[31] ^ In2[31])? In1[31] : (In1[30:0] < In2[30:0]);
    end
    endcase
end
    //--------------Your code above-----------------------

endmodule
