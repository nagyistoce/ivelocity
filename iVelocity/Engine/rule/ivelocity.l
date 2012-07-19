%{
	#include <stdio.h>
	#include "TransLayer.h"
	
	#define NAME 258
	#define NUMBER 259
	#define SET 260
	#define TEXT 261
	#define IF 262
	#define ELSE 263
	#define END 264
	#define FOREACH 265
	#define IN	266
	#define STRING 267
	#define EQ 268
	#define BG 269
	#define BE 270
	#define LT 271
	#define LE 272
	#define NE 273
	
	extern int yylval;
	
%}

%option noyywrap

%start cond

%%


\#if[ \t]*		{BEGIN cond; printf("start cond"); return IF;}
\#set[ \t]*		{BEGIN cond; return SET;}
\#else			{return ELSE;}
\#end			{return END;}
\#foreach[ \t]* {BEGIN cond; return FOREACH;}
\#				{printf("TEXT[%s]", yytext);
				 yylval = createString(yytext);
				 return TEXT;
				}

<cond>[ \t]+ 	{printf("blank");};
<cond>\(		{return '(';}
<cond>\) 		{BEGIN 0; printf("end cond"); return ')';}
<cond>\=\=		{return EQ;}
<cond>\>		{return BG;}
<cond>\>\=		{return BE;}
<cond>\<		{return LT;}
<cond>\<\=		{return LE;}
<cond>\!\=		{return NE;}
<cond>\=		{return '=';}
<cond>\+		{return '+';}
<cond>\-		{return '-';}
<cond>[0-9]+	{
		printf("NUMBER[%s]", yytext);
		yylval = createString(yytext);
		return NUMBER;
	}
<cond>'[a-zA-Z]+' {
		printf("STRING[%s]", yytext);
		char s[100];
		strcpy(s, yytext+1);
		s[strlen(s)-1] = 0;
		yylval = createString(s);
		return STRING;
	}
<cond>in		{return IN;}
	

\$[a-zA-Z0-9_.\[\]]+  {
		printf("NAME[%s]", yytext);
		yylval = createString(yytext+1);
		return NAME;
	}

<INITIAL>[^\#\$]+ {
		printf("TEXT[%s]", yytext);
		yylval = createString(yytext);
		return TEXT;
	}

\$	{printf("TEXT[%s]", yytext);
	yylval = createString(yytext);
	return TEXT;
	};

%%

