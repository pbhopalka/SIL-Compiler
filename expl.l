%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "ast.h"

	#define YYSTYPE tnode*
	#include "y.tab.h"

	int number;
	int lineNo = 1;
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
"read"  	{return READ;}
"write" 	{return WRITE;}
"BEGIN" 	{return BEGIN1;}
"END" 		{return END;}
"DECL"		{return DECL;}
"ENDDECL" 	{return ENDDECL;}
"int"		{return integer;}
"bool"		{return boolean;}
"if"		{return IF;}
"then" 		{return THEN;}
"else" 		{return ELSE;}
"endif"		{return ENDIF;}
"while"		{return WHILE;}
"do"		{return DO;}
"endwhile"	{return ENDWHILE;}
"AND"		{return AND;}
"OR"		{return OR;}
"NOT"		{return NOT;}
"TRUE"		{yylval = makeLeaf(1, boolean);return NUM;}
"FALSE"		{yylval = makeLeaf(0, boolean);return NUM;}
"return"	{return RETURN;}
{letter}({letter}|{digit})*   {yylval = makeID(yytext);return ID;}
{digit}  	{number = atoi(yytext); yylval = makeLeaf(number, integer); return NUM;}
[ \t] 		{}
[;]   		{return *yytext;}
[,]			{return *yytext;}
[()] 		{return *yytext;}
"["			{return *yytext;}
"]"			{return *yytext;}
[\n] 		{lineNo++;}
. 			{yyerror("Line: %d :: Unknown character.\n", lineNo);}

%%

int yywrap(){
	return 1;
}
