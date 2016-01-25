typedef struct gTable{
  char *name;
  int type;
  int size;
  int *binding;
  struct gTable *next;
} gTable;

gTable *gSearch(char *name);

void gInstall(char *name, int type, int size, int *address);
