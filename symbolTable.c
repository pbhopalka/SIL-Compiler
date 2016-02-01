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

void gInstall(char *name, int type, int size){
  //printf("Declaring Variable %s\n", name);
  gTable *tempPointer = gSearch(name);
	if (tempPointer != NULL){
			printf("Variable already declared\n");
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
