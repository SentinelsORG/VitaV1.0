`timescale 1ns/1ps
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

module LCD (Alu, rw, rs, en, data, on, blon);

	input [7:0] Alu;
	output reg rw, rs, en;
	output on, blon;
	
	output reg [7:0] data;
	

	assign on = 1'b1;
	
	assign blon = 1'b1;
	
	
	always@(Alu)
		begin
			
			data<= Alu;
			rw=1'b0;
			rs = 1'b1;
			en = 1'b1;

			
		end
	
	


	

	
endmodule

