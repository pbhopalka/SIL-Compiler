%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "y.tab.h"
	
%}

%%

[a-z] 			{
					yylval = *yytext;
					return ID;
				}
[0-9]+ 			{
					yylval = atoi(yytext);
					return NUM;
				}
"read" 			{return READ;}
"write" 		{return WRITE;}
[=] 			{return ASSG;}
[+] 			{return PLUS;}
[*] 			{return MUL;}
[ \t] 			{}
[\n] 			{return *yytext;}
"," 			{return *yytext;}
";" 			{return *yytext;}
"(" 			{return *yytext;}
")" 			{return *yytext;}

%%

int yywrap(){
	return 1;
}
