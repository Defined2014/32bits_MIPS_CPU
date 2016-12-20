`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:23:21 11/12/2009 
// Design Name: 
// Module Name:    IF 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IF(clk, reset, Z, J, JR, PC_IFWrite, JumpAddr, 
           JrAddr, BranchAddr, Instruction_if,PC, NextPC_if);
    input clk;
    input reset;
    input Z;
    input J;
    input JR;
    input PC_IFWrite;
    input [31:0] JumpAddr;
    input [31:0] JrAddr;
    input [31:0] BranchAddr;
    output [31:0] Instruction_if;
    output [31:0] PC,NextPC_if;
    

// MUX for PC
    reg[31:0] PC_in,PC_cp;
    assign PC=PC_cp;
    wire[2:0] PCSource;
    assign PCSource={JR,J,Z};
    always @(posedge clk) begin
      if(!reset)
        begin
          case(PCSource)
            3'b000 :PC_in<=NextPC_if;
            3'b001 :PC_in<=BranchAddr;
            3'b010 :PC_in<=JumpAddr;
            3'b100 :PC_in<=JrAddr;
            default:PC_in<=0;
          endcase
          if(PC_IFWrite)
            PC_cp<=PC_in;
          else
            PC_cp<=PC;
        end
      else
      begin
        PC_in=0;
        PC_cp=0;
      end
    end

     
//Adder for NextPC
    wire co,ci;
    assign ci=0;
    adder_32bits add(.a(PC),.b(4),.ci(ci),.s(NextPC_if),.co(co));
  	
	  
//ROM
InstructionROM  InstructionROM(
	.addr(PC[7:2]),
	.dout(Instruction_if));
	
endmodule
