  
#include <stdio.h>
#include <stdint.h>

// 10101100 << 2 = 10110000 | 00000010 = 10110010
#define LSHIFT_nBIT(x, L, N) (((x << L) | (x >> (-L & (N - 1)))) & (((uint64_t)1 << N) - 1)) /* макрос для сдвига влево, 1 число- 32 битный 
блок, 2 число - насколько нужно его сдвинуть, общее кол-во бит*/

#define BUFF_SIZE 1024

size_t GOST_28147(uint8_t * to, uint8_t mode, uint8_t * key256b, uint8_t * from, size_t length);
void feistel_cipher(uint8_t mode, uint32_t * block32b_1, uint32_t * block32b_2, uint32_t * keys32b);
void round_of_feistel_cipher(uint32_t * block32b_1, uint32_t * block32b_2, uint32_t * keys32b, uint8_t round);

uint32_t substitution_table(uint32_t block32b, uint8_t sbox_row);
void substitution_table_by_4bits(uint8_t * blocks4b, uint8_t sbox_row);

void split_256bits_to_32bits(uint8_t * key256b, uint32_t * keys32b);
void split_64bits_to_32bits(uint64_t block64b, uint32_t * block32b_1, uint32_t * block32b_2);
void split_64bits_to_8bits(uint64_t block64b, uint8_t * blocks8b);
void split_32bits_to_8bits(uint32_t block32b, uint8_t * blocks4b);

uint64_t join_32bits_to_64bits(uint32_t block32b_1, uint32_t block32b_2);
uint64_t join_8bits_to_64bits(uint8_t * blocks8b);
uint32_t join_4bits_to_32bits(uint8_t * blocks4b);

static inline void print_array(uint8_t * array, size_t length);
static inline void print_bits(uint64_t x, register uint64_t Nbit);

// 1 | 4 -> 0xC
static const uint8_t Sbox[8][16] = {    //таблица для возвращения числа (наприме для 1 раунда должно вернуться 4 число)
    {0xF, 0xC, 0x2, 0xA, 0x6, 0x4, 0x5, 0x0, 0x7, 0x9, 0xE, 0xD, 0x1, 0xB, 0x8, 0x3}, 
    {0xB, 0x6, 0x3, 0x4, 0xC, 0xF, 0xE, 0x2, 0x7, 0xD, 0x8, 0x0, 0x5, 0xA, 0x9, 0x1},
    {0x1, 0xC, 0xB, 0x0, 0xF, 0xE, 0x6, 0x5, 0xA, 0xD, 0x4, 0x8, 0x9, 0x3, 0x7, 0x2},
    {0x1, 0x5, 0xE, 0xC, 0xA, 0x7, 0x0, 0xD, 0x6, 0x2, 0xB, 0x4, 0x9, 0x3, 0xF, 0x8},
    {0x0, 0xC, 0x8, 0x9, 0xD, 0x2, 0xA, 0xB, 0x7, 0x3, 0x6, 0x5, 0x4, 0xE, 0xF, 0x1},
    {0x8, 0x0, 0xF, 0x3, 0x2, 0x5, 0xE, 0xB, 0x1, 0xA, 0x4, 0x7, 0xC, 0x9, 0xD, 0x6},
    {0x3, 0x0, 0x6, 0xF, 0x1, 0xE, 0x9, 0x2, 0xD, 0x8, 0xC, 0x4, 0xB, 0xA, 0x5, 0x7},
    {0x1, 0xA, 0x6, 0x8, 0xF, 0xB, 0x0, 0x4, 0xC, 0x3, 0x5, 0x9, 0x7, 0xD, 0x2, 0xE},
};

int main(void) {
    uint8_t encrypted[BUFF_SIZE], decrypted[BUFF_SIZE];
    uint8_t key256b[32] = "this_is_a_pasw_for_GOST_28147_89";//ключ для шифрования (1 байт(8 бит)- это 1 символ)(ключ на 32 байта)

    uint8_t buffer[BUFF_SIZE], ch;
    size_t position;
    while ((ch = getchar()) != '\n' && position < BUFF_SIZE - 1)
        buffer[position++] = ch;
    buffer[position] = '\0';//добавление 0 для определения строки 66, иначе будет добавляться иное число

    printf("Open message:\n");
    print_array(buffer, position);
    printf("%s\n", buffer);
    putchar('\n');

    position = GOST_28147(encrypted, 'E', key256b, buffer, position);/*сама функция шифрования "Магма" (1 аргумент означает о куда,
    зашифрованное или расшифрованное сообщение будет попадать (в данном сулчае шифрование)
    2 аргумент - это опция (E- encrypt, D- decrypt)
    3 аргумент- это ключ (256 бит)
    4 аргумент - слово, которое мы хотим зашифровать
    5 аргумент - длина сообщения*/
    printf("Encrypted message:\n");
    print_array(encrypted, position);
    printf("%s\n", encrypted);
    putchar('\n');

    printf("Decrypted message:\n");
    position = GOST_28147(decrypted, 'D', key256b, encrypted, position);
    print_array(decrypted, position);
    printf("%s\n", decrypted);
    putchar('\n');

    return 0;
}

