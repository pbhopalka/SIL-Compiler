%{
	#include <stdio.h>
	#include <string.h>
	
	#define YYSTYPE char*
	
	#include "y.tab.h"
	
	
%}

%%

[a-zA-Z]+ {
			char *c = strdup(yytext);
			yylval = c;
			return alpha;
		  }
"+" {return *yytext;}
"-" {return *yytext;}
"*" {return *yytext;}
"/" {return *yytext;}
"(" {return *yytext;}
")" {return *yytext;}
"\n" {return *yytext;}

%%

int yywrap(){
	return 1;
}
