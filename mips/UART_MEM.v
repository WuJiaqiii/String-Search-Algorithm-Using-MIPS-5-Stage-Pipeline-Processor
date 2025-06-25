`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: THU EE 
// 
// Create Date: 2019/05/08 17:29:33
// Design Name: 
// Module Name: UART_MEM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART_MEM(
    input clk,      // 100MHz
    input rst,      // BTNU 
    input mem2uart, // SW0     
    /*---------------------------MEM--------------------------------*/
    output reg recv_done,   // led 0 
    output reg recv1_done,
    output reg recv2_done,
    output reg send_done,   // led 1     
    /*---------------------------UART-------------------------------*/
    input Rx_Serial,
    output Tx_Serial
    );
    reg [1:0] count;
    parameter CLKS_PER_BIT = 16'd10417;  // 100M/9600
    parameter MEM_SIZE = 512;
    
    
    /*--------------------------------UART RX-------------------------*/
    wire Rx_DV;
    wire [7:0] Rx_Byte;
    
    uart_rx #(.CLKS_PER_BIT(CLKS_PER_BIT)) uart_rx_inst
        (.i_Clock(clk),
         .i_Rx_Serial(Rx_Serial),
         .o_Rx_DV(Rx_DV),
         .o_Rx_Byte(Rx_Byte)
         );
         
    /*--------------------------------UART TX-------------------------*/
    reg Tx_DV;
    reg [7:0] Tx_Byte;
    wire Tx_Active;
    wire Tx_Done;
    
    uart_tx #(.CLKS_PER_BIT(CLKS_PER_BIT)) uart_tx_inst
        (.i_Clock(clk),
         .i_Tx_DV(Tx_DV),
         .i_Tx_Byte(Tx_Byte),
         .o_Tx_Active(Tx_Active),
         .o_Tx_Serial(Tx_Serial),
         .o_Tx_Done(Tx_Done)
         );
         
    /*----------------------------------MEM----------------------------*/
    // instruction memory
    reg [15:0] addr0;
    reg rd_en0;
    reg wr_en0;
    wire [31:0] rdata0;
    reg [31:0] wdata0;
    
    mem #(.MEM_SIZE(MEM_SIZE)) mem0 (
        .clk(clk),  
        .addr(addr0), 
        .rd_en(rd_en0), 
        .wr_en(wr_en0), 
        .rdata(rdata0), 
        .wdata(wdata0)
        );
        
    // data memory
    reg [15:0] addr1;
    reg rd_en1;
    reg wr_en1;
    wire [31:0] rdata1;
    reg [31:0] wdata1;
        
    mem #(.MEM_SIZE(MEM_SIZE)) mem1 (
        .clk(clk), 
        .addr(addr1), 
        .rd_en(1'b1), 
        .wr_en(wr_en1), 
        .rdata(rdata1), 
        .wdata(wdata1)
        );
        
    /*----------------------------------MEM Control----------------------------*/
    
    reg [2:0] byte_cnt;
    reg [31:0] word;
    //reg recv_done;
    reg [31:0] cntByteTime;
    //reg send_done;
    
    always@(posedge clk)begin
        if(rst)begin
            addr0 <= 16'd0;
            rd_en0 <= 1'b0;
            wr_en0 <= 1'b0;
            wdata0 <= 32'd0;
            addr1 <= 16'd0;
            rd_en1 <= 1'b0;
            wr_en1 <= 1'b0;
            wdata1 <= 32'd0;
            byte_cnt <= 3'd0;
            word <= 32'd0;
            recv_done <= 1'b0;
            cntByteTime <= 32'd0;
            count <= 2'd0;
            recv1_done <= 1'b0;
            recv2_done <= 1'b0;
            
            Tx_DV <= 1'b0;
            Tx_Byte <= 8'd0;
            send_done <= 1'b0;

        end
        else
        begin
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
            if(mem2uart == 1'b1)
            begin
                if(cntByteTime == CLKS_PER_BIT*20 && send_done==1'b0)begin  // 1Byte time
                    cntByteTime <= 32'd0;
                    
                    if(addr1 != 16'd0) Tx_DV <= 1'b1;
                    if(byte_cnt==3'd0) Tx_Byte <= rdata1[7:0];
                    else if(byte_cnt==3'd1) Tx_Byte <= rdata1[15:8];
                    else if(byte_cnt==3'd2) Tx_Byte <= rdata1[23:16];
                    else if(byte_cnt==3'd3) Tx_Byte <= rdata1[31:24];
                    else;
                    
                    if(byte_cnt == 3'd3)begin
                        byte_cnt <= 3'd0;
                        
                        if(addr1 < MEM_SIZE)begin
                            addr1 <= addr1+1'b1;
                        end
                        else begin
                            send_done <= 1'b1;
                        end
                        
                    end
                    else begin
                        byte_cnt <= byte_cnt+1'b1;    
                    end
                    
                end
                else begin
                    cntByteTime <= cntByteTime+1'b1;         
                    Tx_DV <= 1'b0;
                end
            end       
        end
    end
endmodule
