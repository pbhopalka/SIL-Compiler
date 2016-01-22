%{
	#include <stdio.h>
	#include <stdlib.h>
	#define YYSTYPE tNode*

	#include "y.tab.h"

	int number;
%}

%%

[a-z] 	{
					yylval = makeIdNode(yytext);
					return ID;
				}
[0-9]+ 	{
					number = atoi(yytext);
					yylval = makeNum(number);
					return NUM;
				}
"read" 		{return READ;}
"write"		{return WRITE;}
[=] 			{return ASSG;}
[+] 			{return PLUS;}
[-]				{return SUB;}
[*] 			{return MUL;}
[/]				{return DIV;}
[%]				{return MOD;}
[<]				{return LT;}
[>]				{return GT;}
"<="			{return LE;}
">="			{return GE;}
"!="			{return NE;}
"=="			{return EQ;}
[ \t] 		{}
[\n] 			{return *yytext;}
"," 			{return *yytext;}
";" 			{return *yytext;}
"(" 			{return *yytext;}
")" 			{return *yytext;}

%%

int yywrap(){
	return 1;
}
