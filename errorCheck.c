#include "y.tab.h"

int idDeclarationCheck(tnode *r){
    if (r->nodeType == ID){
		if (r->gEntry == NULL){
			printf("Variable %s not declared\n", r->name);
			exit(1);
		}
	}
    return 0;
}

int dataTypeCheck(tnode *l, tnode *r, int type){
    if (type == 0){
        if (l->dataType != r->dataType){
            printf("Invalid data type declarations\n");
            exit(1);
        }
    }
    else{
        if (l->dataType != type || r->dataType != type){
    		printf("Invalid data type declarations\n");
    		exit(1);
    	}
    }
    return 0;
}
