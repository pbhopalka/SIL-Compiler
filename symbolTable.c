gTable *gStart = NULL;

void provideMemorySpace(){
  int memOffset = 0;
	gTable *temp;
	temp = gStart;
	while(temp != NULL){
		temp->binding = memOffset;
		memOffset += temp->size;
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
			printf("Variable %s already declared\n", name);
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
