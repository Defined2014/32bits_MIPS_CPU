
module select_Binvert(
  ALUCode,
  Binvert
);
  input [4:0] ALUCode;
  output Binvert;
  parameter  alu_add=  5'b00000;
  assign Binvert=~(ALUCode==alu_add);
endmodule