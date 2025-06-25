module test_cpu_2();
	
	reg reset;
	reg clk;
	
	Pipeline cpu1(reset, clk);
	
	initial begin
		forever #50 clk = ~clk;
	end

	initial begin
		reset = 1;
		clk = 1;
		#100 reset = 0;
		// str
		cpu1.Mem_Data.RAM_data[0] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[1] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[2] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[3] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[4] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[5] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[6] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[7] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[8] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[9] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[10] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[11] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[12] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[13] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[14] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[15] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[16] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[17] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[18] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[19] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[20] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[21] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[22] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[23] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[24] <= {24'b0, 8'h62};//b
		//pattern
		cpu1.Mem_Data.RAM_data[256] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[257] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[258] <= {24'b0, 8'h61};//a
		cpu1.Mem_Data.RAM_data[259] <= {24'b0, 8'h62};//b
		cpu1.Mem_Data.RAM_data[260] <= {24'b0, 8'h61};//a
		// Regs
		cpu1.Regs.RF_data[5] <= 32'h00000000; // a1为str首地址
		cpu1.Regs.RF_data[7] <= 32'h00000400; // a3为pattern首地址
		cpu1.Regs.RF_data[11] <= 32'h00000800; // t3为next数组首地址
		cpu1.Regs.RF_data[29] <= 32'h00000fff; // 初始化栈指针
	end
	
endmodule
