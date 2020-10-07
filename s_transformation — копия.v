`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.09.2020 22:26:12
// Design Name: 
// Module Name: s_transformation
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


module s_transformation(
input Clk
);
// Key 2301(10110001 ) for 0123 (00011011) (0-2, 1-3, 2-0, 3-1)
reg [7:0] registr;
wire [7:0] In = {2'b10, 2'b11, 2'b01, 2'b00};//2310 (10110100)
reg [1:0] Ost;
integer i;
always @(posedge Clk)
begin
  for (i= 0; i< 4; i=i+1)//4 blocks for 2 bites
    begin
    if (In[i] == 2'b11)
        Ost <= 2'b01; //3-1
    else
        case(In[i])
        2'b00: Ost <= 2'b10; // if 0, then 2
        2'b01: Ost <= 2'b11; //if 1, then 3
        2'b11: Ost <= 2'b00; //2-0
        endcase
    registr <= {registr [7:0], Ost};
    end
  end
endmodule
