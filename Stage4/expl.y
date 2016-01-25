%{
	#include <stdio.h>
	#include <stdlib.h>

	#define YYSTYPE tnode *

	#include "ast.h"
	#include "ast.c"

	int yylex(void);
	int yyerror(char const *s);

%}

%token NUM ID BEGIN1 END
%token READ WRITE
%token PLUS SUB MUL DIV ASSG
%left PLUS SUB
%left MUL DIV

%%

prog: BEGIN1 Slist END	{
												while ($2 != NULL){
													evaluate($2->expr);
													$2 = $2->left;
												}
												exit(0);
										  }
	 ;

Slist: Stmt Slist       {$$ = makeStatement($1, $2);}
		 | Stmt							{$$ = makeStatement($1, NULL);}
     ;

Stmt: ID ASSG expr ';'      	{$$ = makeOperatorNode(ASSG, $1, $3);}
    | READ '(' ID ')' ';'     {$$ = makeIONode(READ, $3);}
    | WRITE '(' expr ')' ';'  {$$ = makeIONode(WRITE, $3);}
    ;

expr: expr PLUS expr {$$ = makeOperatorNode(PLUS, $1, $3);}
	| expr SUB expr {$$ = makeOperatorNode(SUB, $1, $3);}
	| expr MUL expr {$$ = makeOperatorNode(MUL, $1, $3);}
	| expr DIV expr {$$ = makeOperatorNode(DIV, $1, $3);}
	| '(' expr ')' {$$ = $2;}
	| SUB expr     {$$ = makeOperatorNode(SUB, makeLeaf(0), $2);}
	| NUM          {$$ = $1;}
  | ID           {$$ = $1;}
	;

%%

int yyerror(char const *s){
	printf("Error: %s", s);
}

int main(void){
	yyparse();
	return 0;
}
