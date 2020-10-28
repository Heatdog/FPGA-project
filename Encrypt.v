`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2020 20:38:27
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

  function [4:1] SBOX(input [4:1] B, input y);//cам s-box (на ввход получает 4 бит, и номер итерации)
    reg [3:0] Sbox[7:0][15:0];//8 s boxов для 8 разбиытх частей нашего текста(п
    begin
      Sbox[0][0] = 4'hF;
      Sbox[0][1] = 4'hC;
      Sbox[0][2] = 4'h2;
      Sbox[0][3] = 4'hA;
      Sbox[0][4] = 4'h6;
      Sbox[0][5] = 4'h4;
      Sbox[0][6] = 4'h5;
      Sbox[0][7] = 4'h0;
      Sbox[0][8] = 4'h7;
      Sbox[0][9] = 4'h9;
      Sbox[0][10] = 4'hE;
      Sbox[0][11] = 4'hD;
      Sbox[0][12] = 4'h1;
      Sbox[0][13] = 4'hB;
      Sbox[0][14] = 4'h8;
      Sbox[0][15] = 4'h3;
      Sbox[1][0] = 4'hB;
      Sbox[1][1] = 4'h6;
      Sbox[1][2] = 4'h3;
      Sbox[1][3] = 4'h4;
      Sbox[1][4] = 4'hC;
      Sbox[1][5] = 4'hF;
      Sbox[1][6] = 4'hE;
      Sbox[1][7] = 4'h2;
      Sbox[1][8] = 4'h7;
      Sbox[1][9] = 4'hD;
      Sbox[1][10] = 4'h8;
      Sbox[1][11] = 4'h0;
      Sbox[1][12] = 4'h5;
      Sbox[1][13] = 4'hA;
      Sbox[1][14] = 4'h9;
      Sbox[1][15] = 4'h1;
      Sbox[2][0] = 4'h1;
      Sbox[2][1] = 4'hC;
      Sbox[2][2] = 4'hB;
      Sbox[2][3] = 4'h0;
      Sbox[2][4] = 4'hF;
      Sbox[2][5] = 4'hE;
      Sbox[2][6] = 4'h6;
      Sbox[2][7] = 4'h5;
      Sbox[2][8] = 4'hA;
      Sbox[2][9] = 4'hD;
      Sbox[2][10] = 4'h4;
      Sbox[2][11] = 4'h8;
      Sbox[2][12] = 4'h9;
      Sbox[2][13] = 4'h3;
      Sbox[2][14] = 4'h7;
      Sbox[2][15] = 4'h2;
      Sbox[3][0] = 4'h1;
      Sbox[3][1] = 4'h5;
      Sbox[3][2] = 4'hE;
      Sbox[3][3] = 4'hC;
      Sbox[3][4] = 4'hA;
      Sbox[3][5] = 4'h7;
      Sbox[3][6] = 4'h0;
      Sbox[3][7] = 4'hD;
      Sbox[3][8] = 4'h6;
      Sbox[3][9] = 4'h2;
      Sbox[3][10] = 4'hB;
      Sbox[3][11] = 4'h4;
      Sbox[3][12] = 4'h9;
      Sbox[3][13] = 4'h3;
      Sbox[3][14] = 4'hF;
      Sbox[3][15] = 4'h8;
      Sbox[4][0] = 4'h0;
      Sbox[4][1] = 4'hC;
      Sbox[4][2] = 4'h8;
      Sbox[4][3] = 4'h9;
      Sbox[4][4] = 4'hD;
      Sbox[4][5] = 4'h2;
      Sbox[4][6] = 4'hA;
      Sbox[4][7] = 4'hB;
      Sbox[4][8] = 4'h7;
      Sbox[4][9] = 4'h3;
      Sbox[4][10] = 4'h6;
      Sbox[4][11] = 4'h5;
      Sbox[4][12] = 4'h4;
      Sbox[4][13] = 4'hE;
      Sbox[4][14] = 4'hF;
      Sbox[4][15] = 4'h1;
      Sbox[5][0] = 4'h8;
      Sbox[5][1] = 4'h0;
      Sbox[5][2] = 4'hF;
      Sbox[5][3] = 4'h3;
      Sbox[5][4] = 4'h2;
      Sbox[5][5] = 4'h5;
      Sbox[5][6] = 4'hE;
      Sbox[5][7] = 4'hB;
      Sbox[5][8] = 4'h1;
      Sbox[5][9] = 4'hA;
      Sbox[5][10] = 4'h4;
      Sbox[5][11] = 4'h7;
      Sbox[5][12] = 4'hC;
      Sbox[5][13] = 4'h9;
      Sbox[5][14] = 4'hD;
      Sbox[5][15] = 4'h6;
      Sbox[6][0] = 4'h3;
      Sbox[6][1] = 4'h0;
      Sbox[6][2] = 4'h6;
      Sbox[6][3] = 4'hF;
      Sbox[6][4] = 4'h1;
      Sbox[6][5] = 4'hE;
      Sbox[6][6] = 4'h9;
      Sbox[6][7] = 4'h2;
      Sbox[6][8] = 4'hD;
      Sbox[6][9] = 4'h8;
      Sbox[6][10] = 4'hC;
      Sbox[6][11] = 4'h4;
      Sbox[6][12] = 4'hB;
      Sbox[6][13] = 4'hA;
      Sbox[6][14] = 4'h5;
      Sbox[6][15] = 4'h7;
      Sbox[7][0] = 4'h1;
      Sbox[7][1] = 4'hA;
      Sbox[7][2] = 4'h6;
      Sbox[7][3] = 4'h8;
      Sbox[7][4] = 4'hF;
      Sbox[7][5] = 4'hB;
      Sbox[7][6] = 4'h0;
      Sbox[7][7] = 4'h4;
      Sbox[7][8] = 4'hC;
      Sbox[7][9] = 4'h3;
      Sbox[7][10] = 4'h5;
      Sbox[7][11] = 4'h9;
      Sbox[7][12] = 4'h7;
      Sbox[7][13] = 4'hD;
      Sbox[7][14] = 4'h2;
      Sbox[7][15] = 4'hE;
      case(y)
      1: SBOX = Sbox[0][B];//как эта функция понимает число B? (вроде в лючбом случае компьютер считает все в двоичной системе счисления)
      2: SBOX = Sbox[1][B];
      3: SBOX = Sbox[2][B];
      4: SBOX = Sbox[3][B];
      5: SBOX = Sbox[4][B];
      6: SBOX = Sbox[5][B];
      7: SBOX = Sbox[6][B];
      8: SBOX = Sbox[7][B];
      9: SBOX = Sbox[0][B];
      10: SBOX = Sbox[1][B];
      11: SBOX = Sbox[2][B];
      12: SBOX = Sbox[3][B];
      13: SBOX = Sbox[4][B];
      14: SBOX = Sbox[5][B];
      15: SBOX = Sbox[6][B];
      16: SBOX = Sbox[7][B];
      17: SBOX = Sbox[0][B];
      18: SBOX = Sbox[1][B];
      19: SBOX = Sbox[2][B];
      20: SBOX = Sbox[3][B];
      21: SBOX = Sbox[4][B];
      22: SBOX = Sbox[5][B];
      23: SBOX = Sbox[6][B];
      24: SBOX = Sbox[7][B];
      25: SBOX = Sbox[0][B];
      26: SBOX = Sbox[1][B];
      27: SBOX = Sbox[2][B];
      28: SBOX = Sbox[3][B];
      29: SBOX = Sbox[4][B];
      30: SBOX = Sbox[5][B];
      31: SBOX = Sbox[6][B];
      32: SBOX = Sbox[7][B];
      endcase
    end
  endfunction

  function [32:1] f(input [32:1] R, input [32:1] K, input y); //вводим часть блока (половину исхлдного блока) и добавляем туда ключ (расширяем блок с 32 до 48 бит)
    reg [32:1] temp;
    reg [32:1] temp_after_s_box;
    reg [4:1] B[8:1];
    begin
      temp = K ^ R; //ксорит ключ с частью блока
      B[1] = temp[32:29];//присваивание частей temp в b(разбиваем блок на 8 частей по 4 бита)
      B[2] = temp[28:25];
      B[3] = temp[24:21];
      B[4] = temp[20:17];
      B[5] = temp[16:13];
      B[6] = temp[12:9];
      B[7] = temp[8:5];
      B[8] = temp[4:1];
      temp_after_s_box = {SBOX(y, B[1]), SBOX(y, B[2]), SBOX(y, B[3]), SBOX(y, B[4]), SBOX(y, B[5]), SBOX(y, B[6]), SBOX(y, B[7]), SBOX(y, B[8])};//склеивание всех значений, полученных в результате прохождения через s-box (перепроверить это)
      f = temp_after_s_box <<< 11;//циклический сдвиг
    end
  endfunction

  reg [32:1] L[32:0], R[32:0];
  reg [32:1] K[8:1];//часть ключа
  integer i, y = 0, g = 1, t = 0;

  always @(posedge clk && y<32)
  begin
    {L[0], R[0]} = message;
    K[1] = key[256:224]; K[2] = key[224:192]; K[3] = key[192:160]; K[4] = key[160:128]; K[5] = key[128:96]; K[6] = key[96:64]; K[7] = key[64:32]; K[8] = key[32:1];

    for (i = 1; i <= 24; i = i+1)
    begin
      L[i]=R[i-1];//меняем местами блоки, т.е. теперь левый блок- это правый
      y = y + 1;//номер итерации
      if (g == 9)
         begin
         g = 0;
         end
      R[i] = L[i-1] ^ f(R[i-1], K[g], y);
      g = g + 1;
    end
    for(i = 25; i <= 32; i = i+1)//с 25 по 32 итерация
    begin
      L[i]=R[i-1];//меняем местами блоки, т.е. теперь левый блок- это правый
      y = y + 1;//номер итерации
      if (t == 9)
          begin
          t = 0;
          end
      R[i] = L[i-1] ^ f(R[i-1], K[8-t], y);
      t = t+1;
    end
    
    ciphertext[64:1] = ({R[32], L[32]});
  end
endmodule