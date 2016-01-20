%{
	#include <stdio.h>
	#include <stdlib.h>
	
	int var[26];
	int yylex(void);
	int yyerror(char const *s);
%}

%token NUM ID PLUS MUL ASSG READ WRITE
%left PLUS
%left MUL

%%

Program: Slist '\n' {exit(0);}
	   ;

Slist: Slist Stmt
	 | Stmt
	 ;

Stmt: ID ASSG expr ';' 		{var[$1 - 'a'] = $3;}
	| READ '(' ID ')' ';'	{scanf("%d", &var[$3 - 'a']);}
	| WRITE '(' expr ')' ';'	{printf("%d\n", $3);}
	;
	 
expr: expr PLUS expr 	{$$ = $1 + $3;}
	| expr MUL expr 	{$$ = $1 * $3;}
	| '(' expr ')' 		{$$ = $2;}
	| NUM				{$$ = $1;}
	| ID 				{$$ = var[$1 - 'a'];}
	;
	
%%

int yyerror(char const *s){
	printf("Error: %s\n", s);
}

int main(){
	yyparse();
	return 0;
}
