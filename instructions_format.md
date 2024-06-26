# Instruções a serem implementadas pela equipe:

## Instruções da ULA

- ADD (apenas entre registradores)
- SUB (apenas entre registradores)
- XOR
- AND

## Carga de constantes

- LD

## Transferência de valores entres registradores

- MOV

## Salto incondicional

- JMP

## NOP

- NOP

## Memory Access.

- LW -> load.
- SW -> store.

## Exemplos

- ADD R1 ---- A <- A+R1
- LD A, 10 ---- A <- 10
- MOV A, R5 ---- A <- R5
- MOV R4, A ---- R4 <- A
- SUB R4 ---- A <- A-R4

### obs

#### Descrição dos opcodes implementados na ROM.

MOV : 1100_dddd_ssss_xxxx
ADD : 0100_xxxx_ssss_xxxx
SUB : 0101_xxxx_ssss_cccc
NOP : 0000
LD  : 0011_dddd_cccccccc
JMP : 1111_xxxxx_aaaaaaa
CMP : 0001_xxxx_ssss_xxxx
JL  : 0111_xxxx_llllllll
JE  : 1110_xxxx_llllllll
LW: : 0110_xxddd_aaaaaaa -- Load, dado lido da ram carregado no acumulador.
SW: : 0010_xxddd_aaaaaaa -- Store, dado do acumulador jogado na ram.

---

Definição dos 8 registradores:
0000 -> r0
0001 -> r1
0010 -> r2
0011 -> r3
0100 -> r4
0101 -> r5
0110 -> r6
0111 -> r7
1000 -> acumulador

---

onde:

dddd -> registrador destino
ssss -> registrador fonte.
xxxx -> irrelevante.
cccc -> constante de 4 bits.
cccccccc -> constante de 8 bits.
aaaaaaa -> constante de 7 bits (endereço destino).
llllllll -> constante de 8 bits (endereço destino) - salto relativo.

---
