`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2020 19:55:28
// Design Name: 
// Module Name: l_transformation
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


module l_transformation(
input Clk
    );
wire [7:0] In = {2'b10, 2'b11, 2'b01, 2'b00};//2310
reg [4:0] Ost;
reg [4:0] Umn;
reg [7:0] registr;
integer i, k = 0;
integer massive = {7'd2, 7'd5, 7'd6, 7'd1};
always @(posedge Clk)
begin
for (i=0;i<4;i=i+1)
begin
    Ost <= In[i] * 8'd100;//умножение на постоянную 4
    Umn <= Ost + massive[k];
    registr <= {registr [7:0], Umn};
    k = k +1;
end
end
endmodule
