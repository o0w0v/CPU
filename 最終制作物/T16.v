module T16(
	input clk,
	input [15:0]instr,
	input [15:0]readdata,
	input [4:0]cpc,
	output [15:0] writeaddr,readaddr,
	output memwrite,memreg,
	output [15:0] writedata,
	output [4:0] nxtpc
	);
	wire r_op,i_op,b_op,l_op,write,alusrc,regwrite;
	wire btaken;
	wire [2:0]rs1,rs2,rd;
	wire [3:0]aluctl;
	wire [4:0]imm;
	decoder dec(instr,imm,r_op,i_op,b_op,l_op,rs2,rs1,rd,memwrite,regwrite,alusrc,memreg,aluctl);
	datapath dp(clk,regwrite,readdata,imm,r_op,i_op,b_op,l_op,rs2,rs1,rd,alusrc,aluctl,write,btaken,writedata,writeaddr,readaddr);
	pc pc(b_op,btaken,clk,imm,cpc,nxtpc);
endmodule
