/* Defining the type for tNode */

#define typeInt 0
#define typeBool 1
#define typeString 2
#define NOTHING -1

/* Definition for Node Type in tNode*/

#define nodeOP 0
#define nodeLEAF 1
#define nodeIF 2
#define nodeWHILE 3
#define nodeID 4

/* Definition for bool values */

#define TRUE 1
#define FALSE 0

typedef struct tNode{
	int dataType; //for saying int or bool
	int nodeType;
	char *name;
	int val;
	struct tNode *arglist; //for function arguments
	struct tNode *ptr1, *ptr2, *ptr3;
} tNode;

tNode *makeTree(int dataType, int nodeType, char *name, int val, tNode *arglist, tNode *p1, tNode *p2, tNode *p3);

tNode *makeConditionalNode(int op, tNode *p1, tNode *p2, tNode *p3);

tNode *makeIterativeNode(int op, tNode *p1, tNode *p2);

tNode *makeNum(int n);

tNode *makeIdNode(char *id);

tNode *makeOperatorNode(int op, tNode *l, tNode *r);

tNode *makeRelOpNode(int op, tNode *l, tNode *r);

tNode *makeAssgNode(int op, tNode *l, tNode *r);

tNode *makeIONode(int op, tNode *node);

typedef struct Statement{
	tNode *stmt;
	struct Statement *next;
} Statement;

Statement *makeSyntaxTree(tNode *node, Statement *next);

int evaluate(Statement *ptr);
