`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:52 10/31/2016 
// Design Name: 
// Module Name:    adder_32bits 
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
module adder_32bits(a,b,ci,s,co);
	input[31:0] a,b;
	input ci;
	output[31:0] s;
	output co;
	wire co1,co2,co3,co4,co5,co6,co7;
	adder_4bits adder1(.a(a[3:0]),.b(b[3:0]),.ci(ci),.s(s[3:0]),.co(co1));
	adder_select adder2(.a(a[7:4]),.b(b[7:4]),.ci(co1),.s(s[7:4]),.co(co2));
	adder_select adder3(.a(a[11:8]),.b(b[11:8]),.ci(co2),.s(s[11:8]),.co(co3));
	adder_select adder4(.a(a[15:12]),.b(b[15:12]),.ci(co3),.s(s[15:12]),.co(co4));
	adder_select adder5(.a(a[19:16]),.b(b[19:16]),.ci(co4),.s(s[19:16]),.co(co5));
	adder_select adder6(.a(a[23:20]),.b(b[23:20]),.ci(co5),.s(s[23:20]),.co(co6));
	adder_select adder7(.a(a[27:24]),.b(b[27:24]),.ci(co6),.s(s[27:24]),.co(co7));
	adder_select adder8(.a(a[31:28]),.b(b[31:28]),.ci(co7),.s(s[31:28]),.co(co));

endmodule

module mux_2to1(out,in0,in1,sel);
	output[3:0] out;
	input[3:0] in0,in1;
	input sel;
	assign out=sel?in1:in0;
endmodule

module adder_4bits(a, b, ci, s ,co);
	input [3:0] a,b;
	input ci;
	output [3:0] s;
	output co;
	wire [3:0] c,g,p;
	assign co=c[3];
	assign g=a&b;
	assign p=a|b;
	assign c[0]=g[0]|(p[0]&ci);
	assign c[1]=g[1]|(p[1]&g[0])|(p[1]&p[0]&ci);
	assign c[2]=g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&ci);
	assign c[3]=g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0])|(p[3]&p[2]&p[1]&p[0]&ci);
	assign s[3:0]=a[3:0]^b[3:0]^{c[2:0],ci};
endmodule

module adder_select(a,b,ci,s,co);
  input [3:0] a,b;
  input ci;
  output [3:0] s;
  output co;
  wire [3:0] sum1,sum2;
  wire c1,c2,cand;
  adder_4bits adder_1(.a(a),.b(b),.ci(ci),.s(sum1),.co(c1));
  adder_4bits adder_2(.a(a),.b(b),.ci(ci),.s(sum2),.co(c2));
  mux_2to1 mux1(.out(s),.in0(sum1),.in1(sum2),.sel(ci));
  assign co=c2|(c1&ci);
  
endmodule
