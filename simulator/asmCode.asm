START
MOV BP, 513
MOV SP, 517
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

//Code Gen for insert function
insert:
PUSH BP
MOV BP, SP
MOV R0, 1
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
//Get address for - new 259
MOV R0, BP
MOV R1, 1
ADD R0, R1
MOV R0, [R0]
//Opcode over for new
//Part of userdefined
//t->name - a
MOV R1, 0
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, -3
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
MOV R0, BP
MOV R1, -4
ADD R0, R1
MOV R0, [R0]
MOV R0, [R0]
MOV R1, -1
EQ R0, R1
JZ R0, L1
MOV R0, BP
MOV R1, -4
ADD R0, R1
MOV R0, [R0]
//Right side
MOV R1, BP
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
//Get address for - new 259
MOV R0, BP
MOV R1, 1
ADD R0, R1
MOV R0, [R0]
//Opcode over for new
//Part of userdefined
//t->name - next
MOV R1, 1
ADD R0, R1
//Right side
MOV R1, -1
MOV [R0], R1
JMP L2
L1:
//Get address for - new 259
MOV R0, BP
MOV R1, 1
ADD R0, R1
MOV R0, [R0]
//Opcode over for new
//Part of userdefined
//t->name - next
MOV R1, 1
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, -4
ADD R1, R2
MOV R1, [R1]
MOV R1, [R1]
MOV [R0], R1
MOV R0, BP
MOV R1, -4
ADD R0, R1
MOV R0, [R0]
//Right side
MOV R1, BP
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
L2:
//Printing for return
MOV R1, 0
MOV R0, BP
MOV R2, 2
SUB R0, R2
MOV [R0], R1
POP R0
POP R0
POP R0
POP BP
RET

//Code Gen for print function
print:
PUSH BP
MOV BP, SP
MOV R0, 1
PUSH R0
MOV R0, 2
PUSH R0
MOV R0, -3
PUSH R0
MOV R0, BP
MOV R1, 2
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, -3
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
MOV R0, BP
MOV R1, 2
ADD R0, R1
MOV R0, [R0]
MOV R1, -1
NE R0, R1
JZ R0, L3
//Code for WRITE
//Get address for - t 259
MOV R0, BP
MOV R1, 2
ADD R0, R1
MOV R0, [R0]
//Opcode over for t
//Part of userdefined
//t->name - a
MOV R1, 0
ADD R0, R1
MOV R0, [R0]
OUT R0
MOV R0, BP
MOV R1, 1
ADD R0, R1
//Right side
PUSH R0
//Pushing the arguments
//Get address for - t 259
MOV R1, BP
MOV R2, 2
ADD R1, R2
MOV R1, [R1]
//Opcode over for t
//Part of userdefined
//t->name - next
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
PUSH R1
//Pushing arguments done
PUSH R1
CALL print
POP R1
//Popping off arguments
POP R2
//Popping arguments done
POP R0
//Calling done
MOV [R0], R1
JMP L4
L3:
L4:
//Printing for return
MOV R1, 0
MOV R0, BP
MOV R2, 2
SUB R0, R2
MOV [R0], R1
POP R0
POP R0
POP R0
POP BP
RET

//Code Gen for Reverse function
Reverse:
PUSH BP
MOV BP, SP
MOV R0, 1
PUSH R0
MOV R0, 2
PUSH R0
MOV R0, 3
PUSH R0
MOV R0, -3
PUSH R0
MOV R0, BP
MOV R1, 3
ADD R0, R1
//Right side
MOV R1, -1
MOV [R0], R1
MOV R0, BP
MOV R1, 2
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, -3
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
L5:
MOV R0, BP
MOV R1, 2
ADD R0, R1
MOV R0, [R0]
MOV R1, -1
NE R0, R1
JZ R0, L6
MOV R0, BP
MOV R1, 1
ADD R0, R1
//Right side
//Get address for - temp2 259
MOV R1, BP
MOV R2, 2
ADD R1, R2
MOV R1, [R1]
//Opcode over for temp2
//Part of userdefined
//t->name - next
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
//Get address for - temp2 259
MOV R0, BP
MOV R1, 2
ADD R0, R1
MOV R0, [R0]
//Opcode over for temp2
//Part of userdefined
//t->name - next
MOV R1, 1
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, 3
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
MOV R0, BP
MOV R1, 3
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, 2
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
MOV R0, BP
MOV R1, 2
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
JMP L5
L6:
MOV R0, 513
//Right side
MOV R1, BP
MOV R2, 3
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
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
POP BP
RET

