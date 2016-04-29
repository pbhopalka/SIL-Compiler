START
MOV BP, 513
MOV SP, 514
CALL initialize
CALL main
HALT

initialize:
MOV [512], 0
MOV [0], 16
MOV [16], 32
MOV [32], 48
MOV [48], 64
MOV [64], 80
MOV [80], 96
MOV [96], 112
MOV [112], 128
MOV [128], 144
MOV [144], 160
MOV [160], 176
MOV [176], 192
MOV [192], 208
MOV [208], 224
MOV [224], 240
MOV [240], 256
MOV [256], 272
MOV [272], 288
MOV [288], 304
MOV [304], 320
MOV [320], 336
MOV [336], 352
MOV [352], 368
MOV [368], 384
MOV [384], 400
MOV [400], 416
MOV [416], 432
MOV [432], 448
MOV [448], 464
MOV [464], 480
MOV [480], 496
MOV [496], 512
MOV [496], -1
RET

//Code Gen for add1 function
add1:
PUSH BP
MOV BP, SP
MOV R0, 1
PUSH R0
MOV R0, 2
PUSH R0
MOV R0, 3
PUSH R0
MOV R0, 4
PUSH R0
MOV R0, 5
PUSH R0
MOV R0, -3
PUSH R0
MOV R0, -4
PUSH R0
MOV R0, BP
MOV R1, 1
ADD R0, R1
//Right side
//Alloc statement
MOV R1, [512]
MOV [512], [R1]

MOV [R0], R1
MOV R0, BP
MOV R1, 5
ADD R0, R1
//Right side
//Get address for - number1 259
MOV R1, BP
MOV R2, -4
ADD R1, R2
MOV R1, [R1]
//Opcode over for number1
//Part of userdefined
//t->name - p
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV R1, [R1]
//Get address for - number2 259
MOV R2, BP
MOV R3, -3
ADD R2, R3
MOV R2, [R2]
//Opcode over for number2
//Part of userdefined
//t->name - p
MOV R3, 1
ADD R2, R3
MOV R2, [R2]
MOV R2, [R2]
MUL R1, R2
MOV [R0], R1
MOV R0, BP
MOV R1, 4
ADD R0, R1
//Right side
//Get address for - number1 259
MOV R1, BP
MOV R2, -4
ADD R1, R2
MOV R1, [R1]
//Opcode over for number1
//Part of userdefined
//t->name - p
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
//Get address for - number2 259
MOV R2, BP
MOV R3, -3
ADD R2, R3
MOV R2, [R2]
//Opcode over for number2
//Part of userdefined
//t->name - p
MOV R3, 1
ADD R2, R3
MOV R2, [R2]
MOV R3, 1
ADD R2, R3
MOV R2, [R2]
MUL R1, R2
MOV [R0], R1
MOV R0, BP
MOV R1, 3
ADD R0, R1
//Right side
//Get address for - number1 259
MOV R1, BP
MOV R2, -4
ADD R1, R2
MOV R1, [R1]
//Opcode over for number1
//Part of userdefined
//t->name - p
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV R1, [R1]
//Get address for - number2 259
MOV R2, BP
MOV R3, -3
ADD R2, R3
MOV R2, [R2]
//Opcode over for number2
//Part of userdefined
//t->name - p
MOV R3, 1
ADD R2, R3
MOV R2, [R2]
MOV R3, 1
ADD R2, R3
MOV R2, [R2]
MUL R1, R2
MOV [R0], R1
MOV R0, BP
MOV R1, 2
ADD R0, R1
//Right side
//Get address for - number1 259
MOV R1, BP
MOV R2, -4
ADD R1, R2
MOV R1, [R1]
//Opcode over for number1
//Part of userdefined
//t->name - p
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
//Get address for - number2 259
MOV R2, BP
MOV R3, -3
ADD R2, R3
MOV R2, [R2]
//Opcode over for number2
//Part of userdefined
//t->name - p
MOV R3, 1
ADD R2, R3
MOV R2, [R2]
MOV R2, [R2]
MUL R1, R2
MOV [R0], R1
MOV R0, BP
MOV R1, 5
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, 5
ADD R1, R2
MOV R1, [R1]
MOV R2, BP
MOV R3, 4
ADD R2, R3
MOV R2, [R2]
SUB R1, R2
MOV [R0], R1
MOV R0, BP
MOV R1, 4
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, 3
ADD R1, R2
MOV R1, [R1]
MOV R2, BP
MOV R3, 2
ADD R2, R3
MOV R2, [R2]
ADD R1, R2
MOV [R0], R1
//Get address for - r 259
MOV R0, BP
MOV R1, 1
ADD R0, R1
MOV R0, [R0]
//Opcode over for r
//Part of userdefined
//t->name - p
MOV R1, 1
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, 5
ADD R1, R2
MOV R1, [R1]
MOV R2, BP
MOV R3, 4
ADD R2, R3
MOV R2, [R2]
PUSH R1
MOV R1, SP
PUSH R2
MOV [R0], R1
//Printing for return
MOV R1, BP
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV R0, BP
MOV R2, 2
SUB R0, R2
MOV [R0], R1
POP R0
POP R0
POP R0
POP R0
POP R0
POP R0
POP R0
POP R0
POP R0
POP BP
RET

