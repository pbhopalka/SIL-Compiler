#include "y.tab.h"
int memory[100000];						//Used for memory allocation of variables

struct tnode *makeStatement(struct tnode *node, struct tnode *next){
	tnode *temp;
	temp = (tnode*)malloc(sizeof(tnode));
	temp->nodeType = STMT;
	temp->dataType = VOID;
	temp->expr = node;
	temp->left = next;
	return temp;
}

struct tnode *makeLeaf(int n, int type){
	struct tnode *temp;
	temp = (struct tnode*)malloc(sizeof(struct tnode));
	temp->name = NULL;
	temp->dataType = type;
	if (type == integer)
		temp->val = n;
	else
		temp->boolVal = n;
	temp->nodeType = NUM;
	temp->left = NULL;
	temp->right = NULL;
	return temp;
}

struct tnode *makeOperatorNode(int op, struct tnode *l, struct tnode *r){
	if (l->nodeType == ID){
		if (l->gEntry == NULL){
			printf("Variable %s not declared\n", l->gEntry->name);
			exit(1);
		}
	}
	if (r->nodeType == ID){
		if (r->gEntry == NULL){
			printf("Variable %s not declared\n", r->gEntry->name);
			exit(1);
		}
	}
	if (l->dataType != integer || r->dataType != integer){
		printf("Invalid data type declarations\n");
		exit(1);
	}
	struct tnode *temp;
	temp = (struct tnode*)malloc(sizeof(struct tnode));
	if (op == GT | op == LT | op == LE | op == GE | op == EQ | op == NE)
		temp->dataType = boolean;
	else
		temp->dataType = integer;
	temp->name = NULL;
	temp->nodeType = op;
	temp->left = l;
	temp->right = r;
	return temp;
}

struct tnode *makeID(char *id){
	struct tnode *temp;
	temp = (struct tnode*)malloc(sizeof(struct tnode));
	temp->name = (char*)malloc(sizeof(char));
	strcpy(temp->name, id);
	temp->nodeType = ID;
	temp->expr = NULL;
	temp->left = NULL;
	temp->right = NULL;
	temp->gEntry = gSearch(id);
	if (temp->gEntry != NULL){
		temp->dataType = temp->gEntry->type;
	}
	return temp;
}

struct tnode *makeAssgNode(struct tnode *l, struct tnode *r){
	idDeclarationCheck(l);
	idDeclarationCheck(r);
	if (l->nodeType != ID){
		printf("Left side of ASSG has to be a variable.\n");
		exit(1);
	}
	if (l->dataType != r->dataType){
		printf("Both sides of ASSG is not of same data type\n");
		exit(1);
	}
	struct tnode *temp;
	temp = (struct tnode*)malloc(sizeof(struct tnode));
	temp->dataType = VOID;
	temp->nodeType = ASSG;
	temp->name = NULL;
	temp->left = l;
	temp->right = r;
	return temp;
}

struct tnode *makeBooleanNode(int op, struct tnode *l, struct tnode *r){
	if (l->nodeType == ID){
		if (l->gEntry == NULL){
			printf("Boolean Variable not declared\n");
			exit(1);
		}
	}
	if (op != NOT){
		if (r->nodeType == ID){
			if (r->gEntry == NULL){
				printf("Boolean Variable not declared\n");
				exit(1);
			}
		}
		if (l->dataType != boolean || r->dataType != boolean){
			printf("Invalid boolean data type declarations\n");
			exit(1);
		}
	}
	if (l->dataType != boolean){
		printf("Invalid boolean data type declarations\n");
		exit(1);
	}
	struct tnode *temp;
	temp = (struct tnode*)malloc(sizeof(struct tnode));
	temp->dataType = boolean;
	temp->nodeType = op;
	temp->left = l;
	temp->right = r;
	return temp;
}

struct tnode *makeIONode(int op, struct tnode *node){ //Using t->expr not t->left or t->right
	idDeclarationCheck(node);
	if (node->dataType != integer){
		printf("Data type for I/O is not integer\n");
		exit(1);
	}
	tnode *temp;
	temp = (struct tnode*)malloc(sizeof(tnode));
	temp->nodeType = op;
	temp->expr = node;
	temp->left = NULL;
	temp->right = NULL;
	return temp;
}

struct tnode *makeConditionalNode(tnode *expr, tnode *thenPart, tnode *elsePart){
	if (expr->dataType != boolean){
		printf("Expression is not of boolean type in IF\n");
		exit(1);
	}
	tnode *temp;
	temp = (tnode*)malloc(sizeof(tnode));
	temp->nodeType = IF;
	temp->expr = expr;
	temp->left = thenPart;
	temp->right = elsePart;
	return temp;
}

struct tnode *makeIterativeNode(tnode *expr, tnode *slist){
	if (expr->dataType != boolean){
		printf("Expression is not of boolean type in WHILE\n");
		exit(1);
	}
	tnode *temp;
	temp = (tnode*)malloc(sizeof(tnode));
	temp->nodeType = WHILE;
	temp->expr = expr;
	temp->left = slist;
	temp->right = NULL;
	return temp;
}

