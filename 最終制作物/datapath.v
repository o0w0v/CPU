module datapath(
	input clk,regwrite,
	input [15:0]readdata,
	input [4:0]imm,
	input r_op,i_op,b_op,l_op,
	input [2:0] rs2,rs1,rd,
	input alusrc,
	input [3:0]aluctl,
	input write,
	output btaken,
	output [15:0]writedata,
	output [15:0]writeaddr,readaddr
);
	wire [15:0] aluout,out;
	wire [15:0] r1,r2,rf2;
	assign readaddr = r1 + imm;
	assign writedata = r2;
	assign writeaddr = r1 + imm;
	assign out = (l_op)?readdata:aluout;
	assign rf2 = (alusrc)?{11'b00000000000,imm}:r2;
	register register(clk,regwrite,rs1,rs2,rd,out,r1,r2);
	alu alu(clk,r1,rf2,aluctl,aluout,btaken);
endmodule
