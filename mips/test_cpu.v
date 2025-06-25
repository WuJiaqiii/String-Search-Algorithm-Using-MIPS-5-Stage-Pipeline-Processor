`timescale 1ns / 1ps
`define PERIOD 10000
module test_cpu();
	
	reg reset;
	reg clk;
	reg Rx_Serial;
	wire [7:0] LEDs;
	wire [7:0] BCDs;
	wire [3:0] ano;
	wire Tx_Serial;

	reg [7:0] Input [31:0];
	
	Pipeline cpu1
	(
		.reset(reset),
		.clk(clk),
		.LEDs(LEDs),
		.BCDs(BCDs),
		.ano(ano),
		.Rx_Serial(Rx_Serial),
		.Tx_Serial(Tx_Serial)
	);
	
	initial begin
		forever #(`PERIOD/2) clk = ~clk;
	end

	integer i, j;

	initial begin
		reset = 1;
		clk = 0;
    	Rx_Serial = 1;
    	Input [0] <= 8'h61;
    	Input [1] <= 8'h62;
    	Input [2] <= 8'h61;
    	Input [3] <= 8'h61;
    	Input [4] <= 8'h61;
    	Input [5] <= 8'h62;
    	Input [6] <= 8'h61;
    	Input [7] <= 8'h62;
    	Input [8] <= 8'h62;
    	Input [9] <= 8'h61;
    	Input [10] <= 8'h62;
    	Input [11] <= 8'h61;
    	Input [12] <= 8'h62;
    	Input [13] <= 8'h61;
    	Input [14] <= 8'h62;
    	Input [15] <= 8'h61;
    	Input [16] <= 8'h61;
    	Input [17] <= 8'h62;
    	Input [18] <= 8'h61;
    	Input [19] <= 8'h62;
		Input [20] <= 8'h61;
		Input [21] <= 8'h62;
    	Input [22] <= 8'h62;
    	Input [23] <= 8'h61;
    	Input [24] <= 8'h62;
		Input [25] <= 8'd10;
		Input [26] <= 8'h61;
    	Input [27] <= 8'h62;
    	Input [28] <= 8'h61;
    	Input [29] <= 8'h62;
		Input [30] <= 8'h61;
		Input [31] <= 8'd10;
    	#(`PERIOD * 50) reset = 1'b0;
    	for(i = 0; i < 32; i = i + 1) 
    	begin
        	#(`PERIOD * 100) Rx_Serial <= 0;
        	for(j = 0; j < 8; j = j + 1)
        	begin
        	#(`PERIOD * 100) Rx_Serial <= Input[i][j];
        	end
        	#(`PERIOD * 100) Rx_Serial <= 1;
    	end
		
	end
	
endmodule


// // str
		// cpu1.Mem_Data.RAM_data[0] <= {24'b0, 8'h6c};//l
		// cpu1.Mem_Data.RAM_data[1] <= {24'b0, 8'h69};//i
		// cpu1.Mem_Data.RAM_data[2] <= {24'b0, 8'h6e};//n
		// cpu1.Mem_Data.RAM_data[3] <= {24'b0, 8'h75};//u
		// cpu1.Mem_Data.RAM_data[4] <= {24'b0, 8'h78};//x
		// cpu1.Mem_Data.RAM_data[5] <= {24'b0, 8'h20};// 
		// cpu1.Mem_Data.RAM_data[6] <= {24'b0, 8'h69};//i
		// cpu1.Mem_Data.RAM_data[7] <= {24'b0, 8'h73};//s
		// cpu1.Mem_Data.RAM_data[8] <= {24'b0, 8'h20};// 
		// cpu1.Mem_Data.RAM_data[9] <= {24'b0, 8'h6e};//n
		// cpu1.Mem_Data.RAM_data[10] <= {24'b0, 8'h6f};//o
		// cpu1.Mem_Data.RAM_data[11] <= {24'b0, 8'h74};//t
		// cpu1.Mem_Data.RAM_data[12] <= {24'b0, 8'h20};//
		// cpu1.Mem_Data.RAM_data[13] <= {24'b0, 8'h75};//u
		// cpu1.Mem_Data.RAM_data[14] <= {24'b0, 8'h6e};//n
		// cpu1.Mem_Data.RAM_data[15] <= {24'b0, 8'h69};//i
		// cpu1.Mem_Data.RAM_data[16] <= {24'b0, 8'h78};//x
		// cpu1.Mem_Data.RAM_data[17] <= {24'b0, 8'h20};// 
		// cpu1.Mem_Data.RAM_data[18] <= {24'b0, 8'h69};//i
		// cpu1.Mem_Data.RAM_data[19] <= {24'b0, 8'h73};//s
		// cpu1.Mem_Data.RAM_data[20] <= {24'b0, 8'h20};// 
		// cpu1.Mem_Data.RAM_data[21] <= {24'b0, 8'h6e};//n
		// cpu1.Mem_Data.RAM_data[22] <= {24'b0, 8'h6f};//o
		// cpu1.Mem_Data.RAM_data[23] <= {24'b0, 8'h74};//t
		// cpu1.Mem_Data.RAM_data[24] <= {24'b0, 8'h20};//
		// cpu1.Mem_Data.RAM_data[25] <= {24'b0, 8'h75};//u
		// cpu1.Mem_Data.RAM_data[26] <= {24'b0, 8'h6e};//n
		// cpu1.Mem_Data.RAM_data[27] <= {24'b0, 8'h69};//i
		// cpu1.Mem_Data.RAM_data[28] <= {24'b0, 8'h78};//x
		// cpu1.Mem_Data.RAM_data[29] <= {24'b0, 8'h20};// 
		// cpu1.Mem_Data.RAM_data[30] <= {24'b0, 8'h69};//i
		// cpu1.Mem_Data.RAM_data[31] <= {24'b0, 8'h73};//s
		// cpu1.Mem_Data.RAM_data[32] <= {24'b0, 8'h20};// 
		// cpu1.Mem_Data.RAM_data[33] <= {24'b0, 8'h6e};//n
		// cpu1.Mem_Data.RAM_data[34] <= {24'b0, 8'h6f};//o
		// cpu1.Mem_Data.RAM_data[35] <= {24'b0, 8'h74};//t
		// cpu1.Mem_Data.RAM_data[36] <= {24'b0, 8'h20};//
		// cpu1.Mem_Data.RAM_data[37] <= {24'b0, 8'h75};//u
		// cpu1.Mem_Data.RAM_data[38] <= {24'b0, 8'h6e};//n
		// cpu1.Mem_Data.RAM_data[39] <= {24'b0, 8'h69};//i
		// cpu1.Mem_Data.RAM_data[40] <= {24'b0, 8'h78};//x
		// //pattern
		// cpu1.Mem_Data.RAM_data[256] <= {24'b0, 8'h75};//u
		// cpu1.Mem_Data.RAM_data[257] <= {24'b0, 8'h6e};//n
		// cpu1.Mem_Data.RAM_data[258] <= {24'b0, 8'h69};//i
		// cpu1.Mem_Data.RAM_data[259] <= {24'b0, 8'h78};//x
		// // Regs
		// cpu1.Regs.RF_data[5] <= 32'h00000000; // a1为str首地址
		// cpu1.Regs.RF_data[7] <= 32'h00000400; // a3为pattern首地址
		// cpu1.Regs.RF_data[11] <= 32'h00000800; // t3为next数组首地址
		// cpu1.Regs.RF_data[29] <= 32'h00000fff; // 初始化栈指针