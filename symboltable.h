typedef struct gSymbolTable{
	char *name;
	int dataType;
	int size;
	int binding;
	tNode *fbinding;
	struct gSymbolTable *next;
} gTable;

gTable *gInstall(char *name, int dataType, int size);

gTable *gSearch(char *name);
