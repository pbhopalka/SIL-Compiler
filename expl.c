tNode *makeIdNode(char *id){
	tNode *temp;
	temp = (tNode*)malloc(sizeof(tNode));
	temp->dataType = typeInt;
	temp->nodeType = nodeID;
	temp->name = (char*)malloc(sizeof(char) * (strlen(id)+1));
	strcpy(temp->name, id);
	temp->val = -1;
	temp->arglist = NULL;
	temp->ptr1 = NULL;
	temp->ptr2 = NULL;
	temp->ptr3 = NULL;
	return temp;
}

tNode *makeNum(int n){
	struct tNode *temp;
	temp = (struct tNode*)malloc(sizeof(struct tNode));
	temp->dataType = typeInt;
	temp->nodeType = nodeLEAF;
	temp->name = NULL;
	temp->val = n;
	temp->arglist = NULL;
	temp->ptr1 = NULL;
	temp->ptr2 = NULL;
	temp->ptr3 = NULL;
	return temp;
}

tNode *makeOperatorNode(int op, struct tNode *l, struct tNode *r){
	tNode *temp;
	temp = (tNode*)malloc(sizeof(tNode));
	temp->dataType = typeInt;
	temp->nodeType = op;
	temp->name = NULL;
	temp->val = -1;
	temp->arglist = NULL;
	temp->ptr1 = l;
	temp->ptr2 = r;
	temp->ptr3 = NULL;
	return temp;
}

tNode *makeRelOpNode(int op, tNode *l, tNode *r){
	tNode *temp;
	temp = (tNode*)malloc(sizeof(tNode));
	temp->dataType = typeBool;
	temp->nodeType = op;
	temp->name = NULL;
	temp->val = -1;
	temp->arglist = NULL;
	temp->ptr1 = l;
	temp->ptr2 = r;
	temp->ptr3 = NULL;
	return temp;
}

tNode *makeConditionalNode(int op, tNode *p1, tNode *p2, tNode *p3){
	tNode *temp;
	temp = (tNode*)malloc(sizeof(tNode));
	temp->dataType = NOTHING;
	temp->nodeType = nodeIF;
	temp->name = NULL;
	temp->val = op;
	temp->arglist = NULL;
	temp->ptr1 = p1;
	temp->ptr2 = p2;
	temp->ptr3 = p3;
	return temp;
}

tNode *makeIterativeNode(int op, struct tNode *l, struct tNode *r){
	tNode *temp;
	temp = (tNode*)malloc(sizeof(tNode));
	temp->dataType = NOTHING;
	temp->nodeType = op;
	temp->name = NULL;
	temp->val = NOTHING;
	temp->arglist = NULL;
	temp->ptr1 = l;
	temp->ptr2 = r;
	temp->ptr3 = NULL;
	return temp;
}

tNode *makeAssgNode(int op, tNode *l, tNode *r){
	tNode *temp;
	temp = (tNode*)malloc(sizeof(tNode));
	temp->dataType = NOTHING;
	temp->nodeType = op;
	temp->name = NULL;
	temp->val = NOTHING;
	temp->arglist = NULL;
	temp->ptr1 = l;
	temp->ptr2 = r;
	temp->ptr3 = NULL;
	return temp;
}

tNode *makeIONode(int op, tNode *ptr){
	tNode *temp;
	temp = (tNode*)malloc(sizeof(tNode));
	temp->dataType = NOTHING;
	temp->nodeType = op;
	temp->name = NULL;
	temp->val = NOTHING;
	temp->arglist = NULL;
	temp->ptr1 = ptr;
	temp->ptr2 = NULL;
	temp->ptr3 = NULL;
	return temp;
}

Statement *makeSyntaxTree(tNode *ptr, Statement *next){
	Statement *temp;
	temp = (Statement*)malloc(sizeof(Statement));
	temp->stmt = ptr;
	temp->next = next;
	return temp;
}

void evaluate(Statement *ptr){
	while(ptr != NULL){
		tNode *temp;
		temp = ptr->stmt;
		switch(temp->nodeType){
			case PLUS:
				if (temp->ptr1->dataType == typeInt || temp->ptr2->dataType == typeInt){
					int sum = temp->ptr1->val + temp->ptr2->val;
					temp->val = sum;
				}
				else
					printf("Not of type Integer\n");
				break;
			case IF:
				if (temp->ptr1->val == TRUE){
					evaluate(temp->ptr2);
				}
				else
					evaluate(temp->ptr3);
				break;
			case WHILE:
				while(temp->ptr1->val == TRUE)
					evaluate(temp->ptr2);
					evaluate(temp->ptr1);
				break;
			case LE:
				if (temp->ptr1->val <= temp->ptr2->val)
					temp->val = TRUE;
				else
					temp->val = FALSE;
				break;
			case READ:
				char c;
				c = *(temp->ptr1->name);
				scanf("%d", var[c - 'a']);
				break;
			case WRITE:
				evaluate(temp->ptr1);
				printf("%d\n", temp->ptr1->val);
				break;
			case ASSG:

			default:
				printf("Unrecognized command\n");
				break;
		}
		ptr = ptr->next;
	}
}
