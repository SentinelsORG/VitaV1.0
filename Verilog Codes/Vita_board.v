module cache (readAddress, write, read,hit, dataInfromCpu, dataOutToCpu, dataInFromRam, dataOutToRam, clk,reset);

	
	input clk,write,read,reset;
	input [31:0] readAddress, dataInfromCpu;
	input [31:0] dataInFromRam;

	output hit;
	output [31:0] dataOutToCpu,dataOutToRam;
	
	reg [130:0] cmemory [3:0];
	

	wire [1:0] tagBits;
	wire [1:0] line;
	wire [1:0] offset;


	tagBits = readAddress[5:4];
	line = readAddress[3:2];
	offset = readAddress[1:0];
	if(write)
	begin
	$display("In the write mode");
	case (offset)
		2'b00:begin
		
			cmemory[line][31:0] = dataInfromCpu;
			$display("In the write 00");
		end
		2'b01:begin
		
			cmemory[line][63:32] = dataInfromCpu;
			$display("In the write 01");
		end
		2'b10:begin
		
			cmemory[line][95:64] = dataInfromCpu;
			$display("In the write 10");
		end
		2'b11:begin
		
			cmemory[line][127:96] = dataInfromCpu;
			$display("In the write 11");
		end

	endcase
	$display("%b",dataInfromCpu);
	cmemory[line][130] = 1'b1;
	cmemory[line][129:128] = tagBits;
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

	
//		
//			if (cmemory[line][130])
//				begin
//					
//					case (offset)
//						2'b00:begin
//						
//							dataOutToRam = cmemory[line][31:0];
//						end
//						2'b01:begin
//						
//							dataOutToRam = cmemory[line][63:32];
//						end
//						2'b10:begin
//						
//							dataOutToRam = cmemory[line][95:64];
//						end
//						2'b11:begin
//						
//							dataOutToRam = cmemory[line][127:96];
//						end
//
//					endcase
//				
//				end



			case (offset)
				2'b00:begin
				
					cmemory[line][31:0] = dataInFromRam;
					$display("In the cache miss 00");
				end
				2'b01:begin
				
					cmemory[line][63:32]= dataInFromRam;

					$display("In the cache miss 01");
					
				end
				2'b10:begin
				
					cmemory[line][95:64] = dataInFromRam;
						  $display("In the cache miss 10");
				end
				2'b11:begin
				
					cmemory[line][127:96] = dataInFromRam;
					$display("In the cache miss 11");
				end
			endcase 				
			cmemory[line][130] = 1'b1;
			cmemory[line][129:128] = tagBits;
			$display("%b",dataInFromRam);
				 $display("%b",cmemory[line]);
				 $display("%b",cmemory[line][130]);
				 $display("%b",cmemory[line][129:128]);

		end
	end


endmodule