void evaluate(struct tnode *t){
	if (t->nodeType == NUM){ 														//For numbers
		return;
	}
	else if(t->nodeType == ID){ 												//For identifiers
		if (t->gEntry == NULL){
			printf("Variable %s is not declared\n", t->name);
			exit(1);
		}
		int offset = 0;
		if (t->expr != NULL){
			evaluate(t->expr);
			offset = t->expr->val;
		}
		if (t->dataType == boolean)
			t->boolVal = memory[t->gEntry->binding+offset];
		else
			t->val = memory[t->gEntry->binding+offset];
	}
	else if (t->nodeType == ASSG){ 											//For Assignments
		int offset = 0;
		evaluate(t->left);
		if (t->left->expr != NULL){ //Checking if ID is array or variable
			evaluate(t->left->expr);
			offset = t->left->expr->val;
		}
		evaluate(t->right);
		if (t->left->dataType == boolean)
			memory[t->left->gEntry->binding+offset] = t->right->boolVal;
		else
			memory[t->left->gEntry->binding+offset] = t->right->val;
	}
	else if (t->nodeType == READ){											//For Read Statement
		int offset = 0;
		if (t->expr->expr != NULL){
			evaluate(t->expr->expr);
			offset = t->expr->expr->val;
		}
		scanf("%d", &memory[t->expr->gEntry->binding + offset]);
	}
	else if (t->nodeType == WRITE){											//For Write Statement
		evaluate(t->expr);
		printf("%d\n", t->expr->val);
	}
	else if (t->nodeType == IF){												//For IF Statement
		evaluate(t->expr);
		if (t->expr->boolVal == TRUE){
			evaluate(t->left);
		}
		else{
			if (t->right != NULL)
				evaluate(t->right);
		}
	}
	else if (t->nodeType == WHILE){											//For While Statement
		evaluate(t->expr);
		while(t->expr->boolVal == TRUE){
			evaluate(t->left);
			evaluate(t->expr);
		}
	}
	else if (t->nodeType == STMT){											//For handling Statement List
		while (t != NULL){
			evaluate(t->expr);
			t = t->left;
		}
	}
	else{																								//For arithmetic and relational operators
		int k, p, q;
		switch (t->nodeType){
			case PLUS:
				evaluate(t->left);
        		evaluate(t->right);
        		t->val = t->left->val + t->right->val;
				break;
			case SUB:
		        evaluate(t->left);
		        evaluate(t->right);
		        t->val = t->left->val - t->right->val;
		        break;
			case MUL:
		        evaluate(t->left);
		        evaluate(t->right);
		        t->val = t->left->val * t->right->val;
		        break;
			case DIV:
		        evaluate(t->left);
		        evaluate(t->right);
		        t->val = t->left->val / t->right->val;
		        break;
			case LT:
		        evaluate(t->left);
		        evaluate(t->right);
		        k = t->left->val < t->right->val;
				if (k == 1)
					t->boolVal = TRUE;
				else
					t->boolVal = FALSE;
		        break;
			case GT:
		        evaluate(t->left);
		        evaluate(t->right);
		        k = t->left->val > t->right->val;
				if (k == 1)
					t->boolVal = TRUE;
				else
					t->boolVal = FALSE;
		        break;
			case LE:
				evaluate(t->left);
				evaluate(t->right);
				k = t->left->val <= t->right->val;
				if (k == 1)
					t->boolVal = TRUE;
				else
					t->boolVal = FALSE;
				break;
			case GE:
		        evaluate(t->left);
		        evaluate(t->right);
		        k = t->left->val >= t->right->val;
				if (k == 1)
					t->boolVal = TRUE;
				else
					t->boolVal = FALSE;
		        break;
			case EQ:
		        evaluate(t->left);
		        evaluate(t->right);
		        k = t->left->val == t->right->val;
				if (k == 1)
					t->boolVal = TRUE;
				else
					t->boolVal = FALSE;
		        break;
			case NE:
		        evaluate(t->left);
		        evaluate(t->right);
		        k = t->left->val != t->right->val;
				if (k == 1)
					t->boolVal = TRUE;
				else
					t->boolVal = FALSE;
		        break;
			case AND:
		        evaluate(t->left);
		        evaluate(t->right);
		        if (t->left->boolVal == TRUE)
					p = 1;
				else
					p = 0;
				if (t->right->boolVal == TRUE)
					q = 1;
				else
					q = 0;
				k = p && q;
				if (k == 1)
					t->boolVal = TRUE;
				else
					t->boolVal = FALSE;
		        break;
			case OR:
		        evaluate(t->left);
		        evaluate(t->right);
				if (t->left->boolVal == TRUE)
					p = 1;
				else
					p = 0;
				if (t->right->boolVal == TRUE)
					q = 1;
				else
					q = 0;
				k = p || q;
				if (k == 1)
					t->boolVal = TRUE;
				else
					t->boolVal = FALSE;
        		break;
			case NOT:
        		evaluate(t->left);
				if (t->left->boolVal == TRUE)
					p = 1;
				else
					p = 0;
				k = !p;
				if (k == 1)
					t->boolVal = TRUE;
				else
					t->boolVal = FALSE;
        		break;
			default:
				printf("Error in evaluation\n");
				exit(0);
		}
	}
	return;
}
