all:	build compile run

build: 
		@echo "Make sure your lex and yacc filenames are same. Dont include the extension"; \
		read -p "Enter filename:" file; \
		lex $$file.l; \
		yacc -d $$file.y

compile:	lex.yy.c y.tab.c
		gcc lex.yy.c y.tab.c -o exe

run: 
		./exe

clean:
		rm lex.yy.c y.tab.c exe y.tab.h
