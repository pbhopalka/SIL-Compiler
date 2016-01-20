%option noyywrap
%{
	#include <stdio.h>
	#include <stdlib.h>
%}

number [0-9]+

%%

{number} {
			if (atoi(yytext) % 2 == 0)
				printf("even");
			else
				printf("odd");
		 }

%%

int main(){
	yylex();
	return 1;
}
