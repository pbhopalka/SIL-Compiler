#define STMT 0

typedef struct tnode{
	int nodeType;
  int val;
	char *name;
  struct tnode *expr;
	struct tnode *left, *right;
	struct gTable *gEntry;
}tnode;

struct tnode *makeStatement(struct tnode *node, struct tnode *next);

struct tnode *makeLeaf(int n);

struct tnode *makeOperatorNode (int op, struct tnode *left, struct tnode *right);

struct tnode *makeID(char *id);

struct tnode *makeIONode(int op, struct tnode *arg);

struct tnode *makeConditionalNode(tnode *expr, tnode *thenPart, tnode *elsePart);

struct tnode *makeIterativeNode(tnode *expr, tnode *slist);

void provideMemorySpace();

void printBracket(struct tnode *t);

void evaluate(struct tnode *t);
