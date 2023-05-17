`timescale 10ns / 1ps
`define DATFILE "memfile.dat"

module instmem(
	input [4:0]PC,
	input clk,
	output [15:0]rd);
	reg [15:0] RAM[32:0];
	
	initial 
		begin 
			$readmemb ("memfile.dat", RAM);
		end
		assign rd = RAM[PC];
endmodule

module datamem(
	input clk,
	input memwrite,rddata,
	input [15:0] datap,
	input [15:0]writedata,
	input [15:0]writeaddr,
	output reg [15:0] readdata);
	reg [15:0] RAM[15:0];
	always @(posedge clk)
	begin
	if(rddata)begin 
		readdata <= RAM[datap];
	end
	if(memwrite) begin 
		RAM[writeaddr] <= writedata;
	end
	end
endmodule

module mycpu(
	input clk,
	input [3:0] sw,
	output [15:0] LED
	);
	reg [15:0] RAMtp[15:0];
	wire [4:0]cpc;
	wire [4:0]nxtpc;
	assign cpc = nxtpc;
	wire [15:0] instr;
	wire [15:0]writedata,readdata;
	wire [15:0]writeaddr,datap,readaddr;
	wire memwrite,memreg;
	instmem instmem(nxtpc,clk,instr);
	T16 T16(clk,instr,readdata,cpc,writeaddr,readaddr,memwrite,memreg,writedata,nxtpc);
	datamem datamem(clk,memwrite,memreg,readaddr,writedata,writeaddr,readdata);
	assign LED = RAMtp[sw];
	always @(posedge clk) begin
	if(memwrite)  begin
		RAMtp[writeaddr] <= writedata;
	end
	end
endmodule



