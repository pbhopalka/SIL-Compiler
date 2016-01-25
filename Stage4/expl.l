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
[0-9]+  {
					number = atoi(yytext);
      		yylval = makeLeaf(number);
					return NUM;
	   		}
"+" 		{return PLUS;}
"-" 		{return SUB;}
"*" 		{return MUL;}
"/" 		{return DIV;}
"=" 		{return ASSG;}
"<"			{return LT;}
">"			{return GT;}
"<="		{return LE;}
">="		{return GE;}
"=="		{return EQ;}
"!="		{return NE;}
"read"  {return READ;}
"write" {return WRITE;}
"BEGIN" {return BEGIN1;}
"END" 	{return END;}
"if"		{return IF;}
"then" 	{return THEN;}
"else" 	{return ELSE;}
"endif"	{return ENDIF;}
"while"	{return WHILE;}
"do"		{return DO;}
"endwhile"	{return ENDWHILE;}
[ \t] 	{}
[;]   	{return *yytext;}
[()] 		{return *yytext;}
[\n] 		{}
. 			{yyerror("Unknown character.\n");}

%%

int yywrap(){
	return 1;
}