size_t GOST_28147(uint8_t * to, uint8_t mode, uint8_t * key256b, uint8_t * from, size_t length) {//в этой функции вычисляется длина
    length = length % 8 == 0 ? length : length + (8 - (length % 8));/*если длина по размеру блока, то вренуть переменуую (length),
    иначе прибавить к этой переменной определенное число, чтобы подходило под блок*/
    uint32_t N1, N2, keys32b[8];/*создание 3 переменных, где N1 и N2- это блоки, а 3- это массив состоящие из ключа key256,
    разитый на 8 блоков по 32 бита*/
    split_256bits_to_32bits(key256b, keys32b);//функция разибиения ключа 256 бит на блоки по 32 бита(170 строчка)

    for (size_t i = 0; i < length; i += 8) { //шфирование всего сообщения, действует до предела нашего сообщения
        split_64bits_to_32bits( //полученное ниже 64-битное число разбиваем на 32 бита (2 блока)
            join_8bits_to_64bits(from + i), //сообщение (8 бит) берем в 64 битный блок , беря адрес массива(from) начиная с 0
            &N1, &N2//получаем 2 блока по 32 бита
        );
        feistel_cipher(mode, &N1, &N2, keys32b);// используем сеть Фейстеля
        split_64bits_to_8bits(
            join_32bits_to_64bits(N1, N2),
            (to + i)
        );
    }

    return length;
}

// keys32b = [K0, K1, K2, K3, K4, K5, K6, K7]
void feistel_cipher(uint8_t mode, uint32_t * block32b_1, uint32_t * block32b_2, uint32_t * keys32b) { /* сеть Фейстеля, в которой мы берем
ключи, полученные раннее + 2 блока + опция(шифр/дешиф) (шифрование и дешифрования симметричны)
*/
    switch (mode) {
        case 'E': case 'e': {
            // K0, K1, K2, K3, K4, K5, K6, K7, K0, K1, K2, K3, K4, K5, K6, K7, K0, K1, K2, K3, K4, K5, K6, K7 (ключи, которые нам нужны)
            for (uint8_t round = 0; round < 24; ++round)
                round_of_feistel_cipher(block32b_1, block32b_2, keys32b, round);

            // K7, K6, K5, K4, K3, K2, K1, K0 (8 ключей от 24 предыдущих, только в другом порядке)
            for (uint8_t round = 31; round >= 24; --round)
                round_of_feistel_cipher(block32b_1, block32b_2, keys32b, round);
            break;
        }
        case 'D': case 'd': {
            // K0, K1, K2, K3, K4, K5, K6, K7
            for (uint8_t round = 0; round < 8; ++round)
                round_of_feistel_cipher(block32b_1, block32b_2, keys32b, round);

            // K7, K6, K5, K4, K3, K2, K1, K0, K7, K6, K5, K4, K3, K2, K1, K0, K7, K6, K5, K4, K3, K2, K1, K0
            for (uint8_t round = 31; round >= 8; --round)
                round_of_feistel_cipher(block32b_1, block32b_2, keys32b, round);
            break;
        }
    }
}

void round_of_feistel_cipher(uint32_t * block32b_1, uint32_t * block32b_2, uint32_t * keys32b, uint8_t round) { /*сам раунд шифрования в сети
Фейстеля*/
    uint32_t result_of_iter, temp;

    // RES = (N1 + Ki) mod 2^32
    result_of_iter = (*block32b_1 + keys32b[round % 8]) % UINT32_MAX; /*складываем 32 битный блок с 32 битным ключом и делим на 2^32,
                                                                      чтобы все уместилось в 32 битный блок*/
    
    // RES = RES -> Sbox
    result_of_iter = substitution_table(result_of_iter, round % 8);
    
    // RES = RES <<< 11
    result_of_iter = (uint32_t)LSHIFT_nBIT(result_of_iter, 11, 32); //сдвиг влево на 11 позиций, помещая 32 бита

    // N1, N2 = (RES xor N2), N1
    temp = *block32b_1; //меняем блоки N1 и N2 местами + xor
    *block32b_1 = result_of_iter ^ *block32b_2;
    *block32b_2 = temp;
}

