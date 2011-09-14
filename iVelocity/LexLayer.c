/*
 *  LexLayer.c
 *  iVelocity
 *
 *  Created by chunyi.zhoucy on 11-9-10.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "LexLayer.h"

Lex				*GlobalLex;

int yylex(int *yylval)
{
	if (GlobalLex) {
		NSMutableString *returnString = [[NSMutableString alloc] init];
		int res = [GlobalLex getToken:returnString];
		switch (res) {
			case NAME:
			case NUMBER:
			case TEXT:
				*yylval = (int)returnString;
				return res;
				
			default:
				break;
		}
		*yylval = 0;
		[returnString release];
		return res;
	}
	
	return 0;
}

void initLex(NSString *strTemplate)
{
	if (GlobalLex) {
		[GlobalLex release];
	}
	
	GlobalLex = [[Lex alloc] initWithTemplate:strTemplate];
}



