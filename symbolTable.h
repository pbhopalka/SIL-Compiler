typedef struct gTable{
  char *name;
  int type;
  int size;
  int binding;
  struct gTable *next;
} gTable;

void groupGInstall(tnode *node, int type);

void provideMemorySpace();

void printSymbolTable();

gTable *gSearch(char *name);

void gInstall(char *name, int type, int size);
