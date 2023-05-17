module pc(
	input b_op,btaken,pc_in,
	input [4:0]imm,
	input [4:0]cpc,
	output reg [4:0]nxtpc
	
);
	wire b_out;
	and(b_out,b_op,btaken);
	
	always @(negedge pc_in)
	begin
		case(b_out)
			1'b1: nxtpc <= imm;
			1'b0: nxtpc <= cpc+1'b1;
		default: nxtpc <= 5'b00000;
		endcase
	end
endmodule
