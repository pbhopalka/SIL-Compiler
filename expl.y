%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	#include "expl.h"
	#include "expl.c"

	int var[26];
	int yylex(void);
	int yyerror(char const *s);
%}

%token NUM ID PLUS SUB MUL DIV MOD ASSG READ WRITE LT GT LE GE EQ NE
%token integer boolean
%token IF THEN ELSE ENDIF WHILE DO ENDWHILE //doubt here, whether val or tNode
%left PLUS SUB
%left MUL DIV
%left MOD

%%

Program: Slist '\n' {exit(0);}
	   ;

Slist: Stmt Slist 			{$$ = makeSyntaxTree($1, $2);}
	 | Stmt								{$$ = makeSyntaxTree($1, NULL);}
	 ;

Stmt: ID ASSG expr ';' 									{$$ = makeAssgNode(ASSG, $1, $3);}
	| READ '(' ID ')' ';'									{$$ = makeIONode(READ, $3);}
	| WRITE '(' expr ')' ';'							{$$ = makeIONode(WRITE, $3);}
	| IF '(' expr ')' THEN Slist ELSE Slist ENDIF ';'	{$$ = makeConditionalNode(IF, $3, $6, $8);}
	| IF '(' expr ')' THEN Slist ENDIF ';'						{$$ = makeConditionalNode(IF, $3, $6);}
	| WHILE '(' expr ')' DO Slist ENDWHILE ';'				{$$ = makeIterativeNode(WHILE, $3, $6);}
	;

expr: expr PLUS expr 		{$$ = makeOperatorNode(PLUS, $1, $3);}
	| expr SUB expr 			{$$ = makeOperatorNode(SUB, $1, $3);}
	| expr MUL expr 			{$$ = makeOperatorNode(MUL, $1, $3);}
	| expr DIV expr 			{$$ = makeOperatorNode(DIV, $1, $3);}
	| expr MOD expr 			{$$ = makeOperatorNode(MOD, $1, $3);}
	| '(' expr ')' 				{$$ = $2;}
	| expr LT expr				{$$ = makeRelOpNode(LT, $1, $3);}
	| expr GT expr				{$$ = makeRelOpNode(GT, $1, $3);}
	| expr EQ expr 				{$$ = makeRelOpNode(EQ, $1, $3);}
	| expr LE expr 				{$$ = makeRelOpNode(LE, $1, $3);}
	| expr GE expr 				{$$ = makeRelOpNode(GE, $1, $3);}
	| expr NE expr 				{$$ = makeRelOpNode(NE, $1, $3);}
	| NUM									{$$ = $1;}
	| ID 									{$$ = $1;}
	;

%%

int yyerror(char const *s){
	printf("Error: %s\n", s);
}

int main(){
	yyparse();
	return 0;
}
