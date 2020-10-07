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
input Clk,
input wire [7:0] In
);
// Key 2301(10110001 ) for 0123 (00011011) (0-2, 1-3, 2-1, 3-0)
reg [7:0] registr;
reg [1:0] Ost;
integer i = 0;
always @(posedge Clk)
    begin
    if (i<=8)
    begin
        case({In[i],In[i+1]})
        2'b10: begin
               Ost <= 2'b01;//if 2 - 1
               registr <= {registr, Ost};
               end
        2'b00: begin
               Ost <= 2'b10; // if 0, then 2
               registr <= {registr, Ost};
               end
        2'b01: begin
               Ost <= 2'b11; //if 1, then 3
               registr <= {registr, Ost};
               end
        2'b11: begin
               Ost <= 2'b00; //3-0
               registr <= {registr, Ost};
               end
        default: begin
                 Ost <= 2'bx;
                 registr <= {registr, Ost};
                 end
        endcase
        i=i+2;
        end
    end
endmodule
