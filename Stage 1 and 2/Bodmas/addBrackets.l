%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "exptree.h"
	
	#define YYSTYPE tnode*
	#include "y.tab.h"
	
	int number;
	int yyerror();
%}

%%

[0-9]+ {
			number = atoi(yytext);
			yylval = makeLeaf(number);
			return NUM;
	   }
"+" {return *yytext;}
"-" {return *yytext;}
"*" {return *yytext;}
"/" {return *yytext;}
[ \t] {}
[()] {return *yytext;}
[\n] {return END;}
. {
	yyerror("Unknown character.\n");
	exit(1);
  }
  
%%

int yywrap(){
	return 1;
}

