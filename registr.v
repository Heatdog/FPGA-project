`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2020 22:23:28
// Design Name: 
// Module Name: registr
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


module registr(
    input Clk,
    input ShiftIn,
    output ShiftOut
    );
reg [7:0] shift_reg;
 always @(posedge Clk)
 shift_reg <= {shift_reg[6:0], ShiftIn};
 assign ShiftOut = shift_reg[7];
endmodule
