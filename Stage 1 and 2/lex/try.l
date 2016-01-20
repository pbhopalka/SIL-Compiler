%option noyywrap

%{
	#include <stdio.h>
	#include <stdlib.h>
	
	#define ID 1
	#define ER 2
%}

low [a-zA-Z]
number [0-9]

%%

({low}+{number}) return 1;

%%

int main()
{
	int num = yylex();
	if (num == 1)
		printf("Accept");
	else
		printf("Reject");
}
