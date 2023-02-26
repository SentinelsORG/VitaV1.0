`timescale 1ns/1ps
module CPU_TB;

	reg clk;  initial clk=0; always #100 clk<=(!clk);
	
	reg reset; initial begin reset=1; #200 reset=0; #140 $stop; end
	wire [31:0] ALUrslt;
	wire [31:0] read_data_1;
	wire [31:0] read_data_2;
	wire [31:0] pc_out;
	wire [3:0] out_to_alu;
	wire [31:0] write_data;
	wire MemRead,hit,cache_hitornot,writetomem;
	wire [31:0] immgenIn, secondData,datafromRamTocache,readDatafromCache,dataToram;



	
	integer count;
		
	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.reset(reset),
		.ALUrslt(ALUrslt),
		.read_data_1(read_data_1),
		.read_data_2(read_data_2),
		.out_to_alu(out_to_alu),
		.write_data(write_data),
		.MemRead(MemRead),
		.writetomem(writetomem),
		.immgenIn(immgenIn),
		.secondData(secondData),
		.datafromRamTocache(datafromRamTocache),
		.dataToram(dataToram),
		.hit(hit),
		.readDatafromCache(readDatafromCache),
		.pc_out(pc_out));

//	initial begin
//		// Initialize Inputs
//		count = 0;
//		clk = 0;
//		reset = 0;
//
//	end
	
	
//	always begin #100 clk = ~clk; end 
	

	
endmodule

