tNode *makeTree(int type, int nodeType, char *name, int val, tNode *arglist, tNode *p1, tNode *p2, tNode *p3){
	tNode *temp;
	temp = (tNode*)malloc(sizeof(tNode));
	switch(nodeType){
		case 0: //Operators and Relational operators
			temp = makeOperatorNode(name, p1, p2);
			break;
		case 1: //Integer value/NUM
			temp = makeNum(val);
			break;
		case 2: //Conditionals
			temp = makeConditionalNode(name, p1, p2, p3);
			break;
		case 3: //Iteratives
			temp = makeIterativeNode(name, p1, p2);
			break;
		case 4: //For identifiers
			temp = makeIdNode(name);
			break;
	}
	return temp;
}

tNode *makeIdNode(char *id){
	tNode *temp;
	temp = (tNode*)malloc(sizeof(tNode));
	temp->type = 0;
	temp->nodeType = 1;
	temp->name = (char*)malloc(sizeof(char*(strlen(id)+1)));
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

tNode *makeConditionalNode(char *c, tNode *p1, tNode *p2, tNode *p3){
	tNode *temp;
	temp = (tNode*)malloc(sizeof(tNode));
	temp->type = -1;
	temp->nodeType = 2;
	temp->name = (char*)malloc(sizeof(char*(strlen(c)+1))); /*Doubt in this area. Will it work properly. I want PLUS to be here*/
	strcpy(temp->name, c);
	temp->val = -1;
	temp->arglist = NULL;
	temp->ptr1 = p1;
	temp->ptr2 = p2;
	temp->ptr3 = p3;
	return temp;
}

tNode *makeIterativeNode(char *c, struct tNode *l, struct tNode *r){
	tNode *temp;
	temp = (tNode*)malloc(sizeof(tNode));
	temp->type = -1;
	temp->nodeType = 3;
	temp->name = (char*)malloc(sizeof(char*(strlen(c)+1))); /*Doubt in this area. Will it work properly. I want PLUS to be here*/
	strcpy(temp->name, c);
	temp->val = -1;
	temp->arglist = NULL;
	temp->ptr1 = l;
	temp->ptr2 = r;
	temp->ptr3 = NULL;
	return temp;
}
