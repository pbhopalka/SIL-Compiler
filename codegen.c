#include "y.tab.h"
#include "codegen.h"

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

int generateLabel(){
    label++;
    return label;
}

int opCodeGen(tnode *t){
    //printf("Entering for %d\n", t->nodeType);
    int r1, r2;
    //int r2 = getRegNo();
    //printf("Register no: %d %d\n", r1, r2);
    switch (t->nodeType) {
        case NUM:{
            int value;
            if (t->dataType == integer)
                value = t->val;
            else
                value = t->boolVal;
            r1 = getRegNo();
            fprintf(filePtr, "MOV R%d, %d\n", r1, value);
            break;
        }
        case ID:{
            int address;
            if (t->left->lEntry == NULL){
                address = t->left->gEntry->binding;
                r1 = getRegNo();
                fprintf(filePtr, "MOV R%d, %d\n", r1, address);
            }
            else{
                address = t->left->lEntry_>binding;
                r1 = getRegNo();
                fprintf(filePtr, "MOV R%d, BP\n", r1);
                fprintf(filePtr, "ADD R%d, %d\n", r1, address);
            }
            if (t->expr != NULL){
                int offset = opCodeGen(t->expr);
                fprintf(filePtr, "ADD R%d, R%d\n", r1, offset);
                freeReg();
            }
            fprintf(filePtr, "MOV R%d, [R%d]\n", r1, r1);
            break;
        }
        case CALL:{
            fprintf(filePtr, "CALL %s\n", t->name);
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
        case AND:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "MUL R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case OR:
            r1 = opCodeGen(t->left);
            r2 = opCodeGen(t->right);
            fprintf(filePtr, "ADD R%d, R%d\n", r1, r2);
            freeReg();
            break;
        case NOT:
            r1 = opCodeGen(t->left);
            fprintf(filePtr, "EQ R%d, 0\n", r1);
            break;
        default:
            printf("Error in codegen\n");
            exit(0);
    }
    return r1;
}

int stCodeGen(tnode *t){
    //printf("Entering for st: %d\n", t->nodeType);
    int r1;
    switch (t->nodeType) {
        case STMT:
            while(t != NULL){
                stCodeGen(t->expr);
                t = t->left;
            }
            break;
        case ASSG:{
            int address;
            if (t->left->lEntry == NULL){
                address = t->left->gEntry->binding;
                r1 = getRegNo();
                fprintf(filePtr, "MOV R%d, %d\n", r1, address);
            }
            else{
                address = t->left->lEntry_>binding;
                r1 = getRegNo();
                fprintf(filePtr, "MOV R%d, BP\n", r1);
                fprintf(filePtr, "ADD R%d, %d\n", r1, address);
            }
            if (t->left->expr != NULL){
                int offset = opCodeGen(t->left->expr);
                fprintf(filePtr, "ADD R%d, R%d\n", r1, offset);
                freeReg();
            }
            int r2 = opCodeGen(t->right);
            fprintf(filePtr, "MOV [R%d], R%d\n", r1, r2);
            freeReg();
            freeReg();
            break;
        }
        case READ:{
            int address;
            if (t->expr->lEntry == NULL){
                address = t->expr->gEntry->binding;
                r1 = getRegNo();
                fprintf(filePtr, "MOV R%d, %d\n", r1, address);    
            }
            else{
                address = t->left->lEntry_>binding;
                r1 = getRegNo();
                fprintf(filePtr, "MOV R%d, BP\n", r1);
                fprintf(filePtr, "ADD R%d, %d\n", r1, address);   
            }
            if (t->expr->expr != NULL){
                int offset = opCodeGen(t->expr->expr);
                fprintf(filePtr, "ADD R%d, R%d\n", r1, offset);
                freeReg();
            }
            int r2 = getRegNo();
            fprintf(filePtr, "IN R%d\n", r2);
            fprintf(filePtr, "MOV [R%d], R%d\n", r1, r2);
            freeReg();
            freeReg();
            break;
        }
        case WRITE:
            r1 = opCodeGen(t->expr);
            fprintf(filePtr, "OUT R%d\n", r1);
            freeReg();
            break;
        case IF:{
            int l1 = generateLabel();
            r1 = opCodeGen(t->expr);
            fprintf(filePtr, "JZ R%d, L%d\n", r1, l1);
            freeReg();
            int l2 = generateLabel();
            stCodeGen(t->left);
            fprintf(filePtr, "JMP L%d\n", l2);
            fprintf(filePtr, "L%d:\n", l1);
            if (t->right != NULL){
                stCodeGen(t->right);
            }
            fprintf(filePtr, "L%d:\n", l2);
            break;
        }
        case WHILE:{
            int l1 = generateLabel();
            int l2 = generateLabel();
            fprintf(filePtr, "L%d:\n", l1);
            r1 = opCodeGen(t->expr);
            fprintf(filePtr, "JZ R%d, L%d\n", r1, l2);
            freeReg();
            stCodeGen(t->left);
            fprintf(filePtr, "JMP L%d\n", l1);
            fprintf(filePtr, "L%d:\n", l2);
            break;
        }
    }
    return 0;
}

void returnCodeGen(tnode *node){
    int r1 = getRegNo();
    int r2 = opCodeGen(node);
    fprintf(filePtr, "MOV R%d, BP\n", r1);
    fprintf(filePtr, "SUB R%d, 2\n", r1);
    fprintf(filePtr, "MOV [R%d], R%d\n", r1, r2);
    freeReg();
    freeReg();
    return;
}

void funcCodeGen(tnode *node){
    lTable *table = node->left->link;
    while(node != NULL){
        provideMemoryToLocal(node->left->link);
        fprintf(filePtr, "//Code Gen for %s function\n", node->name);
        fprintf(filePtr, "%s:\n", node->name);
        fprintf(filePtr, "PUSH BP\n");
        fprintf(filePtr, "MOV BP, SP\n");
        int count;
        while(table != NULL){
            fprintf(filePtr, "PUSH %d\n", table->binding);
            count = table->binding;
            table = table->next;
        }
        tnode *temp = node->left;
        while (temp != NULL){
            stCodeGen(temp);
            temp = temp->left;
        }
        returnCodeGen(node->left->right);
        while(count > 0){
            fprintf(filePtr, "POP %d\n", count);
            count--;
        }
        fprintf(filePtr, "POP BP\n");
        fprintf(filePtr, "RET\n");
        fprintf(filePtr, "\n");
        node = node->right;
    }
    return;
}

void codeGen(tnode *t){
    filePtr = fopen("simulator/asmCode.asm", "w+");
    fprintf(filePtr, "START\n");
    fprintf(filePtr, "MOV BP, 0\n");
    fprintf(filePtr, "MOV SP, %d\n", memory);
    int i = 0;
    while (i < regNo){
        fprintf(filePtr, "PUSH R%d\n", i);
        i++;
    }
    fprintf(filePtr, "CALL main\n");
    while (i > 0){
        fprintf(filePtr, "POP R%d\n", i);
        i--;
    }
    fprintf(filePtr, "HALT\n");
    fprintf(filePtr, "\n");
    while (t != NULL){
        funcCodeGen(t);
        t = t->right;
    }
    fclose(filePtr);
    return;
}
