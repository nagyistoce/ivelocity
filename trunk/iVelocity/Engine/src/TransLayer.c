/*
 Copyright [2011] [chunyi zhou]
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#include "TransLayer.h"
#include "StatementBlock.h"
#include "TextBlock.h"
#include "NumberBlock.h"
#include "NameBlock.h"
#include "CoreInterface.h"
#include "CmdSetBlock.h"
#include "ExpAddBlock.h"
#include "ExpSubBlock.h"
#include "Lex.h"
#include "CmdIfBlock.h"
#include "CmdForeachBlock.h"

Lex				*GlobalLex;
StatementBlock	*GlobalStatement;

void initLex(NSString *strTemplate)
{
	if (GlobalLex) {
		[GlobalLex release];
	}
	
	GlobalLex = [[Lex alloc] initWithTemplate:strTemplate];
}

id getRootStatement()
{
	return GlobalStatement;
}


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

int createString(char *text)
{
	NSString *str = [[NSString alloc] initWithFormat:@"%s", text];
	return (int)str;
}

void printStatements()
{
	[GlobalStatement print:@"-"];
}

int createEntry(int pStatement)
{
	if (GlobalStatement) {
		[GlobalStatement release];
	}
	GlobalStatement = (StatementBlock *)pStatement;
	return pStatement;
}

int createStatement(int pBlock)
{
	id subBlock = (id)pBlock;
	StatementBlock *block = [[StatementBlock alloc] initWithBlock:subBlock];
	return (int)block;
}

int createTextBlock(int pText)
{
	NSString *text = (NSString *)pText;
	TextBlock *block = [[TextBlock alloc] initWithText:text];
	[text release];
	
	return (int)block;
}

int createNumberBlock(int pNumber)
{
	NSString *text = (NSString *)pNumber;
	NumberBlock *block = [[NumberBlock alloc] initWithString:text];
	[text release];
	
	return (int)block;
}

int createNameBlock(int pName) 
{
	NSString *text = (NSString *)pName;
	
	NameBlock *block = [NameBlock createNameBlock:text];
	
	[text release];
	
	return (int)block;
}

int mergeTextStatement(int pText, int pStatement)
{
	TextBlock *textBlock = (TextBlock *)createTextBlock(pText);
	StatementBlock *stateBlock = (StatementBlock *)pStatement;
	[stateBlock addLeft:textBlock];
	return pStatement;
}

int mergeNumberStatement(int pNumber, int pStatement)
{
	NumberBlock *numberBlock = (NumberBlock *)createTextBlock(pNumber);
	StatementBlock *stateBlock = (StatementBlock *)pStatement;
	[stateBlock addLeft:numberBlock];
	return pStatement;
}

int mergeCommandStatement(int pCommandBlock, int pStatement)
{
	id commandBlock = (id)pCommandBlock;
	StatementBlock *stateBlock = (StatementBlock *)pStatement;
	[stateBlock addLeft:commandBlock];
	return pStatement;
}

int mergeShowValueStatement(int pNameBlock, int pStatement) 
{
	id nameBlock = (id)pNameBlock;
	StatementBlock *stateBlock = (StatementBlock *)pStatement;
	[stateBlock addLeft:nameBlock];
	return pStatement;
}

int createSetCommand(int pName, int pExpBlock)
{
	id nameBlock = (id)createNameBlock(pName);
	id expBlock = (id)pExpBlock;
	CmdSetBlock *block = [[CmdSetBlock alloc] initWithName:nameBlock withExp:expBlock];
	return (int)block;
}

int createIfCommand(int pExpBlock, int pStatement, int pElseStatement)
{
	CmdIfBlock *block = [[CmdIfBlock alloc] initWithExp:(id)pExpBlock 
											   withThen:(StatementBlock *)pStatement 
											   withElse:(StatementBlock *)pElseStatement];
	return (int)block;
}

int createForeachCommand(int pName, int pNameLib, int pStatement)
{
	id nameBlock = (id)createNameBlock(pName);
	id nameLibBlock = (id)createNameBlock(pNameLib);
	CmdForeachBlock *block = [[CmdForeachBlock alloc] initWithName:nameBlock 
											   withNameLib: nameLibBlock
											   withStatement:(StatementBlock *)pStatement];
	return (int)block;
}

int createExpAddBlock(int pExpBlock, int pNumber)
{
	id left = (id)pExpBlock;
	id right = (id)createNumberBlock(pNumber);
	ExpAddBlock *block = [[ExpAddBlock alloc] initWithLeft:left withRight:right];
	return (int)block;
}

int createExpSubBlock(int pExpBlock, int pNumber) 
{
	id left = (id)pExpBlock;
	id right = (id)createNumberBlock(pNumber);
	ExpSubBlock *block = [[ExpSubBlock alloc] initWithLeft:left withRight:right];
	return (int)block;
}


