`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: ZJU
// Engineer: tangyi
//
// Create Date:   15:49:50 10/29/2011
// Design Name:   ALU
// Module Name:   ALU_tb.v
// Project Name:  MipsPipelineCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module EX_tb_v;
  
  reg RegDst_ex;
  reg [4:0] ALUCode_ex;
  reg ALUSrcA_ex;
  reg ALUSrcB_ex;
  reg [31:0] Imm_ex;
  reg [31:0] Sa_ex;
  reg [4:0] RsAddr_ex;
  reg [4:0] RtAddr_ex;
  reg [4:0] RdAddr_ex;
  reg [31:0] RsData_ex;
  reg [31:0] RtData_ex;
  reg [31:0] RegWriteData_wb;
  reg [31:0] ALUResult_mem;
  reg [4:0] RegWriteAddr_wb;
  reg [4:0] RegWriteAddr_mem;
  reg RegWrite_wb;
  reg RegWrite_mem;
  wire [4:0] RegWriteAddr_ex;
  wire [31:0] ALUResult_ex;
  wire [31:0] MemWriteData_ex;
  wire [31:0] ALU_A;
  wire [31:0] ALU_B;

	// Instantiate the Unit Under Test (UUT)
	EX uut (
	   .RegDst_ex(RegDst_ex),
	   .ALUCode_ex(ALUCode_ex),
	   .ALUSrcA_ex(ALUSrcA_ex), ALUSrcB_ex, Imm_ex, Sa_ex, RsAddr_ex, RtAddr_ex, RdAddr_ex,
          RsData_ex, RtData_ex, RegWriteData_wb, ALUResult_mem, RegWriteAddr_wb, RegWriteAddr_mem, 
			 RegWrite_wb, RegWrite_mem, RegWriteAddr_ex, ALUResult_ex, MemWriteData_ex, ALU_A, ALU_B);

	initial begin
		// Initialize Inputs
		ALUCode = 5'd0; A = 32'h00004012; B = 32'h1000200F;//add
		      
		// Add stimulus here
		#100 ALUCode = 5'd0;	A = 32'h40000000;	B = 32'h40000000;//add
		#100 ALUCode = 5'd1;	A = 32'hFF0C0E10;	B = 32'h10DF30FF;//and
		#100 ALUCode = 5'd2;	A = 32'hFF0C0E10;	B = 32'h10DF30FF;//xor
		#100 ALUCode = 5'd3;	A = 32'hFF0C0E10;	B = 32'h10DF30FF;//or
		#100 ALUCode = 5'd4;	A = 32'hFF0C0E10;	B = 32'h10DF30FF;//nor
		#100 ALUCode = 5'd5;	A = 32'h70F0C0E0;	B = 32'h10003054;//sub
		#100 ALUCode = 5'd6;	A = 32'hFF0C0E10;	B = 32'hFFFFE0FF;//andi
		#100 ALUCode = 5'd7;	A = 32'hFF0C0E10;	B = 32'hFFFFE0FF;//xori
		#100 ALUCode = 5'd8;	A = 32'hFF0C0E10;	B = 32'hFFFFE0FF;//ori
				
		#100 ALUCode = 5'd16;A = 32'h00000004;	B = 32'hFFFFE0FF;//sll
		#100 ALUCode = 5'd17;A = 32'h00000004;	B = 32'hFFFFE0FF;//srl
		#100 ALUCode = 5'd18;A = 32'h00000004;	B = 32'hFFFFE0FF;//sra
		#100 ALUCode = 5'd19;A = 32'hFF000004;	B = 32'h700000FF;//slt
		#100 ALUCode = 5'd20;A = 32'hFF000004;	B = 32'h700000FF;//sltu
		#100 $stop;

	end
      
endmodule

