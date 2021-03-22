%code {

#include <stdio.h>
#include <stdlib.h>
#include "parser.h"
#include "lex.yy.h"


int yyerror(pass_to_bison *bison_args, char *msg);

#define scanner bison_args->scan_ptr
}

%code requires {
    typedef struct {
        int total_isum;
        float total_fsum;
        void *scan_ptr;
    } pass_to_bison;
}


%define api.pure true
%lex-param {void *scanner}
%parse-param {pass_to_bison *bison_args}

%union {
    int ival;
    float fval;
}

%token<ival> T_INT
%token<fval> T_FLOAT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT
%token T_NEWLINE T_QUIT
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<ival> expression
%type<fval> mixed_expression


/* %initial-action ... */

%start calculation


%%

calculation: %empty
      | calculation line
;

line: T_NEWLINE
      | mixed_expression T_NEWLINE { bison_args->total_fsum += $1; printf("\tResult: %f\n", $1); }
      | expression T_NEWLINE       { bison_args->total_isum += $1; printf("\tResult: %i\n", $1); }
      | T_QUIT T_NEWLINE           {                               printf("bye!\n");  exit(0);   }
;

mixed_expression: T_FLOAT                            { $$ = $1; }
      | mixed_expression T_PLUS mixed_expression     { $$ = $1 + $3; }
      | mixed_expression T_MINUS mixed_expression    { $$ = $1 - $3; }
      | mixed_expression T_MULTIPLY mixed_expression { $$ = $1 * $3; }
      | mixed_expression T_DIVIDE mixed_expression   { $$ = $1 / $3; }
      | T_LEFT mixed_expression T_RIGHT              { $$ = $2; }
      | expression T_PLUS mixed_expression           { $$ = $1 + $3; }
      | expression T_MINUS mixed_expression          { $$ = $1 - $3; }
      | expression T_MULTIPLY mixed_expression       { $$ = $1 * $3; }
      | expression T_DIVIDE mixed_expression         { $$ = $1 / $3; }
      | mixed_expression T_PLUS expression           { $$ = $1 + $3; }
      | mixed_expression T_MINUS expression          { $$ = $1 - $3; }
      | mixed_expression T_MULTIPLY expression       { $$ = $1 * $3; }
      | mixed_expression T_DIVIDE expression         { $$ = $1 / $3; }
      | expression T_DIVIDE expression               { $$ = $1 / (float) $3; }
;

expression: T_INT                        { $$ = $1; }
      | expression T_PLUS expression     { $$ = $1 + $3; }
      | expression T_MINUS expression    { $$ = $1 - $3; }
      | expression T_MULTIPLY expression { $$ = $1 * $3; }
      | T_LEFT expression T_RIGHT        { $$ = $2; }
;

%%


int yyerror(pass_to_bison *bison_args, char *msg)
{
    fprintf(stderr, "parse error: %s in line %d\n", msg, yyget_lineno(scanner));
    return 0;
}
