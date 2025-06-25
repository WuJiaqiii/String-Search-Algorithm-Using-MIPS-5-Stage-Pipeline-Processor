module DataMemory(
	reset, 
	clk, 
	Address, 
	Write_data, 
	Read_data, 
	MemRead, 
	MemWrite,
	LEDs,
	BCDs,
	Counter,
	UART_TXD,
	UART_RXD,
	UART_CON
	);

	input reset, clk;
	input [31:0] Address, Write_data;
	input MemRead, MemWrite;
	output [31:0] Read_data;
	output reg [7:0] LEDs;
	output reg [11:0] BCDs; 
	output reg [31:0] Counter;

	output reg [7:0] UART_TXD;
	output reg [7:0] UART_RXD;
	output reg [3:0] UART_CON;
	
	parameter RAM_SIZE = 1024;
	parameter RAM_SIZE_BIT = 30;
	integer i;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];

	assign Read_data = MemRead? ((Address == 32'h4000000C)? {24'b0, LEDs}:
	                             (Address == 32'h40000010)? {20'b0, BCDs}:
								 (Address == 32'h40000014)? Counter:  
								 (Address == 32'h40000018)? {24'b0, UART_TXD}:
								 (Address == 32'h4000001C)? {24'b0, UART_RXD}:
								 (Address == 32'h40000020)? {28'b0, UART_CON}:   
		                          RAM_data[Address[RAM_SIZE_BIT + 1:2]]
								): 32'h00000000;

	always @(posedge reset or posedge clk) begin
		if (reset) begin
			//str
			RAM_data[0] <= {24'b0, 8'h61};//a
		    RAM_data[1] <= {24'b0, 8'h62};//b
		    RAM_data[2] <= {24'b0, 8'h61};//a
		    RAM_data[3] <= {24'b0, 8'h61};//a
		    RAM_data[4] <= {24'b0, 8'h61};//a
		    RAM_data[5] <= {24'b0, 8'h62};//b
		    RAM_data[6] <= {24'b0, 8'h61};//a
		    RAM_data[7] <= {24'b0, 8'h62};//b
		    RAM_data[8] <= {24'b0, 8'h62};//b
		    RAM_data[9] <= {24'b0, 8'h61};//a
		    RAM_data[10] <= {24'b0, 8'h62};//b
		    RAM_data[11] <= {24'b0, 8'h61};//a
		    RAM_data[12] <= {24'b0, 8'h62};//b
		    RAM_data[13] <= {24'b0, 8'h61};//a
		    RAM_data[14] <= {24'b0, 8'h62};//b
		    RAM_data[15] <= {24'b0, 8'h61};//a
		    RAM_data[16] <= {24'b0, 8'h61};//a
		    RAM_data[17] <= {24'b0, 8'h62};//b
		    RAM_data[18] <= {24'b0, 8'h61};//a
		    RAM_data[19] <= {24'b0, 8'h62};//b
		    RAM_data[20] <= {24'b0, 8'h61};//a
		    RAM_data[21] <= {24'b0, 8'h62};//b
		    RAM_data[22] <= {24'b0, 8'h62};//b
		    RAM_data[23] <= {24'b0, 8'h61};//a
		    RAM_data[24] <= {24'b0, 8'h62};//b

			for (i = 25; i < 256; i = i + 1)
				RAM_data[i] <= 32'h00000000;

			//pattern
		    RAM_data[256] <= {24'b0, 8'h61};//a
		    RAM_data[257] <= {24'b0, 8'h62};//b
		    RAM_data[258] <= {24'b0, 8'h61};//a
		    RAM_data[259] <= {24'b0, 8'h62};//b
		    RAM_data[260] <= {24'b0, 8'h61};//a

			for (i = 261; i < RAM_SIZE; i = i + 1)
				RAM_data[i] <= 32'h00000000;

			LEDs <= 8'b0;
			BCDs <= 12'b0;
			Counter <= 32'b0;
			UART_CON <= 32'b0;
			UART_RXD <= 32'b0;
			UART_TXD <= 32'b0;
		end
		else begin
		    Counter <= Counter + 1;
		    if (MemWrite) begin
			    case(Address)
			    32'h4000000C: LEDs <= Write_data[7:0];
			    32'h40000010: BCDs <= Write_data[11:0];
				32'h40000018: UART_TXD <= Write_data;
				32'h4000001C: UART_RXD <= Write_data;
				32'h40000020: UART_CON <= Write_data;
		        default: RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
			    endcase
		    end
		end
	end
endmodule