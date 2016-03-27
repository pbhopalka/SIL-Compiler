%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	extern FILE *yyin;
	extern int lineNo;

	#define YYSTYPE tnode *

	#include "ast.h"
	#include "symbolTable.h"
	#include "errorCheck.c"
	#include "ast.c"
	#include "symbolTable.c"
	#include "codegen.c"

	int yylex(void);
	int yyerror(char const *s);

%}

%token NUM ID BEGIN1 END
%token READ WRITE DECL ENDDECL
%token integer boolean RETURN
%token IF THEN ELSE ENDIF WHILE DO ENDWHILE BREAK
%token PLUS SUB MUL DIV MOD ASSG
%token LT GT LE GE EQ NE
%token AND OR NOT
%left PLUS SUB
%left MUL DIV
%left AND OR NOT
%nonassoc LT GT LE GE EQ NE

%%

prog: declaration funcDef	{printSymbolTable();exit(0);}
	;

declaration: DECL decllist ENDDECL 	{provideMemoryToGlobal();}
		;

decllist: decl decllist
		|
		;

decl: integer idlist ';'	{groupGInstall($2, integer);}
	| boolean idlist ';'	{groupGInstall($2, boolean);}
	;

idlist: id ',' idlist		{$1->left = $3;$$ = $1;}
	| id					{$1->left = NULL; $$ = $1;}
	;

id : ID						{$1->passByRef = FALSE;$1->val = 0;$1->nodeType = STMT;$$ = $1;}
	| ID '[' NUM ']'		{$1->val = $3->val;$1->nodeType = STMT;$$ = $1;}
	| ID '(' initArg ')'	{$1->expr = $3;$1->nodeType = FUNC;$$ = $1;} //This should not happen in function declaration
	;

initArg: argList	{$$ = $1;}
		|			{$$ = NULL;}
		;

funcDef: funcList funcDef	{$1->right = $2;$$ = $1;}
		| funcList			{$1->right = NULL;$$ = $1;}
		;

funcList: funcHead funcBody 	{printLocalSymTable($1->name);checkReturnType($1->dataType, $2->right->dataType);
								$1->left = $2;$$ = $1;lStart = NULL;}
		;

funcHead: integer ID '(' argument ')' '{'  {$$ = makeFunctionNode($2, integer, $4, NULL);}
		| boolean ID '(' argument ')' '{'  {$$ = makeFunctionNode($2, boolean, $4, NULL);}
		;

funcBody: localDecl body '}'	{$2->lEntry = lStart;$$ = $2;}
		;

argument: argList 	{argLInstall($1);$$ = $1;}
		|			{$$ = NULL;}
		;

argList: arg ';' argList	{$1->right = $3; $$ = $1;}
		| arg				{$1->right = NULL; $$ = $1;}
		;

arg: integer argInput	{$$ = addDataType(integer, $2);} /*checkArgumentType() is called by makeFunctionNode()*/
	| boolean argInput	{$$ = addDataType(boolean, $2);}
	;

argInput: argID ',' argInput	{$1->left = $3;$$ = $1;}
		| argID					{$1->left = NULL;$$ = $1;}
		;

argID: '&' ID	{$2->passByRef = TRUE;$2->val = 0;$2->nodeType = STMT;$$ = $2;}
	| ID		{$1->passByRef = FALSE;$1->val = 0;$1->nodeType = STMT;$$ = $1;}
	;

localDecl: DECL lDeclare ENDDECL
		|
		;

lDeclare: lDec lDeclare
		|
		;

lDec: integer idlist ';'	{checkArgumentType($2);groupLInstall($2, integer);}
	| boolean idlist ';'	{checkArgumentType($2);groupLInstall($2, boolean);}
	;

body: BEGIN1 Slist ret END 	{$2->right = $3; $$ = $2;}
	| BEGIN1 Slist END		{printf("Line : %d :: Return statement missing\n", lineNo);exit(0);}
	;

ret: RETURN expr ';' 	{$$ = $2;}

Slist: Stmt Slist       {$$ = makeStatement($1, $2);}
	 |					{$$ = NULL;}
     ;

Stmt: loc ASSG expr ';' 		{$$ = makeAssgNode($1, $3);}
    | READ '(' loc ')' ';'   	{$$ = makeIONode(READ, $3);}
    | WRITE '(' expr ')' ';' 	{$$ = makeIONode(WRITE, $3);}
	| IF '(' expr ')' THEN Slist ELSE Slist ENDIF ';'	{$$ = makeConditionalNode($3, $6, $8);}
	| IF '(' expr ')' THEN Slist ENDIF ';'				{$$ = makeConditionalNode($3, $6, NULL);}
	| WHILE '(' expr ')' DO Slist ENDWHILE ';' 			{$$ = makeIterativeNode($3, $6);}
    ;

expr: expr PLUS expr 					{$$ = makeOperatorNode(PLUS, $1, $3);}
	| expr SUB expr 					{$$ = makeOperatorNode(SUB, $1, $3);}
	| expr MUL expr 					{$$ = makeOperatorNode(MUL, $1, $3);}
	| expr DIV expr 					{$$ = makeOperatorNode(DIV, $1, $3);}
	| '(' expr ')' 						{$$ = $2;}
	| SUB expr     						{$$ = makeOperatorNode(SUB, makeLeaf(0, integer), $2);}
	| expr LT expr						{$$ = makeOperatorNode(LT, $1, $3);}
	| expr GT expr						{$$ = makeOperatorNode(GT, $1, $3);}
	| expr LE expr						{$$ = makeOperatorNode(LE, $1, $3);}
	| expr GE expr						{$$ = makeOperatorNode(GE, $1, $3);}
	| expr EQ expr						{$$ = makeOperatorNode(EQ, $1, $3);}
	| expr NE expr						{$$ = makeOperatorNode(NE, $1, $3);}
	| expr AND expr						{$$ = makeBooleanNode(AND, $1, $3);}
	| expr OR expr						{$$ = makeBooleanNode(OR, $1, $3);}
	| NOT expr							{$$ = makeBooleanNode(NOT, $2, NULL);}
	| NUM          						{$$ = $1;}
	| loc           					{$$ = $1;}
	;

loc: ID								{$1->expr = NULL;idDeclarationCheck($1);$$ = $1;}
	| ID '[' expr ']'				{$1->lEntry = NULL;$1->expr = $3;idDeclarationCheck($1);$$ = $1;}
	| ID '(' exprList ')'			{idDeclarationCheck($1);checkPassedArgument($1, $3);$$ = makeFunctionCall($1, $3);}
	;

exprList: expr ',' exprList			{$1->expr = $3; $$ = $1;}
		| expr						{$1->expr = NULL; $$ = $1;}
		|							{$$ = NULL;}
		;

%%

int yyerror(char const *s){
	printf("Line: %d :: Error: %s\n", lineNo, s);
	exit(0);
}

int main(int argc, char *argv[]){
	if (argc == 2)
		yyin = fopen(argv[1], "r");
	yyparse();
	return 0;
}