uint32_t substitution_table(uint32_t block32b, uint8_t sbox_row) {//таблица замены
    uint8_t blocks4bits[4];//создем новый массив, в котором будет храниться по 4 бита (всего 8 блоков)
    split_32bits_to_8bits(block32b, blocks4bits);//разделим 32 бита по 8 бити (нужно рассмотерть функция по 4 бита, но она не работает)
    substitution_table_by_4bits(blocks4bits, sbox_row); //замена блоков подавая 4 блока (сейчас нужно 8!) + раунд схемы Фейстеля
    return join_4bits_to_32bits(blocks4bits); //4 битные блоки заново пересобираем в 32 юита и применяем сдвиг
}

void substitution_table_by_4bits(uint8_t * blocks4b, uint8_t sbox_row) {
    uint8_t block4b_1, block4b_2; //получаем 2 блока, которые должны вернуться из этой функции
    for (uint8_t i = 0; i < 4; ++i) {
        // 10101100 & 0x0F = 00001100 //смещение на 4 позиция + маска; далее число передается в таблицу
        // [example get from table] 1100 -> 1001 //возврат числа из таблицы
        block4b_1 = Sbox[sbox_row][blocks4b[i] & 0x0F]; //1 число это раунд шифра, 2 - само битовое число

        // 10101100 >> 4 = 00001010  //аналогично как и ранее
        // [example get from table] 1010 -> 0111
        block4b_2 = Sbox[sbox_row][blocks4b[i] >> 4]; 

        // 00001001
        blocks4b[i] = block4b_2; 

        // (00001001 << 4) | 0111 = 
        // 1001000 | 0111 = 10010111 
        blocks4b[i] = (blocks4b[i] << 4) | block4b_1; //склеиваем блоки в 1 и возвращаем массив из 4 блоков
    }
}

void split_256bits_to_32bits(uint8_t * key256b, uint32_t * keys32b) {//функция разбиения ключа на блоки (key32 пока не определен)
    uint8_t *p8 = key256b;
    // p32[0] = 00000000000000000000000000000000
    for (uint32_t *p32 = keys32b; p32 < keys32b + 8; ++p32) {
        // 00000000000000000000000000000000 << 8 | 10010010 = 00000000000000000000000010010010 (сначала добавляем 1 байт из оновного ключа)
        // 00000000000000000000000010010010 << 8 | 00011110 = 00000000000000001001001000011110 (побитовый сдвиг+ еще 1 байт) и т.д.
        // 00000000000000001001001000011110 << 8 | 11100011 = 00000000100100100001111011100011
        // 00000000100100100001111011100011 << 8 | 01010101 = 10010010000111101110001101010101  заполняется 32 битный ключ, повторяется 8 раз
        for (uint8_t i = 0; i < 4; ++i) {
            *p32 = (*p32 << 8) | *(p8 + i);
        }
        p8 += 4;
    }
}

void split_64bits_to_32bits(uint64_t block64b, uint32_t * block32b_1, uint32_t * block32b_2) { //функция разбиения на 2 блока по 32 бита
    // N1 = (uint32_t)0000101010101010101010101010101010101010101010101010101010101111 =
    // = 10101010101010101010101010101111
    *block32b_2 = (uint32_t)(block64b);//как бы "отрезаем число"

    // N2 = (uint32_t)0000101010101010101010101010101010101010101010101010101010101111 >> 32 = 
    // = (uint32_t)000000000000000000000000000010101010101010101010101010101111 = 
    // = 10101010101010101010101010101111
    *block32b_1 = (uint32_t)(block64b >> 32); //для получения 2 части сдвигаем на 32 бита начальное число (не циклический сдвиг)
}

void split_64bits_to_8bits(uint64_t block64b, uint8_t * blocks8b) {
    for (size_t i = 0; i < 8; ++i) {
        // blocks8b[0] = 
        // = (uint8_t)0000101010101010101010101010101010101010101010101010101010101111 >> ((7 - 0) * 8)
        // = (uint8_t)0000101010101010101010101010101010101010101010101010101010101111 >> 56 =
        // = (uint8_t)0000000000000000000000000000000000000000000000000000000000001010 =
        // = 00001010
        blocks8b[i] = (uint8_t)(block64b >> ((7 - i) * 8));
    }
}

