module test_top();

    reg System_clk;
    reg BTNU;
    wire [3:0] ano;
    wire [7:0] BCDs;
    wire [7:0] LEDs;
	
	top top_0
	(
		.System_clk(System_clk),
		.BTNU(BTNU),
		.ano(ano),
		.BCDs(BCDs),
		.LEDs(LEDs)
	);
	
	initial begin
		forever #50 System_clk = ~System_clk;
	end

	initial
    begin
		System_clk = 1;
        BTNU = 1;
        #100 BTNU = 0;
		//str
        top_0.cpu.Mem_Data.RAM_data[0] <= {24'b0, 8'h6c};//l
		top_0.cpu.Mem_Data.RAM_data[1] <= {24'b0, 8'h69};//i
		top_0.cpu.Mem_Data.RAM_data[2] <= {24'b0, 8'h6e};//n
		top_0.cpu.Mem_Data.RAM_data[3] <= {24'b0, 8'h75};//u
		top_0.cpu.Mem_Data.RAM_data[4] <= {24'b0, 8'h78};//x
		top_0.cpu.Mem_Data.RAM_data[5] <= {24'b0, 8'h20};// 
		top_0.cpu.Mem_Data.RAM_data[6] <= {24'b0, 8'h69};//i
		top_0.cpu.Mem_Data.RAM_data[7] <= {24'b0, 8'h73};//s
		top_0.cpu.Mem_Data.RAM_data[8] <= {24'b0, 8'h20};// 
		top_0.cpu.Mem_Data.RAM_data[9] <= {24'b0, 8'h6e};//n
		top_0.cpu.Mem_Data.RAM_data[10] <= {24'b0, 8'h6f};//o
		top_0.cpu.Mem_Data.RAM_data[11] <= {24'b0, 8'h74};//t
		top_0.cpu.Mem_Data.RAM_data[12] <= {24'b0, 8'h20};//
		top_0.cpu.Mem_Data.RAM_data[13] <= {24'b0, 8'h75};//u
		top_0.cpu.Mem_Data.RAM_data[14] <= {24'b0, 8'h6e};//n
		top_0.cpu.Mem_Data.RAM_data[15] <= {24'b0, 8'h69};//i
		top_0.cpu.Mem_Data.RAM_data[16] <= {24'b0, 8'h78};//x
		top_0.cpu.Mem_Data.RAM_data[17] <= {24'b0, 8'h20};// 
		top_0.cpu.Mem_Data.RAM_data[18] <= {24'b0, 8'h69};//i
		top_0.cpu.Mem_Data.RAM_data[19] <= {24'b0, 8'h73};//s
		top_0.cpu.Mem_Data.RAM_data[20] <= {24'b0, 8'h20};// 
		top_0.cpu.Mem_Data.RAM_data[21] <= {24'b0, 8'h6e};//n
		top_0.cpu.Mem_Data.RAM_data[22] <= {24'b0, 8'h6f};//o
		top_0.cpu.Mem_Data.RAM_data[23] <= {24'b0, 8'h74};//t
		top_0.cpu.Mem_Data.RAM_data[24] <= {24'b0, 8'h20};//
		top_0.cpu.Mem_Data.RAM_data[25] <= {24'b0, 8'h75};//u
		top_0.cpu.Mem_Data.RAM_data[26] <= {24'b0, 8'h6e};//n
		top_0.cpu.Mem_Data.RAM_data[27] <= {24'b0, 8'h69};//i
		top_0.cpu.Mem_Data.RAM_data[28] <= {24'b0, 8'h78};//x
		top_0.cpu.Mem_Data.RAM_data[29] <= {24'b0, 8'h20};// 
		top_0.cpu.Mem_Data.RAM_data[30] <= {24'b0, 8'h69};//i
		top_0.cpu.Mem_Data.RAM_data[31] <= {24'b0, 8'h73};//s
		top_0.cpu.Mem_Data.RAM_data[32] <= {24'b0, 8'h20};// 
		top_0.cpu.Mem_Data.RAM_data[33] <= {24'b0, 8'h6e};//n
		top_0.cpu.Mem_Data.RAM_data[34] <= {24'b0, 8'h6f};//o
		top_0.cpu.Mem_Data.RAM_data[35] <= {24'b0, 8'h74};//t
		top_0.cpu.Mem_Data.RAM_data[36] <= {24'b0, 8'h20};//
		top_0.cpu.Mem_Data.RAM_data[37] <= {24'b0, 8'h75};//u
		top_0.cpu.Mem_Data.RAM_data[38] <= {24'b0, 8'h6e};//n
		top_0.cpu.Mem_Data.RAM_data[39] <= {24'b0, 8'h69};//i
		top_0.cpu.Mem_Data.RAM_data[40] <= {24'b0, 8'h78};//x
		//pattern
		top_0.cpu.Mem_Data.RAM_data[256] <= {24'b0, 8'h75};//u
		top_0.cpu.Mem_Data.RAM_data[257] <= {24'b0, 8'h6e};//n
		top_0.cpu.Mem_Data.RAM_data[258] <= {24'b0, 8'h69};//i
		top_0.cpu.Mem_Data.RAM_data[259] <= {24'b0, 8'h78};//x
		// Regs
		top_0.cpu.Regs.RF_data[5] <= 32'h00000000; // a1为str首地址
		top_0.cpu.Regs.RF_data[7] <= 32'h00000400; // a3为pattern首地址
		top_0.cpu.Regs.RF_data[11] <= 32'h00000800; // t3为next数组首地址
		top_0.cpu.Regs.RF_data[29] <= 32'h00000fff; // 初始化栈指针
    end
	
endmodule
