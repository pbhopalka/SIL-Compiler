%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "ast.h"

	#define YYSTYPE tnode*
	#include "y.tab.h"

	int number;
	int yyerror();
%}

%%

[a-z]   {
          yylval = makeID(yytext);
          return ID;
        }
[0-9]+ {
			number = atoi(yytext);
      yylval = makeLeaf(number);
			return NUM;
	   }
"+" 	{return PLUS;}
"-" 	{return SUB;}
"*" 	{return MUL;}
"/" 	{return DIV;}
"=" 	{return ASSG;}
"read"  {return READ;}
"write" {return WRITE;}
"begin" {return BEGIN1;}
"end" {return END;}
[ \t] {}
[;]   {return *yytext;}
[()] 	{return *yytext;}
[\n] 	{}
. {
	yyerror("Unknown character.\n");
  }

%%

int yywrap(){
	return 1;
}