//Code Gen for copy function
copy:
PUSH BP
MOV BP, SP
MOV R0, 1
PUSH R0
MOV R0, 2
PUSH R0
MOV R0, -3
PUSH R0
MOV R0, BP
MOV R1, 2
ADD R0, R1
//Right side
//Alloc statement
MOV R1, [512]
MOV [512], [R1]

MOV [R0], R1
//Get address for - temp 259
MOV R0, BP
MOV R1, 2
ADD R0, R1
MOV R0, [R0]
//Opcode over for temp
//Part of userdefined
//t->name - a
MOV R1, 0
ADD R0, R1
//Right side
//Get address for - H 259
MOV R1, BP
MOV R2, -3
ADD R1, R2
MOV R1, [R1]
//Opcode over for H
//Part of userdefined
//t->name - a
MOV R2, 0
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
MOV R0, BP
MOV R1, 1
ADD R0, R1
//Right side
MOV R1, BP
MOV R2, 2
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
//Get address for - temp2 259
MOV R0, BP
MOV R1, 1
ADD R0, R1
MOV R0, [R0]
//Opcode over for temp2
//Part of userdefined
//t->name - next
MOV R1, 1
ADD R0, R1
//Right side
MOV R1, -1
MOV [R0], R1
MOV R0, BP
MOV R1, -3
ADD R0, R1
//Right side
//Get address for - H 259
MOV R1, BP
MOV R2, -3
ADD R1, R2
MOV R1, [R1]
//Opcode over for H
//Part of userdefined
//t->name - next
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
L7:
MOV R0, BP
MOV R1, -3
ADD R0, R1
MOV R0, [R0]
MOV R1, -1
NE R0, R1
JZ R0, L8
//Get address for - temp 259
MOV R0, BP
MOV R1, 2
ADD R0, R1
MOV R0, [R0]
//Opcode over for temp
//Part of userdefined
//t->name - next
MOV R1, 1
ADD R0, R1
//Right side
//Alloc statement
MOV R1, [512]
MOV [512], [R1]

