`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Moratuwa
// Engineer: Chamith Dilshan Ranathunga
// 
// Create Date: 01/30/2023 10:44:27 PM
// Design Name: incrementPC
// Module Name: incrementPC
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


module incrementPC(current_pc,new_pc_i);
    parameter n=32;
    input [n-1:0] current_pc;
    output [n-1:0] new_pc_i;
    assign new_pc_i = current_pc + 32'b01;
endmodule
