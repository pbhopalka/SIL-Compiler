%{
	#include <stdio.h>
	#include <stdlib.h>
	int count1 = 0;

%}

zero [0]
one [1]
enter ['\n']

%%

{zero} 
{one}  {count1 = count1 + 1;}
{enter} {return 1;}

%%

int yywrap(){
	return 0;
}

int main(){
	yylex();
	if (count1 % 2== 0)
		printf("Even parity\n");
	else
		printf("Odd parity\n");
	return 1;
}
