module controller(
    input [6:0] opcode,
	 input hit,
	 input dirty,
    output reg Branch, 
    output reg MemRead, 
    output reg MemtoReg, 
    output reg MemWrite, 
    output reg ALUSrc,
    output reg RegWrite,
    output reg [1:0]ALUOp
); 
    
always @(opcode) begin
    
    case (opcode)
        // for R-Type
        7'b0110011 , 7'b0111011: begin
            ALUOp = 2'b10;
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b1;
        end
        
        // for I-Type
        7'b0001111, 7'b0010011, 7'b0011011, 7'b1110011: begin
            ALUOp = 2'b11;
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
        end
        
        // for I-Type secondary
        7'b0000011: begin
            ALUOp = 2'b00;
            Branch = 1'b0;
            MemRead = 1'b1;
            MemtoReg = 1'b1;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
        end
        
        // for S-Type
        7'b0100011: begin
            ALUOp = 2'b00;
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b1;
            ALUSrc = 1'b1;
            RegWrite = 1'b0;
        end        

        // for SB-Type
        7'b1100011: begin
            ALUOp = 2'b01;
            Branch = 1'b1;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
        //defaultly output 0s
        default: begin
            ALUOp = 2'b00;
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
    endcase
	 
	 
	 if (MemRead & !hit & dirty)
		begin
		
			MemWrite = 1'b1;
			
		end

end
endmodule