void split_32bits_to_8bits(uint32_t block32b, uint8_t * blocks8b) {
    for (uint8_t i = 0; i < 4; ++i) {
        // blocks8b[0] = (uint8_t)10111101000101010100101110100010 >> (28 - (0 * 8)) =
        // = (uint8_t)10101010101010101010101010101010 >> 28 = 
        // = (uint8_t)00000000000000000000000010111101
        // = 10111101
        blocks8b[i] = (uint8_t)(block32b >> (24 - (i * 8)));
    }
}

/*
// WRONG FUNCTION!
void split_32bits_to_4bits(uint32_t block32b, uint8_t * blocks4b) {   
    for (uint8_t i = 0; i < 4; ++i) { //заполняем первый элемент массива, в котором храниться 2 блока по 4 бита
        // blocks4b[0] = (uint8_t)10101010101010101010101010101010 >> (28 - (0 * 8)) =  //заносим 32 битный блок в биты (смещение на 28 бит)
        // = (uint8_t)10101010101010101010101010101010 >> 28 = 
        // = (uint8_t)00000000000000000000000010101010
        // = 10101010   //присваиваем полученное число к blocks4b
        blocks4b[i] = (uint8_t)(block32b >> (28 - (i * 8)));  //смещаем на 4 позиции влево
        // blocks4b[0] = (10101010 << 4) | (uint8_t)(10101010101010101010101010101010 & 0x0F) = //используем маску по первым 4 битам
        // = (10101010 << 4) | (uint8_t)(10101010101010101010101010101010 & 00001111) = 
        // = 10100000 | (uint8_t)00000000000000000000000000001010  //здесь получем 2 числа
        // = 10100000 | 00001010 = 10101010 //убираем лишние нули и склеиваем (получаем 2 блока по 4 бит)
        blocks4b[i] = (blocks4b[i] << 4) | (uint8_t)(block32b & 0x0F); 
    }
}
*/

uint64_t join_32bits_to_64bits(uint32_t block32b_1, uint32_t block32b_2) {
    uint64_t block64b;
    // block64b = 10101010101010101010101010101010 = 
    // 0000000000000000000000000000000010101010101010101010101010101010
    block64b = block32b_2;
    // block64b = 
    // = (0000000000000000000000000000000010101010101010101010101010101010 << 32) | 11111111111111111111111111111111 = 
    // = 1010101010101010101010101010101000000000000000000000000000000000 | 11111111111111111111111111111111 = 
    // = 101010101010101010101010101010111111111111111111111111111111111
    block64b = (block64b << 32) | block32b_1;
    return block64b;
}

uint64_t join_8bits_to_64bits(uint8_t * blocks8b) {//функция превращения числа из 8 байт в 64
    uint64_t block64b; //создается новое 64-битное число
    // block64b = 0000000000000000000000000000000000000000000000000000000000000000
    for (uint8_t *p = blocks8b; p < blocks8b + 8; ++p) {
        // i = 0
        // (0000000000000000000000000000000000000000000000000000000000000000 << 8) | 11001100 =    (конкатенируем(склеиваем) каждый байт)
        // 0000000000000000000000000000000000000000000000000000000011001100
        // i = 1
        // (0000000000000000000000000000000000000000000000000000000011001100 << 8) | 11110011 =     (то же самое + сдвиг)
        // 0000000000000000000000000000000000000000000000001100110000000000 | 11110011 = 
        // 0000000000000000000000000000000000000000000000001100110011110011
        // ... i < 8 ...
        block64b = (block64b << 8) | *p;
    }
    return block64b;
}

uint32_t join_4bits_to_32bits(uint8_t * blocks4b) {
    uint32_t block32b; //создается новый 32 битный блок
    // block64b = 00000000000000000000000000000000
    for (uint8_t i = 0; i < 4; ++i) {
        // i = 0
        // (00000000000000000000000000000000 << 8) | 11001100 = 
        // 00000000000000000000000011001100
        // i = 1
        // (00000000000000000000000011001100 << 8) | 11110011 = 
        // 00000000000000001100110000000000 | 11110011 = 
        // 00000000000000001100110011110011
        // ... i < 4 ...
        block32b = (block32b << 8) | blocks4b[i]; //склеивание + смещение на 8 бит + снова склеивание
    }
    return block32b;
}

static inline void print_array(uint8_t * array, size_t length) {
    printf("[ ");
    for (size_t i = 0; i < length; ++i)
        printf("%d ", array[i]);
    printf("]\n");
}

static inline void print_bits(uint64_t x, register uint64_t Nbit) {
    for (Nbit = (uint64_t)1 << (Nbit - 1); Nbit > 0x00; Nbit >>= 1)
        printf("%d", (x & Nbit) ? 1 : 0);
    putchar('\n');
}

