//////////////////////////////////////////////////////////////////////////////////
// Company: University of Moratuwa
// Engineer: Saliya Dinusha
// 
// Create Date: 01/31/2023 10:42:44 PM
// Design Name: 
// Module Name: register_file
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
module register_file (read_addr_1, read_addr_2, write_addr, read_data_1, read_data_2, write_data, reg_write, clk, reset);
	input [4:0] read_addr_1, read_addr_2, write_addr;
	input [31:0] write_data;
	input clk, reset, reg_write;
	output [31:0] read_data_1, read_data_2;

	reg [31:0] reg_file [31:0];
	integer k;
	
	assign read_data_1 = reg_file[read_addr_1];
	assign read_data_2 = reg_file[read_addr_2];

	always @(posedge clk or posedge reset) // Ou combines the block of reset into the block of posedge clk
	begin
		if (reset==1'b1)
		begin
			for (k=0; k<32; k=k+1) 
			begin
				reg_file[k] = 32'b0;
			end
		end 
		
		else if (reg_write == 1'b1) reg_file[write_addr] = write_data; 
		
		
		reg_file[0] = 32'b0101;
		reg_file[1] = 32'b0101;
		reg_file[2] = 32'b01101;
		reg_file[3] = 32'b0;
		reg_file[4] = 32'b0111; 
		reg_file[5] = 32'b01000;
		reg_file[8] = 32'b00000001; 
		reg_file[12] = 32'b0100001001100101; 
		reg_file[16] = 32'b1010110000100; 
		reg_file[20] = 32'b1010110000000001000; 
		

	end
	


endmodule
