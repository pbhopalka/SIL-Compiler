struct tnode *makeLeaf(int n){
	struct tnode *temp;
	temp = (struct tnode*)malloc(sizeof(struct tnode));
	temp->op = NULL;
	temp->val = n;
	temp->left = NULL;
	temp->right = NULL;
	return temp;
}

struct tnode *makeOperatorNode(char c, struct tnode *l, struct tnode *r){
	struct tnode *temp;
	temp = (struct tnode*)malloc(sizeof(struct tnode));
	temp->op = (char*)malloc(sizeof(char));
	*(temp->op) = c;
	temp->left = l;
	temp->right = r;
	return temp;
}

void printBracket(struct tnode *t){
	if (t->left == NULL && t->right == NULL){
		printf("%d", t->val);
	}else {
		printf("(");
		printBracket(t->left);
		printf("%c", *(t->op));
		printBracket(t->right);
		printf(")");
	}
}

/*
int evaluate(struct tnode *t){
	if (t->op == NULL){
		return t->val;
	}
	else{
		switch (*(t->op)){
			case '+':
				return evaluate(t->left) + evaluate(t->right);
				break;
			case '-':
				return evaluate(t->left) - evaluate(t->right);
				break;
			case '*':
				return evaluate(t->left) * evaluate(t->right);
				break;
			case '/':
				return evaluate(t->left) / evaluate(t->right);
				break;
		}
	}
}*/

