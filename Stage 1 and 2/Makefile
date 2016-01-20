all:	build compile

build:
		@read -p "Enter filename:" file; \
		lex $$file.l; \
		yacc -d $$file.y

compile:	lex.yy.c y.tab.c
		gcc lex.yy.c y.tab.c -o exe

clean:
		rm lex.yy.c y.tab.c exe y.tab.h
