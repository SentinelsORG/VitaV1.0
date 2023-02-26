`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2023 11:38:53 PM
// Design Name: 
// Module Name: jumpPC
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


module jumpPC(current_pc, jump_steps, new_pc_j);
    parameter k = 32;
    parameter m = 32;
    input [k-1:0] current_pc;
    input [m-1:0] jump_steps;
    output [k-1:0] new_pc_j;
    assign new_pc_j = current_pc + jump_steps;
endmodule
