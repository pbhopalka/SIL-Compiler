#include "y.tab.h"
int regNo = 0;
FILE *filePtr;

int getRegNo(){
    if (regNo >= 7){
        printf("Registers out of bound\n");
        exit(0);
    }
    int reg= regNo;
    regNo++;
    return reg;
}

int freeReg(){
    if (regNo == 0){
        printf("Register has not yet been allocated\n");
    }
    regNo--;
}

int opCodeGen(tnode *t){
    printf("Entering for %d\n", t->nodeType);
    int r1, r2;
    //int r2 = getRegNo();
    //printf("Register no: %d %d\n", r1, r2);
    switch (t->nodeType) {
        case NUM:{
            int value = t->val;
            r1 = getRegNo();
            fprintf(filePtr, "MOV R%d, %d\n", r1, value);
            break;
        }
        case ID:{
            int address = t->gEntry->binding;
            r1 = getRegNo();
            fprintf(filePtr, "MOV R%d, [%d]\n", r1, address);
            break;
        }
        case PLUS:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "ADD R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case SUB:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "SUB R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case MUL:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "MUL R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case DIV:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "DIV R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case MOD:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "MOD R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case LT:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "LT R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case GT:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "GT R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case LE:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "LE R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case GE:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "GE R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case EQ:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "EQ R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case NE:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "NE R%d, R%d\n", r1, r2);
            freeReg();
            break;
        default:
            printf("Error in codegen\n");
            exit(0);
    }
    return r1;
}

int stCodeGen(tnode *t){
    int r1;
    switch (t->nodeType) {
        case ASSG:{
            int address = t->left->gEntry->binding;
            r1 = opCodeGen(t->right);
            fprintf(filePtr, "MOV [%d], R%d\n", address, r1);
            freeReg();
            break;
        }
        case READ:{
            int address = t->expr->gEntry->binding;
            r1 = getRegNo();
            fprintf(filePtr, "IN R%d\n", r1);
            fprintf(filePtr, "MOV [%d], R%d\n", address, r1);
            freeReg();
            break;
        }
        case WRITE:
            r1 = opCodeGen(t->expr);
            fprintf(filePtr, "OUT R%d\n", r1);
            freeReg();
            break;
    }
    return 0;
}

void codeGen(tnode *t){
    filePtr = fopen("simulator/asmCode.asm", "w+");
    fprintf(filePtr, "START\n");
    if (t->nodeType != STMT){
        printf("It is not a statement\n");
        exit(0);
    }
    while(t != NULL){
        stCodeGen(t->expr);
        t = t->left;
    }
    fprintf(filePtr, "HALT\n");
    fclose(filePtr);
    return;
}