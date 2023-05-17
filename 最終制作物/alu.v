module alu(
	input clk,
	input [15:0] rs1,
	input [15:0] rs2,
	input [3:0] aluctl,
	output reg [15:0] out,
	output reg btaken
);

	always @ (*)
	begin 
		case(aluctl)
			4'b0000: out <= rs1 + rs2;
			4'b0001: out <= rs1 - rs2;
			4'b0010: out <= rs1 ^ rs2;
			4'b0011: out <= rs1 | rs2;
			4'b0100: out <= rs1 & rs2;
			4'b0101: out <= rs1 << rs2;
			4'b0110: out <= rs1 >> rs2;
			4'b0111: out <= (rs1 < rs2) ? 16'b0000000000000001:16'b0000000000000000;
			default: out <= 16'bxxxxxxxxxxxxxxxx;
		endcase
		case(aluctl)
			4'b1000: btaken <= (rs1 == rs2) ? 1'b1:1'b0;
			4'b1001: btaken <= (rs1 != rs2) ? 1'b1:1'b0;
			4'b1010: btaken <= (rs1 < rs2) ? 1'b1:1'b0;
			4'b1011: btaken <= (rs1 <= rs2) ? 1'b1:1'b0;
			default: btaken <= 1'bx;
		endcase
	end

endmodule
