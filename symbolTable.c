gTable *gStart = NULL;
extern int lineNo;

void provideMemorySpace(){
    int memOffset = 0;
	gTable *temp;
	temp = gStart;
	while(temp != NULL){
        if (temp->arg == NULL){
            temp->binding = memOffset;
            if (temp->size == 0)
                memOffset += 1;
    		memOffset += temp->size;
        }
		temp = temp->next;
	}
}

void printSymbolTable(){
    gTable *temp = gStart;
    printf("Symbol table\n");
    while (temp != NULL){
        printf("%s %d %d\n", temp->name, temp->type, temp->size);
        temp = temp->next;
    }
}

struct argList *makeArgList(tnode *node){
    argList *temp, *start;
    start = NULL;
    while(node != NULL){
        temp = (argList*)malloc(sizeof(argList));
        temp->name = node->name;
        temp->type = node->dataType;
        temp->next = start;
        start = temp;
        node = node->left;
    }
    return start;
}

void groupGInstall(tnode *node, int type){
  tnode *temp;
  temp = node;
  while (temp != NULL){
    if (temp->nodeType == FUNC){
        fInstall(temp->name, type, temp->expr);
    }
    else
        gInstall(temp->name, type, temp->val);
    temp = temp->left;
  }
}

void fInstall(char *name, int type, tnode *arguments){
    gTable *tempPointer = gSearch(name);
    if (tempPointer != NULL){
			printf("Line: %d :: Variable %s already declared\n", lineNo, name);
			exit(1);
	}
    gTable *temp;
    temp = (gTable*)malloc(sizeof(gTable));
    temp->name = name;
    temp->type = type;
    temp->arg = makeArgList(arguments);
    temp->next = gStart;
    gStart = temp;
}

void gInstall(char *name, int type, int size){
  //printf("Declaring Variable %s\n", name);
  gTable *tempPointer = gSearch(name);
	if (tempPointer != NULL){
			printf("Line: %d :: Variable %s already declared\n", lineNo, name);
			exit(1);
	}
  gTable *temp;
  temp = (gTable*)malloc(sizeof(gTable));
  temp->name = name;
  temp->type = type;
  temp->size = size;
  temp->arg = NULL;
  temp->next = gStart;
  gStart = temp;                //gStart is the start of the symbol table
}

gTable *gSearch(char *name){
  gTable *temp;
  temp = gStart;
  while(temp != NULL){
    if (strcmp(temp->name, name) == 0){
      return temp;
    }
    temp = temp->next;
  }
  return NULL;
}

lTable *groupLInstall(tnode *node, int type){
    lTable *temp = NULL;
    while (node != NULL){
        lTable *temp2 = lInstall(temp, node->name, type);
        temp2->next = temp;
        temp = temp2;
        node = node->left;
    }
    return temp;
}

lTable *lSearch(lTable *lSymbol, char *name){
    while(lSymbol != NULL){
        if (strcmp(lSymbol->name, name) == 0)
            return lSymbol;
        lSymbol = lSymbol->next;
    }
    return NULL;
}

lTable *lInstall(lTable *table, char *name, int type){
    lTable *tempPointer = lSearch(table, name);
  	if (tempPointer != NULL){
  			printf("Line: %d :: Variable %s already declared in local scope\n", lineNo, name);
  			exit(1);
  	}
    lTable *temp;
    temp = (lTable*)malloc(sizeof(lTable));
    temp->name = name;
    temp->type = type;
    return temp;
}
