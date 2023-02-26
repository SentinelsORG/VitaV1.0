//////////////////////////////////////////////////////////////////////////////////
// Company: University of Moratuwa
// Engineer: Saliya Dinusha
// 
// Create Date: 01/31/2023 10:42:44 PM
// Design Name: 
// Module Name: CPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module CPU (clk, reset, ALUrslt,read_data_1, read_data_2, out_to_alu, write_data,MemRead,writetomem,immgenIn, secondData, dataToram,datafromRamTocache,hit,readDatafromCache, pc_out);

	
	// clk and reset

	input clk, reset;
	output [31:0] ALUrslt;
	output [31:0] read_data_1;
	output [31:0] read_data_2;
	output [31:0] pc_out;
	output [3:0] out_to_alu;
	output [31:0] write_data;
	output MemRead,hit,writetomem;
	output [31:0] immgenIn, secondData,datafromRamTocache,readDatafromCache,dataToram;


	// pc 
	wire [31:0] pc_in, pc_out;
	wire clk;

	
	//Instruction memory
	wire [31:0] instruction;
	
	//register file
	wire [31:0] read_data_1,read_data_2;
	wire [31:0] write_data;

	
	//control unit signals
	wire ALUsrc,MemRead,MemtoReg,MemWrite,RegWrite;
	wire branch;
	wire [1:0] ALUOp;
	
	//Immediate generation unit
	wire [31:0] immgenIn, secondData;
	
	// Alu result and read data from data memory
	wire [31:0] ALUrslt, readDataFromMemory, readDatafromCache;
	wire zeroFlag, res;
	wire [3:0] out_to_alu;
	wire [5:0] concat;
	
	// PC new value calculating wires
	wire [31:0] incrementedPC, jumpedPC;
	
	//cache
	wire hit;
	wire [31:0] datafromramtocpu;
	wire [127:0] dataToram,datafromRamTocache;
	wire writetomem;

	
	PC pc1(.clk(clk), .reset(reset), .pc_in(pc_in), .pc_out(pc_out));
	instruction_memory ins_mem(.address(pc_out),.instruction(instruction), .reset(reset));
	register_file reg_file(.read_addr_1(instruction[19:15]), .read_addr_2(instruction[24:20]), .write_addr(instruction[11:7]), .read_data_1(read_data_1), .read_data_2(read_data_2), .write_data(write_data), .reg_write(RegWrite), .clk(clk), .reset(reset));
	immgen immgenUnit(.instruction(instruction), .imm_val(immgenIn));
	controller controllerUnit(.opcode(instruction[6:0]),.hit(hit),.dirty(dirty),.Branch(branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUSrc(ALUsrc),.RegWrite(RegWrite),.ALUOp(ALUOp));
	mux muxBtwReadDataAndImmData(.in_a(read_data_2),.in_b(immgenIn), .command(ALUsrc), .out_mux(secondData));
	

	
	assign concat = {2'b00, instruction[30],instruction[14:12]};
	
	alucontrol AluControl(.aluop(ALUOp), .funct(concat),.out_to_alu(out_to_alu));
	alu ALU(.in_a(read_data_1), .in_b(secondData), .alu_out(ALUrslt), .zero(zeroFlag), .control(out_to_alu));
	
	cache cachememory(.readAddress(ALUrslt) ,.write(MemWrite),.read(MemRead), .hit(hit), .dataInfromCpu(read_data_2), .dataOutToCpu(readDatafromCache), .dataInFromRam(datafromRamTocache), .dataOutToRam(dataToram), .clk(clk),.reset(reset), .writetomem(writetomem));
	mux muxBtwCacheAndMem(.in_b(readDatafromCache),.in_a(datafromramtocpu), .command(hit), .out_mux(readDataFromMemory));
//	cachecontroller cachecont(.clk(clk),.hit(hit),.cache_ctrl_sig(cache_hitornot));
	
	data_memory Dmemory(.addr(ALUrslt), .write_data(dataToram),.tags(ALUrslt[5:4]), .read_data1(datafromRamTocache),.read_data2(datafromramtocpu), .clk(clk), .reset(reset), .mem_read(MemRead), .mem_write(writetomem));
//	DramNew dram(.address(ALUrslt),.clock(clk),.data(dataToram),.wren(MemWrite),.q(datafromRamTocache));
	mux muxBtwDmemAndAlu(.in_a(ALUrslt),.in_b(readDataFromMemory), .command(MemtoReg), .out_mux(write_data));

	incrementPC plus4Adder(.current_pc(pc_out),.new_pc_i(incrementedPC));
	jumpPC jumpPC1(.current_pc(pc_out), .jump_steps(immgenIn), .new_pc_j(jumpedPC));
	mux muxBtwIncPcAndJumpPc(.in_a(incrementedPC),.in_b(jumpedPC), .command(res), .out_mux(pc_in));
	and(res, branch, zeroFlag);
	
endmodule

