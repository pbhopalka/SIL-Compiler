%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "ast.h"

	#define YYSTYPE tnode*
	#include "y.tab.h"

	int number;
	int yyerror();
%}

letter [a-zA-Z]
digit [0-9]+

%%

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
"DECL"	{return DECL;}
"ENDDECL" {return ENDDECL;}
"int"		{return integer;}
"if"		{return IF;}
"then" 	{return THEN;}
"else" 	{return ELSE;}
"endif"	{return ENDIF;}
"while"	{return WHILE;}
"do"		{return DO;}
"endwhile"	{return ENDWHILE;}
{letter}({letter}|{digit})*   {
          											yylval = makeID(yytext);
          											return ID;
        											}
{digit}  {
					number = atoi(yytext);
      		yylval = makeLeaf(number);
					return NUM;
	   		}
[ \t] 	{}
[;]   	{return *yytext;}
[()] 		{return *yytext;}
"["			{return *yytext;}
"]"			{return *yytext;}
[\n] 		{}
. 			{yyerror("Unknown character.\n");}

%%

int yywrap(){
	return 1;
}
