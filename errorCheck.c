#include "y.tab.h"
extern int lineNo;

int checkArrayDeclaration(tnode *node){
    if (node->gEntry->size == 0){
        if (node->expr != NULL){
            printf("Line: %d :: Array has not been declared\n", lineNo);
            exit(0);
        }
    }
    else{
        if (node->expr == NULL){
            printf("Line: %d :: Array has been declared but a variable has been used\n", lineNo);
            exit(0);
        }
        else{
            if (node->expr->dataType != integer){
                printf("Line: %d :: Cannot be boolean index inside an array\n", lineNo);
                exit(0);
            }
        }
    }
}

int idDeclarationCheck(tnode *r){
    if (r->nodeType == ID){
		if (r->gEntry == NULL){
			printf("Line: %d :: Variable %s not declared\n", lineNo, r->name);
			exit(1);
		}
        else
            checkArrayDeclaration(r);
	}
    return 0;
}

int dataTypeCheck(tnode *l, tnode *r, int type){
    if (type == 0){ //This is meant for Assignment operation
        if (l->dataType != r->dataType){
            printf("Line: %d :: Invalid data type declarations\n", lineNo);
            exit(1);
        }
        if (l->nodeType != ID){
            printf("Line: %d :: Left side of ASSG has to be a variable.\n", lineNo);
    		exit(1);
        }
    }
    else{
        if (l != NULL){
            if (l->dataType != type){
        		printf("Line: %d :: Invalid data type declarations\n", lineNo);
        		exit(1);
        	}
        }
        if (r != NULL){
            if (r->dataType != type){
        		printf("Line: %d :: Invalid data type declarations\n", lineNo);
        		exit(1);
        	}
        }
    }
    return 0;
}
