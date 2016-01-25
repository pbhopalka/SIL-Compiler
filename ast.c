#include "y.tab.h"
#include <string.h>

int var[26];

struct tnode *makeStatement(struct tnode *node, struct tnode *next){
	tnode *temp;
	temp = (tnode*)malloc(sizeof(tnode));
	temp->nodeType = STMT;
	temp->expr = node;
	temp->left = next;
	return temp;
}

struct tnode *makeLeaf(int n){
	struct tnode *temp;
	temp = (struct tnode*)malloc(sizeof(struct tnode));
	temp->name = NULL;
	temp->val = n;
  temp->nodeType = NUM;
	temp->left = NULL;
	temp->right = NULL;
	return temp;
}

struct tnode *makeOperatorNode(int op, struct tnode *l, struct tnode *r){
	struct tnode *temp;
	temp = (struct tnode*)malloc(sizeof(struct tnode));
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
  temp->left = NULL;
  temp->right = NULL;
  return temp;
}

struct tnode *makeIONode(int op, struct tnode *node){ //Using t->expr not t->left or t->right
  tnode *temp;
  temp = (struct tnode*)malloc(sizeof(tnode));
  temp->nodeType = op;
  temp->expr = node;
  temp->left = NULL;
  temp->right = NULL;
  return temp;
}

struct tnode *makeConditionalNode(tnode *expr, tnode *thenPart, tnode *elsePart){
	tnode *temp;
	temp = (tnode*)malloc(sizeof(tnode));
	temp->nodeType = IF;
	temp->expr = expr;
	temp->left = thenPart;
	temp->right = elsePart;
	return temp;
}

struct tnode *makeIterativeNode(tnode *expr, tnode *slist){
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
    char c = *(t->name);
    t->val = var[c - 'a'];
  }
  else if (t->nodeType == ASSG){ 											//For Assignments
    evaluate(t->right);
    char c = *(t->left->name);
    var[c - 'a'] = t->right->val;
  }
  else if (t->nodeType == READ){											//For Read Statement
    char c = *(t->expr->name);
    scanf("%d", &var[c - 'a']);
  }
  else if (t->nodeType == WRITE){											//For Write Statement
    evaluate(t->expr);
    printf("%d\n", t->expr->val);
  }
	else if (t->nodeType == IF){												//For IF Statement
		evaluate(t->expr);
		if (t->expr->val == 1){
			evaluate(t->left);
		}
		else{
			if (t->right != NULL)
				evaluate(t->right);
		}
	}
	else if (t->nodeType == WHILE){											//For While Statement
		evaluate(t->expr);
		while(t->expr->val == 1){
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
        t->val = t->left->val * t->right->val;
        break;
			case LT:
        evaluate(t->left);
        evaluate(t->right);
        t->val = t->left->val < t->right->val;
        break;
			case GT:
        evaluate(t->left);
        evaluate(t->right);
        t->val = t->left->val > t->right->val;
        break;
			case LE:
				evaluate(t->left);
				evaluate(t->right);
				t->val = t->left->val <= t->right->val;
				break;
			case GE:
        evaluate(t->left);
        evaluate(t->right);
        t->val = t->left->val >= t->right->val;
        break;
			case EQ:
        evaluate(t->left);
        evaluate(t->right);
        t->val = t->left->val == t->right->val;
        break;
			case NE:
        evaluate(t->left);
        evaluate(t->right);
        t->val = t->left->val != t->right->val;
        break;
			default:
				printf("Error in evaluation\n");
				exit(0);
		}
	}
	return;
}
