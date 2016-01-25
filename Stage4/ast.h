typedef struct tnode{
	int nodeType;
  int val;
	char *name;
  struct tnode *expr;
	struct tnode *left, *right;
}tnode;

struct tnode *makeLeaf(int n);

struct tnode *makeOperatorNode (int op, struct tnode *left, struct tnode *right);

struct tnode *makeID(char *id);

struct tnode *makeIONode(int op, struct tnode *arg);

void printBracket(struct tnode *t);

void evaluate(struct tnode *t);
