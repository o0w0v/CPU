module register(
	input clk,
	input wrt,
	input [2:0]rs1,
	input [2:0]rs2,
	input [2:0]rd,
	input [15:0]wrtdata,
	output [15:0]r1,
	output[15:0]r2
);

	reg [15:0] rgstr[7:0];
	
	always @ (negedge clk)
		begin
	 if (wrt) rgstr[rd] <= wrtdata;
	 end
	assign r1 = (rs1!=0) ? rgstr[rs1]:1'b0;
	assign r2 = (rs2!=0) ? rgstr[rs2]:1'b0;
	
endmodule
