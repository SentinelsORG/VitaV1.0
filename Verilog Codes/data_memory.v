//////////////////////////////////////////////////////////////////////////////////
// Company: University of Moratuwa
// Engineer: Saliya Dinusha
// 
// Create Date: 01/31/2023 10:42:44 PM
// Design Name: 
// Module Name: data_memory
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
module data_memory (addr, tags, write_data, read_data1,read_data2, clk, reset, mem_read, mem_write);
	input [31:0] addr;
	input[1:0] tags;
	input [127:0] write_data;
	output [127:0] read_data1;
	output [31:0] read_data2;
	input clk, reset, mem_read, mem_write;
	reg [31:0] dmemory [63:0];
	integer k;
//	wire [5:0] shifted_addr;
//	assign shifted_addr=addr[7:2];
	wire [1:0] tag, line, offset;
	wire [127:0] block;
	wire [31:0] addr1,addr2,addr3,addr4;
	wire [31:0] waddr1,waddr2,waddr3,waddr4;
	
	assign tag = addr[5:4];
	assign line = addr[3:2];
	
	assign read_data2 = dmemory[addr];
	assign addr1 = {26'b0, tag, line, 2'b00};
	assign addr2 = {26'b0, tag, line, 2'b01};
	assign addr3 = {26'b0, tag, line, 2'b10};
	assign addr4 = {26'b0, tag, line, 2'b11};
	
	assign waddr1 = {26'b0, tags, line, 2'b00};
	assign waddr2 = {26'b0, tags, line, 2'b01};
	assign waddr3 = {26'b0, tags, line, 2'b10};
	assign waddr4 = {26'b0, tags, line, 2'b11};
	
	
	
	assign block = {dmemory[addr4],dmemory[addr3],dmemory[addr2],dmemory[addr1] };
	assign read_data1 = block;

	

	always @(posedge clk or posedge reset)// Ou modifies reset to posedge
	begin
		if (reset == 1'b1) 
			begin
				for (k=0; k<64; k=k+1) begin
					dmemory[k] = 32'b0;
				end
			end
		else
			if (mem_write) begin
				dmemory[waddr1] = write_data[31:0];
				dmemory[waddr2] = write_data[63:32];
				dmemory[waddr3] = write_data[95:64];
				dmemory[waddr4] = write_data[127:96];
			end

			
		
		
		dmemory[17] = 32'b010001010101;
	end
endmodule
