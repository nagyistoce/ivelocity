%{
	#include <stdio.h>
	#include "TransLayer.h"
	
	#define YYDEBUG 1
	#define YYERROR_VERBOSE
	
	extern int yylex(void);

	void yyerror(char *s)
	{
		fprintf(stderr, "Error:%s\n", s);
	}
	
	int yywrap (void)
	{
		return 1;
	}
%}

%token NAME NUMBER SET TEXT IF ELSE END FOREACH IN STRING EQ BG BE LT LE NE

%%

entry: statement				{ $$ = createEntry($1); }

statement: TEXT					{ $$ = createStatement(createTextBlock($1));}		
	|	showvalue				{ $$ = createStatement($1); }
	|	TEXT statement			{ $$ = mergeTextStatement($1, $2); }
	|	NUMBER statement		{ $$ = mergeNumberStatement($1, $2); }
	|	command statement		{ $$ = mergeCommandStatement($1, $2); }
	|	showvalue statement		{ $$ = mergeShowValueStatement($1, $2); }
	;

command:	SET '(' NAME '=' expression ')'					{ $$ = createSetCommand($3, $5);}
	|	IF '(' expression ')' statement END					{ $$ = createIfCommand($3, $5, 0); }
	|	IF '(' expression ')' statement ELSE statement END	{ $$ = createIfCommand($3, $5, $7); }
	|	FOREACH '(' NAME IN NAME ')' statement END			{ $$ = createForeachCommand($3, $5, $7); }
	;

showvalue:	NAME { $$ = createNameBlock($1); }
	;

expression:	expression '+' NUMBER	{ $$ = createExpAddBlock($1, $3); }
	|	expression '-' NUMBER		{ $$ = createExpSubBlock($1, $3); }
	|	expression NE expression	{ $$ = createExpCompareBlock($1, 0, $3); }
	|	expression BG expression	{ $$ = createExpCompareBlock($1, 1, $3); }
	|	expression BE expression	{ $$ = createExpCompareBlock($1, 2, $3); }
	|	expression EQ expression	{ $$ = createExpCompareBlock($1, 3, $3); }
	|	expression LE expression	{ $$ = createExpCompareBlock($1, 4, $3); }
	|	expression LT expression	{ $$ = createExpCompareBlock($1, 5, $3); }
	|	NUMBER						{ $$ = createNumberBlock($1); }
	|	STRING						{ $$ = createStringBlock($1); }
	|	NAME						{ $$ = createNameBlock($1); }
	;

%%









