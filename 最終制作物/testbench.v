`timescale 10ns / 1ps
module testbench();
	reg clk;
	reg [3:0]sw;
	wire [15:0]LED;
	mycpu mycpu(clk,sw,LED);
	initial begin
		clk <= 0;
		#10 sw <= 4'b0011;
	end
	always @(*)
	begin
		#1 clk <= ~clk;
	end
endmodule
