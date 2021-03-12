#include <stdio.h>

#include "parser.h"
#include "lex.yy.h"


int main()
{
	/* This data is passed to the parser, including a lexer (scanner) */
	pass_to_bison bison_args;
	bison_args.total_isum = 0;
	bison_args.total_fsum = 0.0f;

	/* This data is passed to the lexer, and used to get data back from it */
	pass_to_flex flex_extra_data;
	flex_extra_data.count_int = 0;
	flex_extra_data.count_float = 0;

	/* Perform the parsing */
	yylex_init_extra(&flex_extra_data, &(bison_args.scan_ptr));
	yyset_in(stdin, bison_args.scan_ptr);
	do {
	    yyparse(&bison_args);   /* discard return code */
	} while(!feof(stdin));
    yylex_destroy(bison_args.scan_ptr);


	/* We can access data collected during the parsing: */
	printf("\n");
	if (bison_args.total_fsum < 0.00000f || bison_args.total_fsum > 0.00000f) {
		printf("TOTAL SUM was: %f\n", bison_args.total_fsum + bison_args.total_isum);
	} else {
		printf("TOTAL SUM was: %i\n", bison_args.total_isum);
	}

	/* We can access data collected during lexing: */
	int num_count = flex_extra_data.count_int + flex_extra_data.count_float;
	printf("Percentage of floating point numbers used: %.1f%%\n",
		num_count ? (100 * flex_extra_data.count_float / num_count) : 0.0f);

	return 0;
}
