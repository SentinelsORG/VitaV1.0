module cache (readAddress, write, read,hit, dataInfromCpu, dataOutToCpu, dataInFromRam, dataOutToRam, clk,reset, writetomem);

	
	input clk,write,read,reset;
	input [31:0] readAddress, dataInfromCpu;
	input [127:0] dataInFromRam;
	output reg [127:0] dataOutToRam;

	output reg hit;
	output reg [31:0] dataOutToCpu;

	output reg writetomem;
	
	reg [131:0] cmemory [3:0];
	

	reg [1:0] tagBits;
	reg [1:0] line;
	reg [1:0] offset; 

	always @(negedge clk)
		begin
		tagBits = readAddress[5:4];
		line = readAddress[3:2];
		offset = readAddress[1:0];
		if(write)
		begin
		cmemory[line][131] = 1'b1;
		$display("In the write mode");
		case (offset)
			2'b00:begin
			
				cmemory[line][31:0] <= dataInfromCpu;
				$display("In the write 00");
			end
			2'b01:begin
			
				cmemory[line][63:32] <= dataInfromCpu;
				$display("In the write 01");
			end
			2'b10:begin
			
				cmemory[line][95:64] <= dataInfromCpu;
				$display("In the write 10");
			end
			2'b11:begin
			
				cmemory[line][127:96] <= dataInfromCpu;
				$display("In the write 11");
			end

		endcase
		$display("%b",dataInfromCpu);
		cmemory[line][130] <= 1'b1;
		cmemory[line][129:128] <= tagBits;
		$display("%b",cmemory[line][130]);
		$display("%b",cmemory[line][129:128]);	
		
		end//cmemory[line][130] &
		
		$display("test tag"); 
		$display("%b",cmemory[line][129:128]);
      $display("%b",tagBits);
		
		if(read)
		begin
		if (cmemory[line][129:128] == tagBits)
			begin
			$display("In the read mode");
			$display("%b",cmemory[line][129:128]);
			$display("%b",tagBits);
				case (offset)
					2'b00:begin
					
						dataOutToCpu=cmemory[line][31:0];
						$display("In the read 00");
					end
					2'b01:begin
					
						dataOutToCpu=cmemory[line][63:32];

						$display("In the read 01");
					end
					2'b10:begin
					
						dataOutToCpu=cmemory[line][95:64];
						$display("In the read 10");
					end
					2'b11:begin
					
						dataOutToCpu=cmemory[line][127:96];
						$display("In the read 11");
					end

				endcase
				$display("%b",dataOutToCpu);
                $display("%b",cmemory[line]);	
				 hit <= 1'b1;
			end
		else //cache miss
			begin
			 $display("In the cache miss");
				 hit <= 1'b0;
				 

				if (cmemory[line][131])
					begin
						writetomem <= 1'b1;
						
						dataOutToRam <= cmemory[line];
						
					
						
//						case (offset)
//							2'b00:begin
//							
//								dataOutToRam = cmemory[line][31:0];
//							end
//							2'b01:begin
//							
//								dataOutToRam = cmemory[line][63:32];
//							end
//							2'b10:begin
//							
//								dataOutToRam = cmemory[line][95:64];
//							end
//							2'b11:begin
//							
//								dataOutToRam = cmemory[line][127:96];
//							end
//	
//						endcase
					
					end
					
					cmemory[line] <= dataInFromRam;



//				case (offset)
//					2'b00:begin
//					
//						cmemory[line][31:0] <= dataInFromRam;
//						$display("In the cache miss 00");
//					end
//					2'b01:begin
//					
//						cmemory[line][63:32]<= dataInFromRam;
//
//						$display("In the cache miss 01");
//						
//					end
//					2'b10:begin
//					
//						cmemory[line][95:64] <= dataInFromRam;
//	                    $display("In the cache miss 10");
//					end
//					2'b11:begin
//					
//						cmemory[line][127:96] <= dataInFromRam;
//						$display("In the cache miss 11");
//					end
//				endcase 				
				cmemory[line][130] <= 1'b1;
				cmemory[line][129:128] <= tagBits;
				$display("%b",dataInFromRam);
            $display("%b",cmemory[line]);
            $display("%b",cmemory[line][130]);
            $display("%b",cmemory[line][129:128]);

			end
		end
		end

endmodule




//`define BLOCKS 4
//`define WORDS 4
//`define SIZE 32
//`define BLOCK_SIZE 128
//
//
//module cache(clk,address,read,dataIn,dataOut,hit);
//
//    input clk;
//    input [31:0] address;
//    input read;
//    input [127:0] dataIn;
//
//    output reg hit;
//    output reg [31:0] dataOut;
//
//    reg [130:0] buffer;
//    reg [1:0] index;
//    reg [1:0] blockOffset;
//    reg [130:0] cachemem [3:0];
//
//    always@(posedge clk)
//    begin
//        index = address[3:2];
//        blockOffset = address[1:0];
//        if(read == 0) begin
//            buffer[130] = 1;
//            buffer[129:128] = address[5:4];
//            buffer[127:0] = dataIn;
//            cachemem[index] = buffer;
//            dataOut = cachemem[index][32*blockOffset-1:32*blockOffset];
//            hit = 1;
//        end
//        if(read == 1) begin
//            if(address[5:4] == cache[index][129:128]) begin
//                hit = 1;
//            end
//            else begin
//                hit = 0;
//            end
//            // hit = 0;
//            dataOut = cache[index][32*blockOffset+21+31-:32];
//        end
//        else begin
//            hit = 1;
//        end
//    end
//
//endmodule

