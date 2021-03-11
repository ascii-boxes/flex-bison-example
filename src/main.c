
#include <stdio.h>

#include "parser.h"
#include "lex.yy.h"

int main()
{
	/* TODO pass argument to scanner, and get data back */

    yyscan_t scanner;

    yylex_init(&scanner);
	yyset_in(stdin, scanner);
	do {
	    yyparse(scanner);   /* discard return code */
	} while(!feof(stdin));
    yylex_destroy(scanner);

	return 0;
}
