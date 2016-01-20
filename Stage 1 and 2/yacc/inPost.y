%{

#include <stdio.h>
#include <stdlib.h>

%}

%token DIGIT
%left '+'
%left '*'
	 
%%

start : expr '\n' {printf("\nComplete");exit(1);}
	;

expr:  expr '+' expr {printf("+ ");}
	| expr '*' expr  {printf("* ");}
	| '(' expr ')'
	| DIGIT {printf("%d ",$1);}
	;

%%

yyerror()
{
	printf("Error");
}
main()
{
	yyparse();
	return 1;
}
