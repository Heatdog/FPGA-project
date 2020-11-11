`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2020 02:08:59
// Design Name: 
// Module Name: Encrypt
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


module Encrypt(output reg [64:1] ciphertext, input [64:1] message, input [256:1] key, input clk);

  function [4:1] SBOX(input [5:0] y, input [4:1] B);//c?? s-box (?? ????? ???????? 4 ???, ? ????? ????????)
    begin
      case(y)
      6'd000001: begin
             if (B == 4'd0)
             SBOX = 4'hF;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'h2;
             if (B == 4'd3)
             SBOX = 4'hA;
             if (B == 4'd4)
             SBOX = 4'h6;
             if (B == 4'd5)
             SBOX = 4'h4;
             if (B == 4'd6)
             SBOX = 4'h5;
             if (B == 4'd7)
             SBOX = 4'h0;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'h9;
             if (B == 4'd10)
             SBOX = 4'hE;
             if (B == 4'd11)
             SBOX = 4'hD;
             if (B == 4'd12)
             SBOX = 4'h1;
             if (B == 4'd13)
             SBOX = 4'hB;
             if (B == 4'd14)
             SBOX = 4'h8;
             if (B == 4'd15)
             SBOX = 4'h3;
             end
      6'b000010: 
           begin
             if (B == 4'd0)
             SBOX = 4'hB;
             if (B == 4'd1)
             SBOX = 4'h6;
             if (B == 4'd2)
             SBOX = 4'h3;
             if (B == 4'd3)
             SBOX = 4'h4;
             if (B == 4'd4)
             SBOX = 4'hC;
             if (B == 4'd5)
             SBOX = 4'hF;
             if (B == 4'd6)
             SBOX = 4'hE;
             if (B == 4'd7)
             SBOX = 4'h2;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'hD;
             if (B == 4'd10)
             SBOX = 4'h8;
             if (B == 4'd11)
             SBOX = 4'h0;
             if (B == 4'd12)
             SBOX = 4'h5;
             if (B == 4'd13)
             SBOX = 4'hA;
             if (B == 4'd14)
             SBOX = 4'h9;
             if (B == 4'd15)
             SBOX = 4'h1;
             end
      6'b000011:           
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'hB;
             if (B == 4'd3)
             SBOX = 4'h0;
             if (B == 4'd4)
             SBOX = 4'hF;
             if (B == 4'd5)
             SBOX = 4'hE;
             if (B == 4'd6)
             SBOX = 4'h6;
             if (B == 4'd7)
             SBOX = 4'h5;
             if (B == 4'd8)
             SBOX = 4'hA;
             if (B == 4'd9)
             SBOX = 4'hD;
             if (B == 4'd10)
             SBOX = 4'h4;
             if (B == 4'd11)
             SBOX = 4'h8;
             if (B == 4'd12)
             SBOX = 4'h9;
             if (B == 4'd13)
             SBOX = 4'h3;
             if (B == 4'd14)
             SBOX = 4'h7;
             if (B == 4'd15)
             SBOX = 4'h2;
             end
      6'b000100:              
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'h5;
             if (B == 4'd2)
             SBOX = 4'hE;
             if (B == 4'd3)
             SBOX = 4'hC;
             if (B == 4'd4)
             SBOX = 4'hA;
             if (B == 4'd5)
             SBOX = 4'h7;
             if (B == 4'd6)
             SBOX = 4'h0;
             if (B == 4'd7)
             SBOX = 4'hD;
             if (B == 4'd8)
             SBOX = 4'h6;
             if (B == 4'd9)
             SBOX = 4'h2;
             if (B == 4'd10)
             SBOX = 4'hB;
             if (B == 4'd11)
             SBOX = 4'h4;
             if (B == 4'd12)
             SBOX = 4'h9;
             if (B == 4'd13)
             SBOX = 4'h3;
             if (B == 4'd14)
             SBOX = 4'hF;
             if (B == 4'd15)
             SBOX = 4'h8;
             end
      6'b000101:              
             begin
             if (B == 4'd0)
             SBOX = 4'h0;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'h8;
             if (B == 4'd3)
             SBOX = 4'h9;
             if (B == 4'd4)
             SBOX = 4'hD;
             if (B == 4'd5)
             SBOX = 4'h2;
             if (B == 4'd6)
             SBOX = 4'hA;
             if (B == 4'd7)
             SBOX = 4'hB;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'h3;
             if (B == 4'd10)
             SBOX = 4'h6;
             if (B == 4'd11)
             SBOX = 4'h5;
             if (B == 4'd12)
             SBOX = 4'h4;
             if (B == 4'd13)
             SBOX = 4'hE;
             if (B == 4'd14)
             SBOX = 4'hF;
             if (B == 4'd15)
             SBOX = 4'h1;
             end
      6'b000110:              
             begin
             if (B == 4'd0)
             SBOX = 4'h8;
             if (B == 4'd1)
             SBOX = 4'h0;
             if (B == 4'd2)
             SBOX = 4'hF;
             if (B == 4'd3)
             SBOX = 4'h3;
             if (B == 4'd4)
             SBOX = 4'h2;
             if (B == 4'd5)
             SBOX = 4'h5;
             if (B == 4'd6)
             SBOX = 4'hE;
             if (B == 4'd7)
             SBOX = 4'hB;
             if (B == 4'd8)
             SBOX = 4'h1;
             if (B == 4'd9)
             SBOX = 4'hA;
             if (B == 4'd10)
             SBOX = 4'h4;
             if (B == 4'd11)
             SBOX = 4'h7;
             if (B == 4'd12)
             SBOX = 4'hC;
             if (B == 4'd13)
             SBOX = 4'h9;
             if (B == 4'd14)
             SBOX = 4'hD;
             if (B == 4'd15)
             SBOX = 4'h6;
             end
      6'b000111:              
             begin
             if (B == 4'd0)
             SBOX = 4'h3;
             if (B == 4'd1)
             SBOX = 4'h0;
             if (B == 4'd2)
             SBOX = 4'h6;
             if (B == 4'd3)
             SBOX = 4'hF;
             if (B == 4'd4)
             SBOX = 4'h1;
             if (B == 4'd5)
             SBOX = 4'hE;
             if (B == 4'd6)
             SBOX = 4'h9;
             if (B == 4'd7)
             SBOX = 4'h2;
             if (B == 4'd8)
             SBOX = 4'hD;
             if (B == 4'd9)
             SBOX = 4'h8;
             if (B == 4'd10)
             SBOX = 4'hC;
             if (B == 4'd11)
             SBOX = 4'h4;
             if (B == 4'd12)
             SBOX = 4'hB;
             if (B == 4'd13)
             SBOX = 4'hA;
             if (B == 4'd14)
             SBOX = 4'h5;
             if (B == 4'd15)
             SBOX = 4'h7;
             end
      6'b001000:             
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'hA;
             if (B == 4'd2)
             SBOX = 4'h6;
             if (B == 4'd3)
             SBOX = 4'h8;
             if (B == 4'd4)
             SBOX = 4'hF;
             if (B == 4'd5)
             SBOX = 4'hB;
             if (B == 4'd6)
             SBOX = 4'h0;
             if (B == 4'd7)
             SBOX = 4'h4;
             if (B == 4'd8)
             SBOX = 4'hC;
             if (B == 4'd9)
             SBOX = 4'h3;
             if (B == 4'd10)
             SBOX = 4'h5;
             if (B == 4'd11)
             SBOX = 4'h9;
             if (B == 4'd12)
             SBOX = 4'h7;
             if (B == 4'd13)
             SBOX = 4'hD;
             if (B == 4'd14)
             SBOX = 4'h2;
             if (B == 4'd15)
             SBOX = 4'hE;
             end
      6'b001001:  
             begin
             if (B == 4'd0)
             SBOX = 4'hF;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'h2;
             if (B == 4'd3)
             SBOX = 4'hA;
             if (B == 4'd4)
             SBOX = 4'h6;
             if (B == 4'd5)
             SBOX = 4'h4;
             if (B == 4'd6)
             SBOX = 4'h5;
             if (B == 4'd7)
             SBOX = 4'h0;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'h9;
             if (B == 4'd10)
             SBOX = 4'hE;
             if (B == 4'd11)
             SBOX = 4'hD;
             if (B == 4'd12)
             SBOX = 4'h1;
             if (B == 4'd13)
             SBOX = 4'hB;
             if (B == 4'd14)
             SBOX = 4'h8;
             if (B == 4'd15)
             SBOX = 4'h3;
             end
      6'b001010:            
             begin
             if (B == 4'd0)
             SBOX = 4'hB;
             if (B == 4'd1)
             SBOX = 4'h6;
             if (B == 4'd2)
             SBOX = 4'h3;
             if (B == 4'd3)
             SBOX = 4'h4;
             if (B == 4'd4)
             SBOX = 4'hC;
             if (B == 4'd5)
             SBOX = 4'hF;
             if (B == 4'd6)
             SBOX = 4'hE;
             if (B == 4'd7)
             SBOX = 4'h2;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'hD;
             if (B == 4'd10)
             SBOX = 4'h8;
             if (B == 4'd11)
             SBOX = 4'h0;
             if (B == 4'd12)
             SBOX = 4'h5;
             if (B == 4'd13)
             SBOX = 4'hA;
             if (B == 4'd14)
             SBOX = 4'h9;
             if (B == 4'd15)
             SBOX = 4'h1;
             end
      6'b001011:              
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'hB;
             if (B == 4'd3)
             SBOX = 4'h0;
             if (B == 4'd4)
             SBOX = 4'hF;
             if (B == 4'd5)
             SBOX = 4'hE;
             if (B == 4'd6)
             SBOX = 4'h6;
             if (B == 4'd7)
             SBOX = 4'h5;
             if (B == 4'd8)
             SBOX = 4'hA;
             if (B == 4'd9)
             SBOX = 4'hD;
             if (B == 4'd10)
             SBOX = 4'h4;
             if (B == 4'd11)
             SBOX = 4'h8;
             if (B == 4'd12)
             SBOX = 4'h9;
             if (B == 4'd13)
             SBOX = 4'h3;
             if (B == 4'd14)
             SBOX = 4'h7;
             if (B == 4'd15)
             SBOX = 4'h2;
             end
      6'b001100:              
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'h5;
             if (B == 4'd2)
             SBOX = 4'hE;
             if (B == 4'd3)
             SBOX = 4'hC;
             if (B == 4'd4)
             SBOX = 4'hA;
             if (B == 4'd5)
             SBOX = 4'h7;
             if (B == 4'd6)
             SBOX = 4'h0;
             if (B == 4'd7)
             SBOX = 4'hD;
             if (B == 4'd8)
             SBOX = 4'h6;
             if (B == 4'd9)
             SBOX = 4'h2;
             if (B == 4'd10)
             SBOX = 4'hB;
             if (B == 4'd11)
             SBOX = 4'h4;
             if (B == 4'd12)
             SBOX = 4'h9;
             if (B == 4'd13)
             SBOX = 4'h3;
             if (B == 4'd14)
             SBOX = 4'hF;
             if (B == 4'd15)
             SBOX = 4'h8;
             end
      6'b001101:              
             begin
             if (B == 4'd0)
             SBOX = 4'h0;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'h8;
             if (B == 4'd3)
             SBOX = 4'h9;
             if (B == 4'd4)
             SBOX = 4'hD;
             if (B == 4'd5)
             SBOX = 4'h2;
             if (B == 4'd6)
             SBOX = 4'hA;
             if (B == 4'd7)
             SBOX = 4'hB;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'h3;
             if (B == 4'd10)
             SBOX = 4'h6;
             if (B == 4'd11)
             SBOX = 4'h5;
             if (B == 4'd12)
             SBOX = 4'h4;
             if (B == 4'd13)
             SBOX = 4'hE;
             if (B == 4'd14)
             SBOX = 4'hF;
             if (B == 4'd15)
             SBOX = 4'h1;
             end
      6'b001110:              
             begin
             if (B == 4'd0)
             SBOX = 4'h8;
             if (B == 4'd1)
             SBOX = 4'h0;
             if (B == 4'd2)
             SBOX = 4'hF;
             if (B == 4'd3)
             SBOX = 4'h3;
             if (B == 4'd4)
             SBOX = 4'h2;
             if (B == 4'd5)
             SBOX = 4'h5;
             if (B == 4'd6)
             SBOX = 4'hE;
             if (B == 4'd7)
             SBOX = 4'hB;
             if (B == 4'd8)
             SBOX = 4'h1;
             if (B == 4'd9)
             SBOX = 4'hA;
             if (B == 4'd10)
             SBOX = 4'h4;
             if (B == 4'd11)
             SBOX = 4'h7;
             if (B == 4'd12)
             SBOX = 4'hC;
             if (B == 4'd13)
             SBOX = 4'h9;
             if (B == 4'd14)
             SBOX = 4'hD;
             if (B == 4'd15)
             SBOX = 4'h6;
             end
      6'b001111:              
             begin
             if (B == 4'd0)
             SBOX = 4'h3;
             if (B == 4'd1)
             SBOX = 4'h0;
             if (B == 4'd2)
             SBOX = 4'h6;
             if (B == 4'd3)
             SBOX = 4'hF;
             if (B == 4'd4)
             SBOX = 4'h1;
             if (B == 4'd5)
             SBOX = 4'hE;
             if (B == 4'd6)
             SBOX = 4'h9;
             if (B == 4'd7)
             SBOX = 4'h2;
             if (B == 4'd8)
             SBOX = 4'hD;
             if (B == 4'd9)
             SBOX = 4'h8;
             if (B == 4'd10)
             SBOX = 4'hC;
             if (B == 4'd11)
             SBOX = 4'h4;
             if (B == 4'd12)
             SBOX = 4'hB;
             if (B == 4'd13)
             SBOX = 4'hA;
             if (B == 4'd14)
             SBOX = 4'h5;
             if (B == 4'd15)
             SBOX = 4'h7;
             end
      6'b010000:              
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'hA;
             if (B == 4'd2)
             SBOX = 4'h6;
             if (B == 4'd3)
             SBOX = 4'h8;
             if (B == 4'd4)
             SBOX = 4'hF;
             if (B == 4'd5)
             SBOX = 4'hB;
             if (B == 4'd6)
             SBOX = 4'h0;
             if (B == 4'd7)
             SBOX = 4'h4;
             if (B == 4'd8)
             SBOX = 4'hC;
             if (B == 4'd9)
             SBOX = 4'h3;
             if (B == 4'd10)
             SBOX = 4'h5;
             if (B == 4'd11)
             SBOX = 4'h9;
             if (B == 4'd12)
             SBOX = 4'h7;
             if (B == 4'd13)
             SBOX = 4'hD;
             if (B == 4'd14)
             SBOX = 4'h2;
             if (B == 4'd15)
             SBOX = 4'hE;
             end
      6'b010001:              
             begin
             if (B == 4'd0)
             SBOX = 4'hF;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'h2;
             if (B == 4'd3)
             SBOX = 4'hA;
             if (B == 4'd4)
             SBOX = 4'h6;
             if (B == 4'd5)
             SBOX = 4'h4;
             if (B == 4'd6)
             SBOX = 4'h5;
             if (B == 4'd7)
             SBOX = 4'h0;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'h9;
             if (B == 4'd10)
             SBOX = 4'hE;
             if (B == 4'd11)
             SBOX = 4'hD;
             if (B == 4'd12)
             SBOX = 4'h1;
             if (B == 4'd13)
             SBOX = 4'hB;
             if (B == 4'd14)
             SBOX = 4'h8;
             if (B == 4'd15)
             SBOX = 4'h3;
             end
      6'b010010:            
             begin
             if (B == 4'd0)
             SBOX = 4'hB;
             if (B == 4'd1)
             SBOX = 4'h6;
             if (B == 4'd2)
             SBOX = 4'h3;
             if (B == 4'd3)
             SBOX = 4'h4;
             if (B == 4'd4)
             SBOX = 4'hC;
             if (B == 4'd5)
             SBOX = 4'hF;
             if (B == 4'd6)
             SBOX = 4'hE;
             if (B == 4'd7)
             SBOX = 4'h2;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'hD;
             if (B == 4'd10)
             SBOX = 4'h8;
             if (B == 4'd11)
             SBOX = 4'h0;
             if (B == 4'd12)
             SBOX = 4'h5;
             if (B == 4'd13)
             SBOX = 4'hA;
             if (B == 4'd14)
             SBOX = 4'h9;
             if (B == 4'd15)
             SBOX = 4'h1;
             end
      6'b010011:              
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'hB;
             if (B == 4'd3)
             SBOX = 4'h0;
             if (B == 4'd4)
             SBOX = 4'hF;
             if (B == 4'd5)
             SBOX = 4'hE;
             if (B == 4'd6)
             SBOX = 4'h6;
             if (B == 4'd7)
             SBOX = 4'h5;
             if (B == 4'd8)
             SBOX = 4'hA;
             if (B == 4'd9)
             SBOX = 4'hD;
             if (B == 4'd10)
             SBOX = 4'h4;
             if (B == 4'd11)
             SBOX = 4'h8;
             if (B == 4'd12)
             SBOX = 4'h9;
             if (B == 4'd13)
             SBOX = 4'h3;
             if (B == 4'd14)
             SBOX = 4'h7;
             if (B == 4'd15)
             SBOX = 4'h2;
             end
      6'b010100:              
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'h5;
             if (B == 4'd2)
             SBOX = 4'hE;
             if (B == 4'd3)
             SBOX = 4'hC;
             if (B == 4'd4)
             SBOX = 4'hA;
             if (B == 4'd5)
             SBOX = 4'h7;
             if (B == 4'd6)
             SBOX = 4'h0;
             if (B == 4'd7)
             SBOX = 4'hD;
             if (B == 4'd8)
             SBOX = 4'h6;
             if (B == 4'd9)
             SBOX = 4'h2;
             if (B == 4'd10)
             SBOX = 4'hB;
             if (B == 4'd11)
             SBOX = 4'h4;
             if (B == 4'd12)
             SBOX = 4'h9;
             if (B == 4'd13)
             SBOX = 4'h3;
             if (B == 4'd14)
             SBOX = 4'hF;
             if (B == 4'd15)
             SBOX = 4'h8;
             end
      6'b010101:              
             begin
             if (B == 4'd0)
             SBOX = 4'h0;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'h8;
             if (B == 4'd3)
             SBOX = 4'h9;
             if (B == 4'd4)
             SBOX = 4'hD;
             if (B == 4'd5)
             SBOX = 4'h2;
             if (B == 4'd6)
             SBOX = 4'hA;
             if (B == 4'd7)
             SBOX = 4'hB;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'h3;
             if (B == 4'd10)
             SBOX = 4'h6;
             if (B == 4'd11)
             SBOX = 4'h5;
             if (B == 4'd12)
             SBOX = 4'h4;
             if (B == 4'd13)
             SBOX = 4'hE;
             if (B == 4'd14)
             SBOX = 4'hF;
             if (B == 4'd15)
             SBOX = 4'h1;
             end
      6'b010110:              
             begin
             if (B == 4'd0)
             SBOX = 4'h8;
             if (B == 4'd1)
             SBOX = 4'h0;
             if (B == 4'd2)
             SBOX = 4'hF;
             if (B == 4'd3)
             SBOX = 4'h3;
             if (B == 4'd4)
             SBOX = 4'h2;
             if (B == 4'd5)
             SBOX = 4'h5;
             if (B == 4'd6)
             SBOX = 4'hE;
             if (B == 4'd7)
             SBOX = 4'hB;
             if (B == 4'd8)
             SBOX = 4'h1;
             if (B == 4'd9)
             SBOX = 4'hA;
             if (B == 4'd10)
             SBOX = 4'h4;
             if (B == 4'd11)
             SBOX = 4'h7;
             if (B == 4'd12)
             SBOX = 4'hC;
             if (B == 4'd13)
             SBOX = 4'h9;
             if (B == 4'd14)
             SBOX = 4'hD;
             if (B == 4'd15)
             SBOX = 4'h6;
             end
      6'b010111:              
             begin
             if (B == 4'd0)
             SBOX = 4'h3;
             if (B == 4'd1)
             SBOX = 4'h0;
             if (B == 4'd2)
             SBOX = 4'h6;
             if (B == 4'd3)
             SBOX = 4'hF;
             if (B == 4'd4)
             SBOX = 4'h1;
             if (B == 4'd5)
             SBOX = 4'hE;
             if (B == 4'd6)
             SBOX = 4'h9;
             if (B == 4'd7)
             SBOX = 4'h2;
             if (B == 4'd8)
             SBOX = 4'hD;
             if (B == 4'd9)
             SBOX = 4'h8;
             if (B == 4'd10)
             SBOX = 4'hC;
             if (B == 4'd11)
             SBOX = 4'h4;
             if (B == 4'd12)
             SBOX = 4'hB;
             if (B == 4'd13)
             SBOX = 4'hA;
             if (B == 4'd14)
             SBOX = 4'h5;
             if (B == 4'd15)
             SBOX = 4'h7;
             end
      6'b011000:              
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'hA;
             if (B == 4'd2)
             SBOX = 4'h6;
             if (B == 4'd3)
             SBOX = 4'h8;
             if (B == 4'd4)
             SBOX = 4'hF;
             if (B == 4'd5)
             SBOX = 4'hB;
             if (B == 4'd6)
             SBOX = 4'h0;
             if (B == 4'd7)
             SBOX = 4'h4;
             if (B == 4'd8)
             SBOX = 4'hC;
             if (B == 4'd9)
             SBOX = 4'h3;
             if (B == 4'd10)
             SBOX = 4'h5;
             if (B == 4'd11)
             SBOX = 4'h9;
             if (B == 4'd12)
             SBOX = 4'h7;
             if (B == 4'd13)
             SBOX = 4'hD;
             if (B == 4'd14)
             SBOX = 4'h2;
             if (B == 4'd15)
             SBOX = 4'hE;
             end
      6'b011001:            
             begin
             if (B == 4'd0)
             SBOX = 4'hF;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'h2;
             if (B == 4'd3)
             SBOX = 4'hA;
             if (B == 4'd4)
             SBOX = 4'h6;
             if (B == 4'd5)
             SBOX = 4'h4;
             if (B == 4'd6)
             SBOX = 4'h5;
             if (B == 4'd7)
             SBOX = 4'h0;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'h9;
             if (B == 4'd10)
             SBOX = 4'hE;
             if (B == 4'd11)
             SBOX = 4'hD;
             if (B == 4'd12)
             SBOX = 4'h1;
             if (B == 4'd13)
             SBOX = 4'hB;
             if (B == 4'd14)
             SBOX = 4'h8;
             if (B == 4'd15)
             SBOX = 4'h3;
             end
      6'b011010:            
             begin
             if (B == 4'd0)
             SBOX = 4'hB;
             if (B == 4'd1)
             SBOX = 4'h6;
             if (B == 4'd2)
             SBOX = 4'h3;
             if (B == 4'd3)
             SBOX = 4'h4;
             if (B == 4'd4)
             SBOX = 4'hC;
             if (B == 4'd5)
             SBOX = 4'hF;
             if (B == 4'd6)
             SBOX = 4'hE;
             if (B == 4'd7)
             SBOX = 4'h2;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'hD;
             if (B == 4'd10)
             SBOX = 4'h8;
             if (B == 4'd11)
             SBOX = 4'h0;
             if (B == 4'd12)
             SBOX = 4'h5;
             if (B == 4'd13)
             SBOX = 4'hA;
             if (B == 4'd14)
             SBOX = 4'h9;
             if (B == 4'd15)
             SBOX = 4'h1;
             end
      6'b011011:             
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'hB;
             if (B == 4'd3)
             SBOX = 4'h0;
             if (B == 4'd4)
             SBOX = 4'hF;
             if (B == 4'd5)
             SBOX = 4'hE;
             if (B == 4'd6)
             SBOX = 4'h6;
             if (B == 4'd7)
             SBOX = 4'h5;
             if (B == 4'd8)
             SBOX = 4'hA;
             if (B == 4'd9)
             SBOX = 4'hD;
             if (B == 4'd10)
             SBOX = 4'h4;
             if (B == 4'd11)
             SBOX = 4'h8;
             if (B == 4'd12)
             SBOX = 4'h9;
             if (B == 4'd13)
             SBOX = 4'h3;
             if (B == 4'd14)
             SBOX = 4'h7;
             if (B == 4'd15)
             SBOX = 4'h2;
             end
      6'b011100:             
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'h5;
             if (B == 4'd2)
             SBOX = 4'hE;
             if (B == 4'd3)
             SBOX = 4'hC;
             if (B == 4'd4)
             SBOX = 4'hA;
             if (B == 4'd5)
             SBOX = 4'h7;
             if (B == 4'd6)
             SBOX = 4'h0;
             if (B == 4'd7)
             SBOX = 4'hD;
             if (B == 4'd8)
             SBOX = 4'h6;
             if (B == 4'd9)
             SBOX = 4'h2;
             if (B == 4'd10)
             SBOX = 4'hB;
             if (B == 4'd11)
             SBOX = 4'h4;
             if (B == 4'd12)
             SBOX = 4'h9;
             if (B == 4'd13)
             SBOX = 4'h3;
             if (B == 4'd14)
             SBOX = 4'hF;
             if (B == 4'd15)
             SBOX = 4'h8;
             end
      6'b011101:              
             begin
             if (B == 4'd0)
             SBOX = 4'h0;
             if (B == 4'd1)
             SBOX = 4'hC;
             if (B == 4'd2)
             SBOX = 4'h8;
             if (B == 4'd3)
             SBOX = 4'h9;
             if (B == 4'd4)
             SBOX = 4'hD;
             if (B == 4'd5)
             SBOX = 4'h2;
             if (B == 4'd6)
             SBOX = 4'hA;
             if (B == 4'd7)
             SBOX = 4'hB;
             if (B == 4'd8)
             SBOX = 4'h7;
             if (B == 4'd9)
             SBOX = 4'h3;
             if (B == 4'd10)
             SBOX = 4'h6;
             if (B == 4'd11)
             SBOX = 4'h5;
             if (B == 4'd12)
             SBOX = 4'h4;
             if (B == 4'd13)
             SBOX = 4'hE;
             if (B == 4'd14)
             SBOX = 4'hF;
             if (B == 4'd15)
             SBOX = 4'h1;
             end
      6'b011110:              
             begin
             if (B == 4'd0)
             SBOX = 4'h8;
             if (B == 4'd1)
             SBOX = 4'h0;
             if (B == 4'd2)
             SBOX = 4'hF;
             if (B == 4'd3)
             SBOX = 4'h3;
             if (B == 4'd4)
             SBOX = 4'h2;
             if (B == 4'd5)
             SBOX = 4'h5;
             if (B == 4'd6)
             SBOX = 4'hE;
             if (B == 4'd7)
             SBOX = 4'hB;
             if (B == 4'd8)
             SBOX = 4'h1;
             if (B == 4'd9)
             SBOX = 4'hA;
             if (B == 4'd10)
             SBOX = 4'h4;
             if (B == 4'd11)
             SBOX = 4'h7;
             if (B == 4'd12)
             SBOX = 4'hC;
             if (B == 4'd13)
             SBOX = 4'h9;
             if (B == 4'd14)
             SBOX = 4'hD;
             if (B == 4'd15)
             SBOX = 4'h6;
             end
      6'b011111:              
             begin
             if (B == 4'd0)
             SBOX = 4'h3;
             if (B == 4'd1)
             SBOX = 4'h0;
             if (B == 4'd2)
             SBOX = 4'h6;
             if (B == 4'd3)
             SBOX = 4'hF;
             if (B == 4'd4)
             SBOX = 4'h1;
             if (B == 4'd5)
             SBOX = 4'hE;
             if (B == 4'd6)
             SBOX = 4'h9;
             if (B == 4'd7)
             SBOX = 4'h2;
             if (B == 4'd8)
             SBOX = 4'hD;
             if (B == 4'd9)
             SBOX = 4'h8;
             if (B == 4'd10)
             SBOX = 4'hC;
             if (B == 4'd11)
             SBOX = 4'h4;
             if (B == 4'd12)
             SBOX = 4'hB;
             if (B == 4'd13)
             SBOX = 4'hA;
             if (B == 4'd14)
             SBOX = 4'h5;
             if (B == 4'd15)
             SBOX = 4'h7;
             end
      6'b100000:              
             begin
             if (B == 4'd0)
             SBOX = 4'h1;
             if (B == 4'd1)
             SBOX = 4'hA;
             if (B == 4'd2)
             SBOX = 4'h6;
             if (B == 4'd3)
             SBOX = 4'h8;
             if (B == 4'd4)
             SBOX = 4'hF;
             if (B == 4'd5)
             SBOX = 4'hB;
             if (B == 4'd6)
             SBOX = 4'h0;
             if (B == 4'd7)
             SBOX = 4'h4;
             if (B == 4'd8)
             SBOX = 4'hC;
             if (B == 4'd9)
             SBOX = 4'h3;
             if (B == 4'd10)
             SBOX = 4'h5;
             if (B == 4'd11)
             SBOX = 4'h9;
             if (B == 4'd12)
             SBOX = 4'h7;
             if (B == 4'd13)
             SBOX = 4'hD;
             if (B == 4'd14)
             SBOX = 4'h2;
             if (B == 4'd15)
             SBOX = 4'hE;
             end
      endcase
    end
  endfunction

  function [32:1] f(input [32:1] L, input [32:1] K, input [5:0] y); //?????? ????? ????? (???????? ????????? ?????) ? ????????? ???? ???? (????????? ???? ? 32 ?? 48 ???)
    reg [32:1] temp;
    reg [32:1] temp_after_s_box;
    reg [4:1] B[8:1];
    reg [4:1] a1,a2,a3,a4,a5,a6,a7,a8;
    begin
      temp = K ^ L; //?????? ???? ? ?????? ?????
      B[1] = temp[32:29];//???????????? ?????? temp ? b(????????? ???? ?? 8 ?????? ?? 4 ????)
      B[2] = temp[28:25];
      B[3] = temp[24:21];
      B[4] = temp[20:17];
      B[5] = temp[16:13];
      B[6] = temp[12:9];
      B[7] = temp[8:5];
      B[8] = temp[4:1];
      a1 = SBOX(y, B[1]);
      a2 = SBOX(y, B[2]);
      a3 = SBOX(y, B[3]);
      a4 = SBOX(y, B[4]);
      a5 = SBOX(y, B[5]);
      a6 = SBOX(y, B[6]);
      a7 = SBOX(y, B[7]);
      a8 = SBOX(y, B[8]);
      temp_after_s_box = {a1, a2, a3, a4, a5, a6, a7, a8};//?????????? ???? ????????, ?????????? ? ?????????? ??????????? ????? s-box (????????????? ???)
      f = temp_after_s_box <<< 11;//??????????? ?????
    end
  endfunction

  reg [32:1] L[32:0], R[32:0];
  reg [32:1] K[8:1];//????? ?????
  integer i,  g = 1, t = 0;
  reg [5:0] y = 5'b000000;

  always @(posedge clk && y<5'b000001)
  begin
    {L[0], R[0]} = message;
    K[1] = key[256:224]; K[2] = key[224:192]; K[3] = key[192:160]; K[4] = key[160:128]; K[5] = key[128:96]; K[6] = key[96:64]; K[7] = key[64:32]; K[8] = key[32:1];
    for (i = 1; i < 25; i = i+1)
    begin
      R[i]=L[i-1];//?????? ??????? ?????, ?.?. ?????? ????? ????- ??? ??????
      y = y + 5'b000001;//????? ????????
      if (g == 9)
         begin
         g = 1;//0
         end
      L[i] = R[i-1] ^ f(L[i-1], K[g], y);
      g = g + 1;
    end
    for(i = 25; i <= 32; i = i+1)//? 25 ?? 32 ????????
    begin
      R[i]=L[i-1];//?????? ??????? ?????, ?.?. ?????? ????? ????- ??? ??????
      y = y + 5'b000001;//????? ????????
      if (t == 8/*9*/)
          begin
          t = 0;
          end
      L[i] = R[i-1] ^ f(L[i-1], K[8-t], y);
      t = t+1;
    end
    
    ciphertext[64:1] = ({R[32], L[32]});
  end
endmodule