`timescale 1ns / 1ps
module ID_tb_v;

	// Inputs
	  reg clk;
	  reg [31:0] Instruction_id;
    reg [31:0] NextPC_id;
    reg RegWrite_wb;
    reg [4:0] RegWriteAddr_wb;
    reg [31:0] RegWriteData_wb;
    reg MemRead_ex;
    reg [4:0] RegWriteAddr_ex;
    wire MemtoReg_id;
    wire RegWrite_id;
    wire MemWrite_id;
    wire MemRead_id;
    wire [4:0] ALUCode_id;
    wire ALUSrcA_id;
    wire ALUSrcB_id;
    wire RegDst_id;
    wire Stall;
    wire Z;
    wire J;
    wire JR;
    wire PC_IFWrite;
    wire [31:0] BranchAddr;
    wire [31:0] JumpAddr;
    wire [31:0] JrAddr;
    wire [31:0] Imm_id;
    wire [31:0] Sa_id;
    wire [31:0] RsData_id;
    wire [31:0] RtData_id;
    wire [4:0] RsAddr_id;
    wire [4:0] RtAddr_id;
    wire [4:0] RdAddr_id;

	// Instantiate the Unit Under Test (UUT)
	ID uut (
	     .clk(clk),
	     .Instruction_id(Instruction_id),
	     .NextPC_id(NextPC_id),
	     .RegWrite_wb(RegWrite_wb),
	     .RegWriteAddr_wb(RegWriteAddr_wb),
	     .RegWriteData_wb(RegWriteData_wb),
	     .MemRead_ex(MemRead_ex), 
       .RegWriteAddr_ex(RegWriteAddr_ex),
       .MemtoReg_id(MemtoReg_id),
       .RegWrite_id(RegWrite_id),
       .MemWrite_id(MemWrite_id),
       .MemRead_id(MemRead_id),
       .ALUCode_id(ALUCode_id), 
			 .ALUSrcA_id(ALUSrcA_id),
			 .ALUSrcB_id(ALUSrcB_id),
			 .RegDst_id(RegDst_id),
			 .Stall(Stall),
			 .Z(Z),
			 .J(J),
			 .JR(JR),
			 .PC_IFWrite(PC_IFWrite),
			 .BranchAddr(BranchAddr),
			 .JumpAddr(JumpAddr),
			 .JrAddr(JrAddr),
			 .Imm_id(Imm_id),
			 .Sa_id(Sa_id),
			 .RsData_id(RsData_id),
			 .RtData_id(RtData_id),
			 .RsAddr_id(RsAddr_id),
			 .RtAddr_id(RtAddr_id),
			 .RdAddr_id(RdAddr_id)
  );

	initial begin
		// Initialize Inputs
		clk=0;
		NextPC_id=0;
		RegWrite_wb=1;RegWriteAddr_wb=5'b01111;RegWriteData_wb=32'b1111;
		MemRead_ex=0;RegWriteAddr_ex=5'b0;
		Instruction_id = 32'h0800000b;//j later(later address is 2Ch)		
        
		// Add stimulus here
		#100 Instruction_id = 32'h20080042;//addi $t0,$0,42
		#100 Instruction_id = 32'h01095022;//sub $t2,$t0,$t1
		#100 Instruction_id = 32'h01485825;//or $t3,$t2,$t0
		#100 Instruction_id = 32'hac0b000c;//sw $t3,0C($0)
		#100 Instruction_id = 32'h8d2c0008;//lw $t4,08($t1)
		#100 Instruction_id = 32'h000c4080;//sll $t0,$t4,2		
		#100 Instruction_id = 32'h012a582b;//sltu $t3,$t1,$t2		
		#100 Instruction_id = 32'h14000001;//bne $0,$0,end(end address is 34h)
		#100 Instruction_id = 32'h1000fff4;//beq $0,$0,earlier(earlier address is 4h)			
   	#100 $stop;
	end
	always #50 clk=~clk;
      
endmodule