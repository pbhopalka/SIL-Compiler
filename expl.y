%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	extern FILE *yyin;

	#define YYSTYPE tnode *

	#include "ast.h"
	#include "symbolTable.h"
	#include "ast.c"
	#include "symbolTable.c"

	int yylex(void);
	int yyerror(char const *s);

%}

%token NUM ID BEGIN1 END
%token READ WRITE DECL ENDDECL
%token integer boolean
%token IF THEN ELSE ENDIF WHILE DO ENDWHILE
%token PLUS SUB MUL DIV ASSG
%token LT GT LE GE EQ NE
%left PLUS SUB
%left MUL DIV
%nonassoc LT GT LE GE EQ NE

%%

prog: declaration body
		;

declaration: DECL decllist ENDDECL
					 ;

decllist: decl decllist
				| decl
				|
				;

decl: integer ID ';'		{gInstall($2->name, integer, 1);}
		| integer ID '[' NUM ']' ';' {gInstall($2->name, integer, $4->val);}
		;

body: BEGIN1 Slist END	{provideMemorySpace();evaluate($2);exit(0);}
	 ;

Slist: Stmt Slist       {$$ = makeStatement($1, $2);}
		 | Stmt							{$$ = makeStatement($1, NULL);}
		 |									{}
     ;

Stmt: loc ASSG expr ';'      	{$$ = makeOperatorNode(ASSG, $1, $3);}
    | READ '(' loc ')' ';'     {$$ = makeIONode(READ, $3);}
    | WRITE '(' expr ')' ';'  {$$ = makeIONode(WRITE, $3);}
		| IF '(' expr ')' THEN Slist ELSE Slist ENDIF ';'	{$$ = makeConditionalNode($3, $6, $8);}
		| IF '(' expr ')' THEN Slist ENDIF ';'						{$$ = makeConditionalNode($3, $6, NULL);}
		| WHILE '(' expr ')' DO Slist ENDWHILE ';' 				{$$ = makeIterativeNode($3, $6);}
    ;

expr: expr PLUS expr 				{$$ = makeOperatorNode(PLUS, $1, $3);}
	| expr SUB expr 					{$$ = makeOperatorNode(SUB, $1, $3);}
	| expr MUL expr 					{$$ = makeOperatorNode(MUL, $1, $3);}
	| expr DIV expr 					{$$ = makeOperatorNode(DIV, $1, $3);}
	| '(' expr ')' 						{$$ = $2;}
	| SUB expr     						{$$ = makeOperatorNode(SUB, makeLeaf(0), $2);}
	| expr LT expr						{$$ = makeOperatorNode(LT, $1, $3);}
	| expr GT expr						{$$ = makeOperatorNode(GT, $1, $3);}
	| expr LE expr						{$$ = makeOperatorNode(LE, $1, $3);}
	| expr GE expr						{$$ = makeOperatorNode(GE, $1, $3);}
	| expr EQ expr						{$$ = makeOperatorNode(EQ, $1, $3);}
	| expr NE expr						{$$ = makeOperatorNode(NE, $1, $3);}
	| NUM          						{$$ = $1;}
  | loc           						{$$ = $1;}
	;

loc: ID								{$$ = $1;}
	 | ID '[' expr ']'	{$1->expr = $3;$$ = $1;}
	 ;

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
