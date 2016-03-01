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

int checkReturnType(int type1, int type2){
    if (type1 != type2){
        printf("Line: %d :: Return type mismatch\n", lineNo);
        exit(0);
    }
    return 0;
}

int checkArgumentType(tnode *node){
    int flag = 0;
    printf("Checking Args\n");
    tnode *temp1 = node;
    while (temp1 != NULL){
        printf("Node: %s\n", temp1->name);
        tnode *temp = temp1;
        while(temp != NULL){
            printf("temp: %s\n", node->name);
            if (temp->nodeType == STMT && temp->val == 0)
                flag = 0;
            else
                flag = 1;
            temp = temp->left;
        }
        temp1 = temp1->right;
    }
    if (flag == 1){
        printf("Line : %d :: Argument type mismatch.\n", lineNo);
        exit(0);
    }
    return 0;
}

int searchArgList(argList *arg, tnode *argument){
    argList *arglist = makeArgList(argument);
    while(arglist != NULL){
        if (strcmp(arglist->name, arg->name) != 0 || arg->type != arglist->type){
            printf("Line : %d :: Arguments in declaration do not match in the definitions\n", lineNo);
            exit(0);
        }
        arglist = arglist->next;
        arg = arg->next;
    }
    if (arg != NULL){
        printf("Line : %d :: Number of arguments in function declaration and definition do not match\n", lineNo);
        exit(0);
    }
    return 0;
}

int checkFunctionDecl(char *name, int type, tnode *argument){
    if (strcmp(name, "main") == 0){
        if (type != integer){
            printf("Line : %d :: Return type of main is integer\n", lineNo);
            exit(0);
        }
        if (argument != NULL){
            printf("Line : %d :: Main Function cannot have arguments\n", lineNo);
            exit(0);
        }
        return 0;
    }
    gTable *temp = gSearch(name);
    if (temp == NULL){
        printf("Line: %d :: Function %s has not been declared\n", lineNo, name);
        exit(0);
    }
    if (temp->type != type){
        printf("Line : %d :: Function Declaration and function definition types are different\n", lineNo);
        exit(0);
    }
    searchArgList(temp->arg, argument); //check if arguments have been declared properly
    return 0;
}
