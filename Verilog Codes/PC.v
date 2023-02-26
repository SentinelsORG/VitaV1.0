//////////////////////////////////////////////////////////////////////////////////
// Company: University of Moratuwa
// Engineer: Saliya Dinusha
// 
// Create Date: 01/31/2023 10:42:44 PM
// Design Name: 
// Module Name: PC
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
module PC (clk, reset, pc_in, pc_out);
	input clk, reset;
	input [31:0] pc_in;
	output [31:0] pc_out;
	reg [31:0] pc_out;
	always @ (posedge clk or posedge reset)
	begin
		if(reset==1'b1)
			pc_out<=0;
		else
			pc_out<=pc_in;
	end
endmodule
