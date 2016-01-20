%{
	#include <stdio.h>
	#include <stdlib.h>
	
	#define YYSTYPE tnode *
	
	#include "exptree.h"
	#include "exptree.c"
	
	int yylex(void);
	int yyerror(char const *s);

%}

%token NUM END
%left '+' '-'
%left '*' '/'

%%

prog: expr END {
					$$ = $2;
					printf("Answer: %d\n", evaluate($1));
					exit(1);
			   }		   
	 ;
	 
expr: expr '+' expr {$$ = makeOperatorNode('+', $1, $3);}
	| expr '-' expr {$$ = makeOperatorNode('-', $1, $3);}
	| expr '*' expr {$$ = makeOperatorNode('*', $1, $3);}
	| expr '/' expr {$$ = makeOperatorNode('/', $1, $3);}
	| '(' expr ')' {$$ = $2;}
	| '-' expr {$$ = makeOperatorNode('-', makeLeaf(0), $2);}
	| NUM {$$ = $1;}
	;

%%

int yyerror(char const *s){
	printf("Error: %s", s);
}

int main(void){
	yyparse();
	return 0;
}
	 
