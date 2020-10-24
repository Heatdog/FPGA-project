`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2020 21:06:07
// Design Name: 
// Module Name: ProcessKey
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


module ProcessKey(output reg [32:1] key1, key2, key3, key4, key5, key6, key7, key8, input [256:1] key, input clk);
  reg [32:1] K[1:8];//массив 8 ключей по 32 бит каждый

  always @(posedge clk)
  begin
    K[1] = key[256:224];//побитовое разбиение ключей
    K[2] = key[224:192];
    K[3] = key[192:160];
    K[4] = key[160:128];
    K[5] = key[128:96];
    K[6] = key[96:64];
    K[7] = key[64:32];
    K[8] = key[32:1];
    key1 = K[1];//присваивание значения ключам
    key2 = K[2];
    key3 = K[3];
    key4 = K[4];
    key5 = K[5];
    key6 = K[6];
    key7 = K[7];
    key8 = K[8];
  end
endmodule
