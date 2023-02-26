//module mux(in_a,in_b, command, out_mux,clk);
//	input command,clk;
//	input [31:0] in_a,in_b;
//	output [31:0] out_mux;
//	reg out_mux;
//
//	always @(posedge clk)
//
//	begin
//	if (command == 0)
//	  out_mux <= in_a;
//	else
//	  out_mux <= in_b;
//	end
// endmodule
 
 
module mux (in_a,in_b, command, out_mux);
	parameter N = 32;
	input [N-1:0] in_a, in_b;
	output [N-1:0] out_mux;
	input command;
	assign out_mux=command?in_b:in_a;
endmodule
