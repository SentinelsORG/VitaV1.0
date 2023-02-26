// async control to generate alu input signal
// input: 2-bit alu_mem_write control signal and 6-bit funct field from instruction
// output: 4-bit alu control input
module alucontrol (aluop, funct,out_to_alu );
	input [1:0] aluop;
//	input [31:0] in_a, in_b;
	input [5:0] funct;
	
	output reg [3:0] out_to_alu;
	wire [31:0]alu_out;
	wire zero;
	wire [7:0] teststring;
	assign teststring = {aluop, funct};

//	assign out_to_alu[3]=(~funct[1]&funct[0])|(funct[2]&~funct[1]);
//	assign out_to_alu[2]= (~aluop[1]&~funct[1])|(~aluop[0]&~funct[1]&funct[3]);
//	assign out_to_alu[1]= ~funct[2]|(~funct[1]&funct[0]&funct[3]);
//	assign out_to_alu[0]= (funct[1]&~funct[0])|(~funct[1]&funct[0]&~funct[3]);
	
	always @(teststring) begin
    
    case (teststring)
        // add
        8'b00000011,8'b00001011 , 8'b10000000, 8'b11001000, 8'b11000000: begin
		  
			out_to_alu = 4'b0010;

        end
        
        8'b01000000,8'b01001000 , 8'b10001000: begin
		  
			out_to_alu = 4'b0110;

        end
		  
        8'b10000111,8'b11001111 , 8'b11000111: begin
		  
			out_to_alu = 4'b0001;

        end
        8'b10000110,8'b11001110 , 8'b11000110: begin
		  
			out_to_alu = 4'b0000;

        end
        8'b10000100,8'b11001100 , 8'b11000100: begin
		  
			out_to_alu = 4'b1000;


        end
        8'b11000101: begin
		  
			out_to_alu = 4'b1001;

        end
        8'b11000001: begin
		  
			out_to_alu = 4'b1011;

        end

    endcase
	 


end
	
	
		
endmodule


