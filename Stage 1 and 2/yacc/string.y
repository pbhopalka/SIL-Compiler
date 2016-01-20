%{
	#include <stdio.h>
	#include <stdlib.h>
	
	#define YYSTYPE char*
	
	int yylex();
	int yyerror();
%}

%token alpha
%left '+' 
%left '*'

%%

start : expr '\n' {printf("\nComplete");exit(1);}
	;

expr:  expr '+' expr {printf("+ ");}
	| expr '*' expr  {printf("* ");}
	| '(' expr ')'
	| alpha {printf("%s ",$1);}
	;

%%

int yyerror()
{
	printf("Error");
	return 1;
}

int main()
{
	yyparse();
	return 1;
}
