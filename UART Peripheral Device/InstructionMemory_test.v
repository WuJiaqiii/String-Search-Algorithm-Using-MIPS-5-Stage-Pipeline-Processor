module InstructionMemory_test(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			8'd0: Instruction <= 32'h20090001;
            8'd1: Instruction <= 32'h23bdfffc;
            8'd2: Instruction <= 32'hafa90000;
            8'd3: Instruction <= 32'h8faa0000;
            8'd4: Instruction <= 32'h11400001;
            8'd5: Instruction <= 32'h20020001;
            8'd6: Instruction <= 32'h00000000;
            8'd7: Instruction <= 32'h00000000;	
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule