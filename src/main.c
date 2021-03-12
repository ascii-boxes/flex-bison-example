
#include <stdio.h>

#include "parser.h"
#include "lex.yy.h"

/* TODO exchange data with lexer */

int main()
{
	/* This data is passed to the parser, including a lexer (scanner) */
	pass_to_bison bison_args;
	bison_args.total_isum = 0;
	bison_args.total_fsum = 0.0f;

	/* Perform the parsing */
    yylex_init(&(bison_args.scan_ptr));
	yyset_in(stdin, bison_args.scan_ptr);
	do {
	    yyparse(&bison_args);   /* discard return code */
	} while(!feof(stdin));
    yylex_destroy(bison_args.scan_ptr);

	/* We can access data collected during the parsing: */
	if (bison_args.total_fsum < 0.00000f || bison_args.total_fsum > 0.00000f) {
		printf("TOTAL SUM was: %f\n", bison_args.total_fsum + bison_args.total_isum);
	} else {
		printf("TOTAL SUM was: %i\n", bison_args.total_isum);
	}

	return 0;
}