MOV [R0], R1
//Get address for - temp 259
MOV R0, BP
MOV R1, 2
ADD R0, R1
MOV R0, [R0]
//Opcode over for temp
//Part of userdefined
//t->name - next
MOV R1, 1
ADD R0, R1
MOV R0, [R0]
//t->name - a
MOV R1, 0
ADD R0, R1
//Right side
//Get address for - H 259
MOV R1, BP
MOV R2, -3
ADD R1, R2
MOV R1, [R1]
//Opcode over for H
//Part of userdefined
//t->name - a
MOV R2, 0
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
MOV R0, BP
MOV R1, 2
ADD R0, R1
//Right side
//Get address for - temp 259
MOV R1, BP
MOV R2, 2
ADD R1, R2
MOV R1, [R1]
//Opcode over for temp
//Part of userdefined
//t->name - next
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
//Get address for - temp 259
MOV R0, BP
MOV R1, 2
ADD R0, R1
MOV R0, [R0]
//Opcode over for temp
//Part of userdefined
//t->name - next
MOV R1, 1
ADD R0, R1
//Right side
MOV R1, -1
MOV [R0], R1
MOV R0, BP
MOV R1, -3
ADD R0, R1
//Right side
//Get address for - H 259
MOV R1, BP
MOV R2, -3
ADD R1, R2
MOV R1, [R1]
//Opcode over for H
//Part of userdefined
//t->name - next
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
JMP L7
L8:
MOV R0, 513
//Right side
MOV R1, BP
MOV R2, 1
ADD R1, R2
MOV R1, [R1]
MOV [R0], R1
//Printing for return
MOV R1, 0
MOV R0, BP
MOV R2, 2
SUB R0, R2
MOV [R0], R1
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
MOV R0, 514
//Right side
MOV R1, -1
MOV [R0], R1
MOV R0, 513
//Right side
MOV R1, -1
MOV [R0], R1
MOV R0, BP
MOV R1, 3
ADD R0, R1
//Right side
MOV R1, 1
MOV [R0], R1
L9:
MOV R0, BP
MOV R1, 3
ADD R0, R1
MOV R0, [R0]
MOV R1, 1
EQ R0, R1
JZ R0, L10
MOV R0, 515
IN R1
MOV [R0], R1
MOV R0, 515
MOV R0, [R0]
MOV R1, 0
MOV R2, 1
SUB R1, R2
EQ R0, R1
JZ R0, L11
MOV R0, BP
MOV R1, 3
ADD R0, R1
//Right side
MOV R1, 0
MOV [R0], R1
JMP L12
L11:
L12:
MOV R0, 515
MOV R0, [R0]
MOV R1, 1
EQ R0, R1
JZ R0, L13
MOV R0, BP
MOV R1, 4
ADD R0, R1
IN R1
MOV [R0], R1
L15:
MOV R0, BP
MOV R1, 4
ADD R0, R1
MOV R0, [R0]
MOV R1, 0
MOV R2, 1
SUB R1, R2
NE R0, R1
JZ R0, L16
MOV R0, 516
//Right side
PUSH R0
//Pushing the arguments
//For args Head
MOV R1, 514
PUSH R1
MOV R1, BP
MOV R2, 4
ADD R1, R2
MOV R1, [R1]
PUSH R1
//Pushing arguments done
PUSH R1
CALL insert
POP R1
//Popping off arguments
POP R2
POP R2
//Popping arguments done
POP R0
//Calling done
MOV [R0], R1
MOV R0, BP
MOV R1, 4
ADD R0, R1
IN R1
MOV [R0], R1
JMP L15
L16:
//Code for WRITE
MOV R0, 1111
OUT R0
JMP L14
L13:
MOV R0, 515
MOV R0, [R0]
MOV R1, 2
EQ R0, R1
JZ R0, L17
//Code for WRITE
MOV R0, 11111
OUT R0
MOV R0, 516
//Right side
PUSH R0
//Pushing the arguments
MOV R1, 514
MOV R1, [R1]
PUSH R1
//Pushing arguments done
PUSH R1
CALL print
POP R1
//Popping off arguments
POP R2
//Popping arguments done
POP R0
//Calling done
MOV [R0], R1
//Code for WRITE
MOV R0, 11111
OUT R0
JMP L18
L17:
MOV R0, 515
MOV R0, [R0]
MOV R1, 3
EQ R0, R1
JZ R0, L19
MOV R0, 516
//Right side
PUSH R0
//Pushing the arguments
MOV R1, 514
MOV R1, [R1]
PUSH R1
//Pushing arguments done
PUSH R1
CALL copy
POP R1
//Popping off arguments
POP R2
//Popping arguments done
POP R0
//Calling done
MOV [R0], R1
//Code for WRITE
MOV R0, 1111
OUT R0
MOV R0, 516
//Right side
PUSH R0
//Pushing the arguments
MOV R1, 513
MOV R1, [R1]
PUSH R1
//Pushing arguments done
PUSH R1
CALL Reverse
POP R1
//Popping off arguments
POP R2
//Popping arguments done
POP R0
//Calling done
MOV [R0], R1
MOV R0, 516
//Right side
PUSH R0
//Pushing the arguments
MOV R1, 513
MOV R1, [R1]
PUSH R1
//Pushing arguments done
PUSH R1
CALL print
POP R1
//Popping off arguments
POP R2
//Popping arguments done
POP R0
//Calling done
MOV [R0], R1
//Code for WRITE
MOV R0, 111
OUT R0
JMP L20
L19:
MOV R0, 515
MOV R0, [R0]
MOV R1, 4
EQ R0, R1
JZ R0, L21
//Code for WRITE
MOV R0, 111
OUT R0
MOV R0, 516
//Right side
PUSH R0
//Pushing the arguments
MOV R1, 513
MOV R1, [R1]
PUSH R1
//Pushing arguments done
PUSH R1
CALL print
POP R1
//Popping off arguments
POP R2
//Popping arguments done
POP R0
//Calling done
MOV [R0], R1
//Code for WRITE
MOV R0, 111
OUT R0
JMP L22
L21:
MOV R0, BP
MOV R1, 3
ADD R0, R1
//Right side
MOV R1, 0
MOV [R0], R1
L22:
L20:
L18:
L14:
JMP L9
L10:
//Printing for return
MOV R1, 9
MOV R0, BP
MOV R2, 2
SUB R0, R2
MOV [R0], R1
POP R0
POP R0
POP R0
POP R0
POP BP
RET

