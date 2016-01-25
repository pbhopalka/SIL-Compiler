#include "y.tab.h"
#include <string.h>

int var[26];

struct tnode *makeStatement(struct tnode *node, struct tnode *next){
	tnode *temp;
	temp = (tnode*)malloc(sizeof(tnode));
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

void evaluate(struct tnode *t){
	if (t->nodeType == NUM){
		return;
	}
  else if(t->nodeType == ID){
    char c = *(t->name);
    t->val = var[c - 'a'];
  }
  else if (t->nodeType == ASSG){
    evaluate(t->right);
    char c = *(t->left->name);
    var[c - 'a'] = t->right->val;
  }
  else if (t->nodeType == READ){
    char c = *(t->expr->name);
    scanf("%d", &var[c - 'a']);
  }
  else if (t->nodeType == WRITE){
    evaluate(t->expr);
    printf("%d\n", t->expr->val);
  }
	else{
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
		}
	}
}
