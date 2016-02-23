gTable *gStart = NULL;
extern int lineNo;

void provideMemorySpace(){
  int memOffset = 0;
	gTable *temp;
	temp = gStart;
	while(temp != NULL){
		temp->binding = memOffset;
        if (temp->size == 0)
            memOffset += 1;
		memOffset += temp->size;
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

void groupGInstall(tnode *node, int type){
  tnode *temp;
  temp = node;
  while (temp != NULL){
    gInstall(temp->name, type, temp->val);
    temp = temp->left;
  }
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
