`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Moratuwa
// Engineer: Chamith Dilshan Ranathunga
// 
// Create Date: 01/31/2023 10:42:44 PM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory (address, instruction, reset);
	input reset;
	input [31:0] address;
	output [31:0] instruction;
	reg [31:0] Imemory [63:0];
	integer k;
	// I-MEM in this case is addressed by word, not by byte
//	wire [5:0] shifted_read_addr;
//	assign shifted_read_addr=read_addr[6:2];
	assign instruction = Imemory[address];

	always @(posedge reset)
	begin

		for (k=16; k<32; k=k+1) begin// here Ou changes k=0 to k=16
			Imemory[k] = 32'b0;
		end
					
Imemory[0] = 32'b01000000010001000000011010110011; //sub x13, x4,  x8
Imemory[1] = 32'b00000000010001000000011010110011; //add x13, x4,  x8
Imemory[2] = 32'b00000000010000010011010010000011; //ld  x9,  x2, 0x4
Imemory[3] = 32'b00000000001001110011001000100011; //sd  x14, x2, 0x4
Imemory[4] = 32'b00000000100000100100011010110011; //xor x13,  x4,   x8
Imemory[5] = 32'b00000000100000100111011010110011; //and x13,  x4,   x8
Imemory[6] = 32'b00000000100000100110011010110011; //or  x13,  x4,   x8
Imemory[7] = 32'b00000100010100100000011010010011;//addi x13,  x4,  0x45
Imemory[8] = 32'b00000100010100100100011010010011;//xori x13,  x4,  0x45
Imemory[9] = 32'b00000100010100100110011010010011;//ori x13,  x4,  0x45
Imemory[10] = 32'b00000100010100100111011010010011;//andi x13,  x4,  0x45
Imemory[11] = 32'b00000000010001000101011110010011;//srli x15, x8, 0x4
Imemory[12] = 32'b00000000010001000001011110010011;//slli x15, x8, 0x4
Imemory[13] = 32'b00000000010000010011010010000011; //ld  x9,  x2, 0x4
Imemory[14] = 32'b00000001011100011011010100000011; //ld x10, x3, 0x7
Imemory[15] = 32'b00000000000100000000001001100011; //beq x0, x1,  0x4


	end
  
endmodule

