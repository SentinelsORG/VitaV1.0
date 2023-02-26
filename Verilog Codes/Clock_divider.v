`timescale 1ns / 1ps

//
//module Clock_divider(clk_in,clk_out);
//	input clk_in;
//	output clk_out;
//	wire clk_out;
//	integer m;
//	initial m=0;
//
//	always @ (posedge clk_in)
//
//	begin
//		 m<=m+1;
//	end
//
//	assign clk_out  = m[10];
//
//endmodule



module Clock_divider (seconds,clk,reset);

output reg seconds;
input clk, reset; 
reg [26:0] count;

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        count   <= 0;
        seconds <= 0;
    end else if (count == 27'd50_000_000) begin 
        count   <= 0;
        seconds <= ~seconds;
    end else begin
        count   <= count + 1'b1;    
    end 
end

endmodule
