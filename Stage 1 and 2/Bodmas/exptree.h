typedef struct tnode{
	int val;
	char *op;
	struct tnode *left, *right;
}tnode;

struct tnode *makeLeaf(int n);

struct tnode *makeOperatorNode (char c, struct tnode *left, struct tnode *right);

void printBracket(struct tnode *t);

int evaluate(struct tnode *t);
