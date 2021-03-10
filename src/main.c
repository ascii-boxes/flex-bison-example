
#include <stdio.h>

#include "parser.h"
#include "lex.yy.h"

int main()
{
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}
