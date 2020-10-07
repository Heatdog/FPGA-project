`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2020 01:19:53
// Design Name: 
// Module Name: p_transformation
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


module p_transformation(
input Clk,
input wire [7:0] In
    );
//key 2103
//исходное значение 11010010(3102), конечное 01101010(1222)
reg [7:0] registr;
integer i = 0;//индекс для блокa
reg Ost, Ost2;
wire [7:0] key = {2'b10, 2'b01, 2'b00, 2'b11};
always @(posedge Clk)
begin
if (i<5)
    begin
        case (key[i])
        2'b01: begin
               Ost <= In[1];
               Ost2 <= In[5];
               end
        2'b00: begin
               Ost <= In[2];
               Ost2 <= In[6];
               end
        2'b10: begin
               Ost <= In[0];
               Ost2 <= In[4];
               end
        2'b11: begin
               Ost <= In[3];
               Ost2 <= In[7];
               end
         default: begin
                  Ost <= 1'bx;
                  Ost2 <= 1'bx;
                  end
         endcase
         registr <= {registr, Ost, Ost2};
         i=i+1;
    end
end
endmodule
