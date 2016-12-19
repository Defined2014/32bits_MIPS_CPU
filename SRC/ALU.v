//******************************************************************************
// MIPS verilog model
//
// ALU.v
//
// The ALU performs all the arithmetic/logical integer operations 
// specified by the ALUsel from the decoder. 
// 
// verilog written QMJ
// modified by 
// modified by 
//
//******************************************************************************

module ALU (
	// Outputs
	Result,overflow,
	// Inputs
	ALUCode, A, B
);

	input [4:0]	ALUCode;				// Operation select
	input [31:0]	A, B;

	output reg [31:0]	Result;
	output reg overflow;
  wire Binvert;
	reg [31:0] add_B;
	wire [31:0] sum;
	wire co;

//******************************************************************************
// Shift operation: ">>>" will perform an arithmetic shift, but the operand
// must be reg signed
//******************************************************************************
	reg signed [31:0] B_reg;
	
	
	always @(B) begin
		B_reg = B;
	end
	
  adder_32bits add(.a(A),.b(add_B),.ci(Binvert),.s(sum),.co(co));
	select_Binvert  select_binvert(.ALUCode(ALUCode),.Binvert(Binvert)); 
// Decoded ALU operation select (ALUsel) signals
   parameter	 alu_add=  5'b00000;
   parameter	 alu_and=  5'b00001;
   parameter	 alu_xor=  5'b00010;
   parameter	 alu_or =  5'b00011;
   parameter	 alu_nor=  5'b00100;
   parameter	 alu_sub=  5'b00101;
   parameter	 alu_andi= 5'b00110;
	 parameter	 alu_xori= 5'b00111;
	 parameter	 alu_ori = 5'b01000;
	 parameter  alu_jr =  5'b01001;
	 parameter	 alu_beq=  5'b01010;
   parameter	 alu_bne=  5'b01011;
	 parameter	 alu_bgez= 5'b01100;
   parameter	 alu_bgtz= 5'b01101;
   parameter	 alu_blez= 5'b01110;
   parameter	 alu_bltz= 5'b01111;
	 parameter 	alu_sll=  5'b10000;
	 parameter	 alu_srl=  5'b10001;
	 parameter	 alu_sra=  5'b10010;	
	 parameter	 alu_slt=  5'b10011;
   parameter	 alu_sltu= 5'b10100;
   
   
   
	always @(*) begin
	  if(Binvert===0)
	    add_B=B;
	  else
	    add_B=~B;
	  
		case(ALUCode)
		  alu_add: Result=sum;
		  alu_and: Result=A & B;
		  alu_xor: Result=A ^ B;
		  alu_or : Result=A | B;
		  alu_nor: Result=~(A|B);
		  alu_sub: Result=sum;
		  alu_andi: Result=A&{16'b0,B[15:0]};
		  alu_xori: Result=A^{16'b0,B[15:0]};
		  alu_ori: Result=A|{16'b0,B[15:0]};
		  alu_jr: Result=A;
      alu_beq: overflow=~(|sum[31:0]);
      alu_bne: overflow=(|sum[31:0]);
      alu_bgez: overflow=~A[31];
      alu_bgtz: overflow=~A[31] && (|A[31:0]);
      alu_blez: overflow=A[31] || ~(|A[31:0]);
      alu_bltz: overflow=A[31];
		  alu_sll: Result=B<<A;
		  alu_srl: Result=B>>A;
		  alu_sra: Result=B>>>A;
		  alu_slt: Result=(A[31]&&(~B[31]))||((A[31]~^B[31])&&sum[31]);
		  alu_sltu: Result=((~A[31])&&B[31])||((A[31]~^B[31])&&sum[31]);
		  default: 
		  begin
		  Result=32'b0;
		  overflow=0;
		  end 
		endcase
	end
   
   

	
//******************************************************************************
// ALU Result datapath
//******************************************************************************		
endmodule

module select_Binvert(
  ALUCode,
  Binvert
);
  input [4:0] ALUCode;
  output Binvert;
  parameter	 alu_add=  5'b00000;
  assign Binvert=~(ALUCode==alu_add);
endmodule