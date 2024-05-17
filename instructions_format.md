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

## Exemplos

- ADD R1 ---- A <- A+R1
- LD A, 10 ---- A <- 10
- MOV A, R5 ---- A <- R5
- MOV R4, A ---- R4 <- A
- SUB R4 ---- A <- A-R4

### obs

- Implementar instrução CLR para o acumulador ou fazer apenas internamente para o comendo MOV?

#### Descrição dos opcodes implementados na ROM.

MOV : 1100_dddd_ssss_xxxx
ADD : 0100_xxxx_ssss_xxxx
SUB : 0101_xxxx_ssss_cccc
NOP : 0000
LI : 0011_dddd_xxxx_cccc
JMP : 1111_xxxxx_aaaaaaa

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
aaaaaaa -> constante de 7 bits (endereço destino).

---
