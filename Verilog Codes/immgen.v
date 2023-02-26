module immgen(instruction, imm_val);
    input [31:0] instruction; // input 
    output [31:0] imm_val;
    reg [31:0] imm_val;
    
    
    always @(instruction) begin
        // immediate values of different opcodes are different
        // switch by opcode type to generate the given immediate value
        
        case(instruction[6:0]) // switch by opcode
            // I type
            7'b0000011, 7'b0001111, 7'b0010011, 7'b0011011, 7'b1110011:
                imm_val = {20'b0, instruction[31:20]};
                
            // S type
            7'b0100011:
                imm_val = {20'b0, instruction[31:25], instruction[11:7]};
                
            // SB type
            7'b1100011:
                imm_val = {19'b0, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
                
            // U type
            7'b0010111, 7'b0110111:
                imm_val = {instruction[31:12], 12'b0};
                
            // UJ type
            7'b1101111:
                imm_val = {11'b0, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
        
        endcase
    
    end
endmodule
