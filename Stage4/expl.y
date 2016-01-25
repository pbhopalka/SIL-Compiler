%{
	#include <stdio.h>
	#include <stdlib.h>

	#define YYSTYPE tnode *

	#include "ast.h"
	#include "ast.c"

	int yylex(void);
	int yyerror(char const *s);

%}

%token NUM END ID
%token READ WRITE
%token PLUS SUB MUL DIV ASSG
%left PLUS SUB
%left MUL DIV

%%

prog: Slist END {
					//evaluate($1);
					exit(0);
			   }
	 ;

Slist:Stmt         {/*evaluate($1);printf("%d\n", $1->val);$$ = $1;*/}
     ;

Stmt: ID ASSG expr ';'        {
                                printf("Stmt");
                                /*$$ = makeOperatorNode(ASSG, $1, $3);
                                evaluate($$);
                                printf("%d\n", $$->val);*/
                                }
    | READ '(' ID ')' ';'     {$$ = makeIONode(READ, $3);}
    | WRITE '(' expr ')' ';'  {$$ = makeIONode(WRITE, $3);}
    ;

expr: expr PLUS expr {$$ = makeOperatorNode(PLUS, $1, $3);}
	| expr SUB expr {$$ = makeOperatorNode(SUB, $1, $3);}
	| expr MUL expr {$$ = makeOperatorNode(MUL, $1, $3);}
	| expr DIV expr {$$ = makeOperatorNode(DIV, $1, $3);}
	| '(' expr ')' {$$ = $2;}
	| SUB expr     {$$ = makeOperatorNode(SUB, makeLeaf(0), $2);}
	| NUM          {printf("NUM\n");$$ = $1;}
  | ID           {printf("ID\n");$$ = $1;}
	;

%%

int yyerror(char const *s){
	printf("Error: %s", s);
}

int main(void){
	yyparse();
	return 0;
}
