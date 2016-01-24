%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <stdbool.h>

	#include "expl.h"
	#include "symboltable.h"
	#include "expl.c"
	#include "symboltable.c"

	#define YYSTYPE tNode*

	int var[26];
	gTable globalVar[100];
	int count = 0;
	int yylex(void);
	int yyerror(char const *s);
%}

%token NUM BOOL BEGIN END ID DECL ENDDECL
%token PLUS SUB MUL DIV MOD ASSG READ WRITE LT GT LE GE EQ NE
%token integer boolean
%token IF THEN ELSE ENDIF WHILE DO ENDWHILE //doubt here, whether val or tNode
%left PLUS SUB
%left MUL DIV
%left MOD
%nonassoc LT GT LE GE EQ NE

%%

Program: gdecl body {evaluate($2); printf("Complete\n"); exit(0);}
	   ;

gdecl: DECL decllist ENDDECL	{}
		 ;

decllist: decl decllist 			{}
				| decl								{}
				;

decl: integer idlist ';'						{
																			globalVar[count] = (gTable*)malloc(sizeof(gTable));
																			gInstall(globalVar[count], integer, $2->name, 0);
																			count++;
																		}
		| boolean idlist ';'						{
																			globalVar[count] = (gTable*)malloc(sizeof(gTable));
																			gInstall(globalVar[count], boolean, $2->name, 0);
																			count++;
																		}
		| integer ID '[' NUM ']' ';'		{
																			if($2->dataType != integer)
																				yyerror("Type is not integer\n");
																			globalVar[count] = (gTable*)malloc(sizeof(gTable));
																			gInstall(globalVar[count], integer, $2->name, $4->val);
																			count++;
																		}
		| boolean ID '[' NUM ']' ';'		{
																			if($2->dataType != boolean)
																				yyerror("Type is not boolean\n");
																			globalVar[count] = (gTable*)malloc(sizeof(gTable));
																			gInstall(globalVar[count], boolean, $2->name, $4->val);
																			count++;
																		}
		;

idlist: ID ',' idlist 						{$$ = $1;}
			| ID												{$$ = $1;}
			;

arraylist: ID '[' NUM ']' ',' arraylist
				 |
				 ;

body: BEGIN Slist END 	{$$ = $2;}
		;

Slist: Stmt Slist 			{$$ = makeSyntaxTree($1, $2);}
	 | Stmt								{$$ = makeSyntaxTree($1, NULL);}
	 ;

Stmt: ID ASSG expr ';' 									{$$ = makeAssgNode(ASSG, $1, $3, NULL);} //change Function
	| ID '[' expr ']' ASSG expr ';'				{$$ = makeAssgNode(ASSG, $1, $3, $6);}
	| READ '(' ID ')' ';'									{$$ = makeIONode(READ, $3, NULL);} //change Function
	| READ '(' ID '[' expr ']' ')' ';'		{$$ = makeIONode(READ, $3, $5);}
	| WRITE '(' expr ')' ';'							{$$ = makeIONode(WRITE, $3, NULL);}
	| IF '(' expr ')' THEN Slist ELSE Slist ENDIF ';'	{$$ = makeConditionalNode(IF, $3, $6, $8);}
	| IF '(' expr ')' THEN Slist ENDIF ';'						{$$ = makeConditionalNode(IF, $3, $6, NULL);}
	| WHILE '(' expr ')' DO Slist ENDWHILE ';'				{$$ = makeIterativeNode(WHILE, $3, $6);}
	| ';'																							{}
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
	| expr NE expr 				{$$ = makeRelOpNode(NE, $1, $3);} //haven't yet added AND, OR, NOT
	| NUM									{$$ = $1;}
	| BOOL								{$$ = $1;}
	| ID 									{$$ = makeOperatorNode(ID, $1, NULL);}
	| ID '[' expr ']'			{$$ = makeOperatorNode(ID, $1, $3);}
	;

%%

int yyerror(char const *s){
	printf("Error: %s\n", s);
}

int main(){
	yyparse();
	return 0;
}
