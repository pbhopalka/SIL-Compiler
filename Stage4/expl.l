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
          printf("ID\n");
          return ID;
        }
[0-9]+ {
			number = atoi(yytext);
			printf("%d\n", number);
      yylval = makeLeaf(number);
			return NUM;
	   }
"+" {printf("%d\n", PLUS);return PLUS;}
"-" {printf("%d\n", SUB);return SUB;}
"*" {printf("%d\n", MUL);return MUL;}
"/" {printf("%d\n", DIV);return DIV;}
"=" {printf("%d\n", ASSG);return ASSG;}
"read"  {return READ;}
"write" {return WRITE;}
[ \t] {}
[;]   {printf("%s\n", yytext);}
[()] {return *yytext;}
[\n] {printf("Enter\n");return END;}
. {
	yyerror("Unknown character.\n");
  }

%%

int yywrap(){
	return 1;
}
