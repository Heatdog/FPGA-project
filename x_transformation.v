`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2020 20:11:19
// Design Name: 
// Module Name: x_transformation
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


module x_transformation(
input [7:0] d_in,
input [7:0] A,
output [7:0] parity_out
);
assign parity_out = A^d_in;
endmodule




