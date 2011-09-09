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

#import "Lex.h"

@implementation Lex

NSCharacterSet *veloSet;
NSCharacterSet *serpSet;
NSCharacterSet *condSet;
NSCharacterSet *nameSerpSet;

- (id) initWithTemplate:(NSString *)templ
{
	if (self = [super init]) {
		
		if (!veloSet) {
			veloSet = [NSCharacterSet characterSetWithCharactersInString:@"#$"];
		}
		
		if (!serpSet) {
			serpSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n"];
		}
		
		if (!condSet) {
			condSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n("];
		}
		
		if (!nameSerpSet) {
			nameSerpSet = [NSCharacterSet characterSetWithCharactersInString:@"#$ \t\n<=>!*/()"];
		}
		
		strTemplate = [[NSString alloc] initWithString:templ];
		
		pos = 0;
		startStatus = LEX_START_INIT;
	}
	return self;
}

- (int) checkSet:(NSString *)cur_template
{
	int offset = [cur_template rangeOfCharacterFromSet:condSet].location;
	
	if (offset>cur_template.length) {
		offset = cur_template.length;
	}
	
	NSString *cmd_string = [cur_template substringToIndex:offset];
	
	if([[cmd_string lowercaseString] compare:@"#set"] == 0) {
		cur_template = [cur_template substringFromIndex:4];
		offset = [cur_template rangeOfCharacterFromSet:[serpSet invertedSet]].location;
		
		if (offset>cur_template.length) {
			offset = cur_template.length;
		}
		
		return 4 + offset;
	}
	
	return 0;
}

- (int) checkIf:(NSString *)cur_template
{
	int offset = [cur_template rangeOfCharacterFromSet:condSet].location;
	
	if (offset>cur_template.length) {
		offset = cur_template.length;
	}
	
	NSString *cmd_string = [cur_template substringToIndex:offset];
	
	if([[cmd_string lowercaseString] compare:@"#if"] == 0) {
		cur_template = [cur_template substringFromIndex:3];
		offset = [cur_template rangeOfCharacterFromSet:[serpSet invertedSet]].location;
		
		if (offset>cur_template.length) {
			offset = cur_template.length;
		}
		
		return 3 + offset;
	}
	
	return 0;
}

- (int) checkElse:(NSString *)cur_template
{
	int offset = [[cur_template substringFromIndex:1] rangeOfCharacterFromSet:nameSerpSet].location;
	
	if (offset>cur_template.length) {
		offset = cur_template.length-1;
	}
	
	NSString *cmd_string = [cur_template substringToIndex:(offset+1)];
	
	if([[cmd_string lowercaseString] compare:@"#else"] == 0) {
		return 5;
	}
	
	return 0;
}

- (int) checkEnd:(NSString *)cur_template
{
	int offset = [[cur_template substringFromIndex:1] rangeOfCharacterFromSet:nameSerpSet].location;
	
	if (offset>cur_template.length) {
		offset = cur_template.length-1;
	}
	
	NSString *cmd_string = [cur_template substringToIndex:(offset+1)];
	
	if([[cmd_string lowercaseString] compare:@"#end"] == 0) {
		return 4;
	}
	
	return 0;
}

- (int) checkForeach:(NSString *)cur_template
{
	int offset = [cur_template rangeOfCharacterFromSet:condSet].location;
	
	if (offset>cur_template.length) {
		offset = cur_template.length;
	}
	
	NSString *cmd_string = [cur_template substringToIndex:offset];
	
	if([[cmd_string lowercaseString] compare:@"#foreach"] == 0) {
		cur_template = [cur_template substringFromIndex:3];
		offset = [cur_template rangeOfCharacterFromSet:[serpSet invertedSet]].location;
		
		if (offset>cur_template.length) {
			offset = cur_template.length;
		}
		
		return 8 + offset;
	}
	
	return 0;
}


- (int) checkText:(NSString *)cur_template
{
	int offset = [cur_template rangeOfCharacterFromSet:veloSet].location;
	
	if (offset>cur_template.length) {
		return [cur_template length];
	}
	
	return offset;
}

- (int) checkAllCommand:(unichar)t 
		   withTemplate:(NSString *)cur_template
{
	if ( t == '#') {
		//! command
		int offset;
		
		if (offset = [self checkSet:cur_template]) {
			startStatus = LEX_START_COND;
			pos += offset;
			return SET;
		} 
		
		if (offset = [self checkIf:cur_template]) {
			startStatus = LEX_START_COND;
			pos += offset;
			return IF;
		}
		
		if (offset = [self checkElse:cur_template]){
			pos += offset;
			return ELSE;
		}
		
		if (offset = [self checkEnd:cur_template]){
			pos += offset;
			return END;
		}
		
		if (offset = [self checkForeach:cur_template]){
			startStatus = LEX_START_COND;
			pos += offset;
			return FOREACH;
		}
		
		// new add here ...
		
	}
	return 0;
}

- (int) checkName:(NSString *)cur_template
{
	int offset = [cur_template rangeOfCharacterFromSet:nameSerpSet].location;
	if (offset > cur_template.length) {
		return [cur_template length];
	}
	
	return offset;
}

- (int) checkAllName:(unichar)t 
		withTemplate:(NSString *)cur_template
		  withReturn:(NSMutableString *)return_string
{
	if (t == '$'){
		int offset;
		
		//! name
		cur_template = [cur_template substringFromIndex:1];
		offset = [self checkName:cur_template];
		[return_string setString:[cur_template substringToIndex:offset]];
		pos += offset + 1;
		return NAME;
	}
	
	return 0;
}


- (int) getToken:(NSMutableString *)returnString
{
	int cur_pos = pos;
	NSString *cur_template;
	
	if (pos>=strTemplate.length) {
		return 0;
	}

	if (startStatus == LEX_START_INIT) {
		
		cur_template = [strTemplate substringFromIndex:cur_pos];
		
		int offset;
		int res;
		
		unichar t = [cur_template characterAtIndex:0];
			
		if (res = [self checkAllCommand:t 
						   withTemplate:cur_template]) {
			
			return res;
		}
		
		if (res = [self checkAllName:t 
						withTemplate:cur_template
						  withReturn:returnString]) {
			return res;
		}
		
		offset = [self checkText:cur_template];
		[returnString setString:[cur_template substringToIndex:offset]];
		pos += offset;
		return TEXT;
		
	} else {
		unichar t;
		while (YES) {
			t = [strTemplate characterAtIndex:cur_pos];
			if (t == ' ' || t == '\t' || t == '\n') {
				cur_pos ++;
				pos++;
			} else {
				break;
			}
		}
		
		int res;
		
		cur_template = [strTemplate substringFromIndex:cur_pos];
		
		if (res = [self checkAllCommand:t 
						   withTemplate:cur_template]) {
			
			return res;
		}
		
		if (res = [self checkAllName:t 
						withTemplate:cur_template
						  withReturn:returnString]) {
			return res;
		}
		
		if (t == '(') {
			pos = cur_pos + 1;
			
			return '(';
		}
		
		if (t == ')') {
			pos = cur_pos + 1;
			startStatus = LEX_START_INIT;
			return ')';
		}
		
		if (t == '=') {
			pos = cur_pos + 1;
			return '=';
		}
		
		if (t == '+') {
			pos = cur_pos + 1;
			return '+';
		}
		
		if (t == '-') {
			pos = cur_pos + 1;
			return '-';
		}
		
		if ((t == 'i')||(t == 'I')) {
			unichar k = [strTemplate characterAtIndex:cur_pos+1];
			if ((k == 'n') || (k == 'N')) {
				pos = cur_pos + 2;
				return IN;
			}
		}
		
		if ((t>='0')&&(t<='9')) {
			int end_pos = cur_pos + 1;
			unichar k;
			while (YES) {
				k = [strTemplate characterAtIndex:end_pos];
				if ((k<'0')||(k>'9')) {
					if ((k<'a') || (k>'Z')){
						[returnString setString:[[strTemplate substringToIndex:end_pos] substringFromIndex:cur_pos]];
						
						pos = end_pos;
						
						return NUMBER;
						 
					} else {
						
						break;
					}
				}
				end_pos ++ ;
			}
			
		}
	}
	
	return 0;
}

- (void)dealloc
{
	[strTemplate release];
	[super dealloc];
}

@end
