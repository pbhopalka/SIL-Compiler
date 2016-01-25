gTable *gStart = NULL;

void gInstall(char *name, int type, int size, int *address){
  gTable *temp;
  temp = (gTable*)malloc(sizeof(gTable));
  temp->name = name;
  temp->type = type;
  temp->size = size;
  temp->binding = address;
  temp->next = gStart;
  gStart = temp;
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
