module dec(
	input [1:0]op,
	input [2:0]fct,
	input [10:0]cl,
	output [4:0]imm,
	output r_op,
	output i_op,
	output b_op,
	output l_op,
	output [2:0]rs2,
	output [2:0]rs1,
	output [2:0]rd,
	output memwrite,
	output regwrite,
	output alusrc,
	output memreg,
	output [3:0]aluop
	);
	
	reg[7:0] ctrl;
	
	assign {r_op,i_op,b_op,l_op,aluop} = ctrl;
	reg[17:0] ctrl2;
	assign {imm,rs2,rs1,rd,memwrite,regwrite,alusrc,memreg} = ctrl2;
	
	always @(*)
	begin
		case (op)
			2'b00: ctrl <= 8'b10001000;
			2'b01: ctrl <= 8'b01000100;
			2'b10: ctrl <= 8'b00100010;
			2'b11: ctrl <= 8'b00010001;
			default: ctrl <= 8'bxxxxxxxx;
		endcase
		case (aluop)
			4'b1000: ctrl2 <= {5'b00000,cl[8:6],cl[5:3],cl[2:0],4'b0100};
			4'b0100: ctrl2 <= {cl[10:6],3'b000,cl[5:3],cl[2:0],1'b0,1'b1,1'b1,1'b0};
			4'b0010: ctrl2 <= {cl[10:9],cl[2:0],cl[8:6],cl[5:3],3'b000,1'b0,1'b0,1'b0,1'b0};
			4'b0001: case (fct)
							3'b000: ctrl2 <= {cl[10:6],3'b000,cl[5:3],cl[2:0],1'b0,1'b1,1'b1,1'b1};
							3'b001: ctrl2 <= {cl[10:6],cl[2:0],cl[5:3],3'b000,1'b1,1'b0,1'b1,1'b0};
							default: ctrl2 <= 18'bxxxxxxxxxxxxxxxxxx;
						endcase
			default: ctrl2 <= 18'bxxxxxxxxxxxxxxxxxx;
		endcase
	end
endmodule

module aludec(
	input [3:0]op,
	input [2:0]fct,
	output reg[3:0] aluctl);
	
	always @(*)
	begin 
		case (op)
			4'b1000: aluctl <= {1'b0,fct[2:0]};
			4'b0100: aluctl <= {1'b0,fct[2:0]};
			4'b0010: case(fct)
							3'b000: aluctl <= 4'b1000;
							3'b001: aluctl <= 4'b1001;
							3'b010: aluctl <= 4'b1010;
							3'b011: aluctl <= 4'b1011;
							default: aluctl <= 4'bxxxx;
						endcase
			4'b0001: aluctl <= 4'b0000;
			default: aluctl <= 4'bxxxx;
		endcase
	end
endmodule

module decoder(
	input [15:0] instr,
	output [4:0]imm,
	output r_op,
	output i_op,
	output b_op,
	output l_op,
	output [2:0]rs2,
	output [2:0]rs1,
	output [2:0]rd,
	output memwrite,
	output regwrite,
	output alusrc,
	output memreg,
	output [3:0] aluctl
);
	wire [3:0] aluop;
	dec dc(instr[1:0],instr[4:2],instr[15:5],imm,r_op,i_op,b_op,l_op,rs2,rs1,rd,memwrite,regwrite,alusrc,memreg,aluop);
	aludec actl(aluop,instr[4:2],aluctl);
endmodule

