%{
#include <stdio.h>

#include "parser.h"
/* better don't #include "lex.yy.h" */

%}

%option 8bit
%option bison-bridge
%option case-insensitive
%option ecs
%option nodefault
%option noinput
%option nounput
%option noyywrap
%option reentrant
%option warn
%option yylineno

%%

[ \t]	; // ignore all whitespace
[0-9]+\.[0-9]+ 	{yylval->fval = atof(yytext); return T_FLOAT;}
[0-9]+		{yylval->ival = atoi(yytext); return T_INT;}
\n		{return T_NEWLINE;}
"+"		{return T_PLUS;}
"-"		{return T_MINUS;}
"*"		{return T_MULTIPLY;}
"/"		{return T_DIVIDE;}
"("		{return T_LEFT;}
")"		{return T_RIGHT;}
"exit"		{return T_QUIT;}
"quit"		{return T_QUIT;}

%%
