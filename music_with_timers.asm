b start

@include header.asm

start:

ldr r0,=0x04000084 ; SOUNDCNT_X
mov r1,%0000000010000000 ; turn on all sounds operation
str r1,[r0]

ldr r0,=0x04000080 ; SOUNDCNT_L
ldr r1,=%0010001001110111 ; enable sound 2 left output, enable sound 2 right output, set left output level to 7, set right output level to 7
str r1,[r0]

ldr r0,=0x04000068 ; SOUND2CNT_L
ldr r1,=%1111000010000000 ; set envelope (volume) initial value to 15 and set the the vaveform duty cycle to 50%
str r1,[r0]

ldr r0,=0x0400006C ; SOUND2CNT_H
ldr r1,=%1000011000001011 ; set the initialization flag to 1 and set the frequency data to 11000001011 ("middle C")
str r1,[r0]

ldr r4,=0x04000106 ; TM1CNT_H
mov r2,%0000000010000100 ; enable timer operation and enable count-up timing
strh r2,[r4]

ldr r5,=0x04000102 ; TM0CNT_H
mov r2,%0000000010000010 ; enable timer operation and set the prescalar to 256 system clock cycles (15.256 μs)
strh r2,[r5]

ldr r1,=0x04000104 ; TM1CNT_L
ldr r2,=1 ; wait for timer 0 to overflow 1 time (~1 seconds)
waitLoop1:
ldrh r3,[r1]
cmp r3,r2
bne waitLoop1

mov r3,%0000000000000000 ; reset to 0
strh r3,[r4]
strh r3,[r5]

ldr r3,=%1000011001110010 ; set the initialization flag to 1 and set the frequency data to 11001110010 (E)
str r3,[r0]

ldr r4,=0x04000106 ; TM1CNT_H
mov r3,%0000000010000100 ; enable timer operation and enable count-up timing
strh r3,[r4]

ldr r5,=0x04000102 ; TM0CNT_H
mov r3,%0000000010000010 ; enable timer operation and set the prescalar to 256 system clock cycles (15.256 μs)
strh r3,[r5]

waitLoop2: ; wait ~1 second
ldrh r3,[r1]
cmp r3,r2
bne waitLoop2

mov r3,%0000000000000000 ; reset to 0
strh r3,[r4]
strh r3,[r5]

ldr r3,=%1000011010110010 ; set the initialization flag to 1 and set the frequency data to 11010110010 (G)
str r3,[r0]

ldr r4,=0x04000106 ; TM1CNT_H
mov r3,%0000000010000100 ; enable timer operation and enable count-up timing
strh r3,[r4]

ldr r5,=0x04000102 ; TM0CNT_H
mov r3,%0000000010000010 ; enable timer operation and set the prescalar to 256 system clock cycles (15.256 μs)
strh r3,[r5]

waitLoop3: ; wait ~1 second
ldrh r3,[r1]
cmp r3,r2
bne waitLoop3

mov r3,%0000000000000000 ; reset to 0
strh r3,[r4]
strh r3,[r5]

ldr r3,=%1000011100000110 ; set the initialization flag to 1 and set the frequency data to 11100000110 (C)
str r3,[r0]

mainLoop:
b mainLoop
