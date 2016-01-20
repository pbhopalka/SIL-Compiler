%{
	#include <stdio.h>
	#include <stdlib.h>
	
	int yylex();
	int yyerror();
%}

%right '='
%token DIGIT
%left '+' '-'
%left '*' '/'


%%

start: expL
	 ;

expL: expr '\n' {printf("%d\n", $1);}
	 | expL expr '\n' {printf("%d\n", $2);}
	 | expL '\n' {exit(1);}
	 ;

expr: expr '+' expr {$$ = $1 + $3;}
	| expr '-' expr {$$ = $1 - $3;}
	| expr '*' expr {$$ = $1 * $3;}
	| expr '/' expr {$$ = $1 / $3;}
	| '(' expr ')' {$$ = $2;}
	| expr '=' 
	| DIGIT {$$ = $1;}
	;
		
%%

int yyerror(char const *s){
	printf("%s", s);
	return 1;
}

int main(){
	printf("Welcome to PB's Calculator. Press enter only to exit.\nPress the equal sign and enter to see the result\n");
	yyparse();
	return 1;
}
