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

  function [4:1] SBOX(input [4:1] B, input k);//cам s-box (на ввход получает 4 бит, и номер итерации)
    reg [3:0] Sbox[7:0][15:0];//8 s boxов для 8 разбиытх частей нашего текста(п
    begin
	Sbox[7][15] = {{4'hF, 4'hC, 4'h2, 4'hA, 4'h6, 4'h4, 4'h5, 4'h0, 4'h7, 4'h9, 4'hE, 4'hD, 4'h1, 4'hB, 4'h8, 4'h3},//позже перепровериь
        {4'hB, 4'h6, 4'h3, 4'h4, 4'hC, 4'hF, 4'hE, 4'h2, 4'h7, 4'hD, 4'h8, 4'h0, 4'h5, 4'hA, 4'h9, 4'h1},
        {4'h1, 4'hC, 4'hB, 4'h0, 4'hF, 4'hE, 4'h6, 4'h5, 4'hA, 4'hD, 4'h4, 4'h8, 4'h9, 4'h3, 4'h7, 4'h2},
        {4'h1, 4'h5, 4'hE, 4'hC, 4'hA, 4'h7, 4'h0, 4'hD, 4'h6, 4'h2, 4'hB, 4'h4, 4'h9, 4'h3, 4'hF, 4'h8},
        {4'h0, 4'hC, 4'h8, 4'h9, 4'hD, 4'h2, 4'hA, 4'hB, 4'h7, 4'h3, 4'h6, 4'h5, 4'h4, 4'hE, 4'hF, 4'h1},
        {4'h8, 4'h0, 4'hF, 4'h3, 4'h2, 4'h5, 4'hE, 4'hB, 4'h1, 4'hA, 4'h4, 4'h7, 4'hC, 4'h9, 4'hD, 4'h6},
        {4'h3, 4'h0, 4'h6, 4'hF, 4'h1, 4'hE, 4'h9, 4'h2, 4'hD, 4'h8, 4'hC, 4'h4, 4'hB, 4'hA, 4'h5, 4'h7},
        {4'h1, 4'hA, 4'h6, 4'h8, 4'hF, 4'hB, 4'h0, 4'h4, 4'hC, 4'h3, 4'h5, 4'h9, 4'h7, 4'hD, 4'h2, 4'hE}};
      case(k)
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

  function [32:1] f(input [32:1] R, input [32:1] K, input k); //вводим часть блока (половину исхлдного блока) и добавляем туда ключ (расширяем блок с 32 до 48 бит)
    reg [32:1] temp;
    reg [32:1] temp_after_s_box;
    reg [4:1] B[8:1];
    reg [4:1] a1, a2, a3, a4, a5, a6, a7, a8;
    begin
      temp = K ^ R; //ксорит ключ с перемешанной частью блока
      B[1] = temp[32:29];//присваивание частей temp в b(разбиваем блок на 8 частей по 4 бита)
      B[2] = temp[28:25];
      B[3] = temp[24:21];
      B[4] = temp[20:17];
      B[5] = temp[16:13];
      B[6] = temp[12:9];
      B[7] = temp[8:5];
      B[8] = temp[4:1];
      a1 = SBOX(B[1], k);//полкченные результаты после прохождения s-boxа
      a2 = SBOX(B[2], k);
      a3 = SBOX(B[3], k);
      a4 = SBOX(B[4], k);
      a5 = SBOX(B[5], k);
      a6 = SBOX(B[6], k);
      a7 = SBOX(B[7], k);
      a8 = SBOX(B[8], k);
      temp_after_s_box = {a1, a2, a3, a4, a5, a6, a7, a8};//склеивание всех значений, полученных в результате прохождения через s-box (перепроверить это)
      f = temp_after_s_box <<< 11;//циклический сдвиг
    end
  endfunction

  reg [32:1] L[32:0], R[32:0];
  wire [32:1] key1, key2, key3, key4, key5, key6, key7, key8;
  reg [32:1] K[8:1];//часть ключа
  integer i = 1, k = 0, g = 0, t = 0, w = 0, y = 0;
  ProcessKey pk(key1, key2, key3, key4, key5, key6, key7, key8, key, clk);//пользуемся модулем processkey

  always @(posedge clk)
  begin
    L[0] = message[64:33];
    R[0] = message[32:1];
    K[1] = key1; K[2] = key2; K[3] = key3; K[4] = key4; K[5] = key5; K[6] = key6; K[7] = key7; K[8] = key8;

    if(i<=8)//1 раз прогоняем (8 итераций) (c 1 по 8 итерация)
    begin
      L[i]=R[i-1];//меняем местами блоки, т.е. теперь левый блок- это правый
      k = k + 1;//номер итерации
      g = g + 1;
      R[i] = L[i-1] ^ f(R[i-1], K[g], k);
      i=i+1;
    end
     if(i<=16 && i>=9)//2 раз прогоняем (с 9 по 16 итерация)
    begin
      L[i]=R[i-1];
      k = k + 1;
      t = t + 1;
      R[i]=L[i-1] ^ f(R[i-1], K[t], k);
      i=i+1;
    end
     if(i<=24 && i>=17)//3 раз прогоняем (с 17 по 24 итерция)
    begin
      L[i]=R[i-1];
      k = k + 1;
      w = w + 1;
      R[i]=L[i-1] ^ f(R[i-1], K[w], k);
      i=i+1;
    end
     if(i<=32 && i>=25)//4 раз прогоняем (с 25 по 32 итерация)
    begin
      L[i]=R[i-1];
      k = k + 1;
      y = y + 1;
      R[i]=L[i-1] ^ f(R[i-1], K[8-y], k);//ключ в обратном порядке
      i=i+1;
    end
    ciphertext = ({R[32], L[32]});
  end
endmodule