//Code Gen for main function
main:
PUSH BP
MOV BP, SP
MOV R0, 1
PUSH R0
MOV R0, 2
PUSH R0
MOV R0, 3
PUSH R0
MOV R0, 4
PUSH R0
MOV R0, 5
PUSH R0
MOV R0, 6
PUSH R0
MOV R0, BP
MOV R1, 3
ADD R0, R1
//Right side
//Alloc statement
MOV R1, [512]
MOV [512], [R1]

MOV [R0], R1
MOV R0, BP
MOV R1, 2
ADD R0, R1
//Right side
//Alloc statement
MOV R1, [512]
MOV [512], [R1]

MOV [R0], R1
MOV R0, BP
MOV R1, 5
ADD R0, R1
IN R1
MOV [R0], R1
MOV R0, BP
MOV R1, 4
ADD R0, R1
IN R1
MOV [R0], R1
//Get address for - a 259
MOV R0, BP
MOV R1, 3
ADD R0, R1
MOV R0, [R0]
//Opcode over for a
//Part of userdefined
//t->name - p
MOV R1, 1
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, 5
ADD R1, R2
MOV R1, [R1]
MOV R2, BP
MOV R3, 4
ADD R2, R3
MOV R2, [R2]
PUSH R1
MOV R1, SP
PUSH R2
MOV [R0], R1
MOV R0, BP
MOV R1, 5
ADD R0, R1
IN R1
MOV [R0], R1
MOV R0, BP
MOV R1, 4
ADD R0, R1
IN R1
MOV [R0], R1
//Get address for - b 259
MOV R0, BP
MOV R1, 2
ADD R0, R1
MOV R0, [R0]
//Opcode over for b
//Part of userdefined
//t->name - p
MOV R1, 1
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, 5
ADD R1, R2
MOV R1, [R1]
MOV R2, BP
MOV R3, 4
ADD R2, R3
MOV R2, [R2]
PUSH R1
MOV R1, SP
PUSH R2
MOV [R0], R1
MOV R0, BP
MOV R1, 1
ADD R0, R1
//Right side
PUSH R0
//Pushing the arguments
MOV R1, BP
MOV R2, 3
ADD R1, R2
MOV R1, [R1]
PUSH R1
MOV R1, BP
MOV R2, 2
ADD R1, R2
MOV R1, [R1]
PUSH R1
//Pushing arguments done
PUSH R1
CALL add1
POP R1
//Popping off arguments
POP R2
POP R2
//Popping arguments done
POP R0
//Calling done
MOV [R0], R1
//Code for WRITE
//Get address for - c 259
MOV R0, BP
MOV R1, 1
ADD R0, R1
MOV R0, [R0]
//Opcode over for c
//Part of userdefined
//t->name - p
MOV R1, 1
ADD R0, R1
MOV R0, [R0]
MOV R0, [R0]
OUT R0
//Code for WRITE
//Get address for - c 259
MOV R0, BP
MOV R1, 1
ADD R0, R1
MOV R0, [R0]
//Opcode over for c
//Part of userdefined
//t->name - p
MOV R1, 1
ADD R0, R1
MOV R0, [R0]
MOV R1, 1
ADD R0, R1
MOV R0, [R0]
OUT R0
//Printing for return
MOV R1, 1
MOV R0, BP
MOV R2, 2
SUB R0, R2
MOV [R0], R1
POP R0
POP R0
POP R0
POP R0
POP R0
POP R0
POP R0
POP R0
POP R0
POP R0
POP BP
RET

