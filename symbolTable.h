typedef struct argList{
    char *name;
    int type;
    struct argList *next;
} argList;

/* For the Global Symbol Table for global declaraions */
typedef struct gTable{
  char *name;
  int type;
  int size;
  int binding;
  struct argList *arg;
  struct gTable *next;
  struct lTable *link;
} gTable;

/* For the Local Symbol Table for local declarations in functions */
typedef struct lTable{
    char *name;
    int type;
    int binding;
    struct lTable *next;
} lTable;

void provideMemorySpace(); //Providing binding location during runtime

void printSymbolTable(); //Function to print symbol table (For debugging purposes)

argList *makeArgList(tnode *node);

/* Functions for the Global Symbol Table */

void groupGInstall(tnode *node, int type);

gTable *gSearch(char *name);

void fInstall(char *name, int type, tnode *arguments);

void gInstall(char *name, int type, int size);

/*Functions for the Local Symbol Table */

lTable *groupLInstall(tnode *node, int type);

lTable *lSearch(lTable *table, char *name);

lTable *lInstall(lTable *table, char *name, int type);
