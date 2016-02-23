%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	extern FILE *yyin;
	//extern int lineNo = 1;

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
%token integer boolean
%token IF THEN ELSE ENDIF WHILE DO ENDWHILE BREAK
%token PLUS SUB MUL DIV MOD ASSG
%token LT GT LE GE EQ NE
%token AND OR NOT
%left PLUS SUB
%left MUL DIV
%left AND OR NOT
%nonassoc LT GT LE GE EQ NE

%%

prog: declaration body
	;

declaration: DECL decllist ENDDECL
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

id : ID						{$1->val = 0;$$ = $1;}
	| ID '[' NUM ']'		{$1->val = $3->val;$$ = $1;}
	;

body: BEGIN1 Slist END	{provideMemorySpace();codeGen($2);exit(0);}
	;

Slist: Stmt Slist       {$$ = makeStatement($1, $2);}
	 |					{$$ = NULL;}
     ;

Stmt: loc ASSG expr ';'      {$$ = makeAssgNode($1, $3);}
    | READ '(' loc ')' ';'   {$$ = makeIONode(READ, $3);}
    | WRITE '(' expr ')' ';' {$$ = makeIONode(WRITE, $3);}
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
	| loc           					{
											if ($1->gEntry != NULL){
												if ($1->gEntry->size == 0){
													printf("%s\n", $1->name);
													if ($1->expr != NULL){
														printf("Array has not been declared\n");
														exit(0);
													}
												}
												else{
													printf("Else part: %s\n", $1->name);
													if ($1->expr == NULL){
														printf("Array has been declared but a variable used\n");
														exit(0);
													}
												}
											}
											$$ = $1;}
	;

loc: ID								{$1->expr = NULL;$$ = $1;}
	| ID '[' expr ']'				{
										if ($3->dataType != integer){
											printf("Cannot be boolean index inside an array\n");
											exit(0);
										}
										$1->expr = $3; $$ = $1;}

%%

int yyerror(char const *s){
	printf("Error: %s", s);
}

int main(int argc, char *argv[]){
	if (argc == 2)
		yyin = fopen(argv[1], "r");
	yyparse();
	return 0;
}
