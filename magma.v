`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2020 23:07:34
// Design Name: 
// Module Name: magma
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


module magma(
    input CLK,
    input buffer,
    output encrypted,
    output decrypted
    );
integer Sbox[8][16] = {    //таблица замены
        {4'hF, 4'hC, 4'h2, 4'hA, 4'h6, 4'h4, 4'h5, 4'h0, 4'h7, 4'h9, 4'hE, 4'hD, 4'h1, 4'hB, 4'h8, 4'h3},
        {4'hB, 4'h6, 4'h3, 4'h4, 4'hC, 4'hF, 4'hE, 4'h2, 4'h7, 4'hD, 4'h8, 4'h0, 4'h5, 4'hA, 4'h9, 4'h1},
        {4'h1, 4'hC, 4'hB, 4'h0, 4'hF, 4'hE, 4'h6, 4'h5, 4'hA, 4'hD, 4'h4, 4'h8, 4'h9, 4'h3, 4'h7, 4'h2},
        {4'h1, 4'h5, 4'hE, 4'hC, 4'hA, 4'h7, 4'h0, 4'hD, 4'h6, 4'h2, 4'hB, 4'h4, 4'h9, 4'h3, 4'hF, 4'h8},
        {4'h0, 4'hC, 4'h8, 4'h9, 4'hD, 4'h2, 4'hA, 4'hB, 4'h7, 4'h3, 4'h6, 4'h5, 4'h4, 4'hE, 4'hF, 4'h1},
        {4'h8, 4'h0, 4'hF, 4'h3, 4'h2, 4'h5, 4'hE, 4'hB, 4'h1, 4'hA, 4'h4, 4'h7, 4'hC, 4'h9, 4'hD, 4'h6},
        {4'h3, 4'h0, 4'h6, 4'hF, 4'h1, 4'hE, 4'h9, 4'h2, 4'hD, 4'h8, 4'hC, 4'h4, 4'hB, 4'hA, 4'h5, 4'h7},
        {4'h1, 4'hA, 4'h6, 4'h8, 4'hF, 4'hB, 4'h0, 4'h4, 4'hC, 4'h3, 4'h5, 4'h9, 4'h7, 4'hD, 4'h2, 4'hE}
};
function split_256bits_to_32bits;//разделение 256 бит на 32
input [0:7] key256b;
reg [0:31] key32b;
integer [0:7] p8 = key256b;
integer [0:31] p32 = keys32b;
begin
    for (p32= keys32b; p32 < keys32b + 8; p32=p32+1) //может тут выполняться неправльно (если не получиться попробовать repeat)
    begin
        for (i = 0; i < 4; i=i+1) 
        begin
            p32 = (p32 << 8) | (p8 + i);
        end
        p8 = p8 + 4;
    end
end
endfuction
////////////////
function split_64bits_to_32bits(input [0:63] block64b,
input [0:31] block32b_1,
input [0:31] block32b_2);
begin
    block32b_2 [0:31] = (block64b);
    block32b_1 [0:31] = (block64b >> 32);
end
endfuction
////////////////////////////
function join_8bits_to_64bits;
input [0:7] block8b;
reg [0:63] block64b;
integer [0:7] p = blocks8b;
begin
for (p = blocks8b; p < blocks8b + 8; p = p+1)
begin
    block64b = (block64b << 8) | p;
end
end
endfuction
//////////////////
function feistel_cipher;
input [0:7] mode;
input [0:31] block32b_1;
input [0:31] block32b_2;
input [0:31] keys32b;
begin
case(mode)
    "E": begin
         for (round = 0; round < 24; round = round + 1)
         begin
              round_of_feistel_cipher(block32b_1, block32b_2, keys32b, round);
         end
         for (round = 31; round >= 24; round = round - 1)
         begin
              round_of_feistel_cipher(block32b_1, block32b_2, keys32b, round);
              break;
         end
         end
     default:begin
             for (round = 0; round < 8; round = round + 1)
             begin
                  round_of_feistel_cipher(block32b_1, block32b_2, keys32b, round);
             end
             for (round = 31; round >= 8; round = round - 1)
             begin
                round_of_feistel_cipher(block32b_1, block32b_2, keys32b, round);
                break;
             end
             end
end
endfuction
//////////////////
function round_of_feistel_cipher;
input [0:31] block32b_1;
input [0:31] block32b_2;
input [0:31] keys32b;
input [0:31] round;
reg [0:31] result_of_iter;
reg [0:31] temp;
begin
result_of_iter = (*block32b_1 + keys32b[round % 8]) % UINT32_MAX;//как поделить на 32 бита?
temp = block32b_1;
block32b_1 = result_of_iter ^ *block32b_2;
block32b_2 = temp;
end
endfuction
//////////////////
function substitution_table;
input [0:31] blocks32b;
input [0:7] sbox_row;
reg [0:7] 
///////////////////
function GOST_28147;
input [0:7] to;
input [0:7] mode;
input [0:7] key256b;
input [0:7] from;
input length;
reg [0:31] N1;
reg [0:31] N2;
reg [0:31] key32b[8];
integer i = 0;
begin
length = length % 8 == 0 ? length : length + (8 - (length % 8));
split_256bits_to_32bits(key256b, keys32b);
for (i = 0; i < length; i = i + 8)
begin
    split_64bits_to_32bits(join_8bits_to_64bits(from + i),N1, N2;
    feistel_cipher(mode, &N1, &N2, keys32b);
    split_64bits_to_8bits(join_32bits_to_64bits(N1, N2),(to + i));
end
end
endfuction
////////////////////////
endmodule
