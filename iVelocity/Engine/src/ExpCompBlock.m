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

#import "ExpCompBlock.h"

@implementation ExpCompBlock

- (id) initWithLeft:(id)l 
			 withOp:(COMP_TYPE)t
		  withRight:(id)r
{
	if (self = [super init]) {		
		left = l;
		type = t;
		right = r;
	}
	return self;
}

- (void) print:(NSString *)prompt
{
	NSString *nextPrompt = [[NSString alloc] initWithFormat:@"%@   ", prompt];
	NSLog(@"%@<COMPARE>\n",prompt);
	[left print:nextPrompt];
	switch (type) {
		case COMP_TYPE_DF:
			NSLog(@"!=");
			break;
		case COMP_TYPE_BG:
			NSLog(@">");
			break;
		case COMP_TYPE_BG_EQ:
			NSLog(@">=");
			break;
		case COMP_TYPE_EQ:
			NSLog(@"==");
			break;
		case COMP_TYPE_LT_EQ:
			NSLog(@"<=");
			break;
		case COMP_TYPE_LT:
			NSLog(@"<");
			break;
		default:
			break;
	}
	[right print:nextPrompt];
	NSLog(@"%@</COMPARE>\n",prompt);
	[nextPrompt release];
}

- (ValueType) getValueType
{
	return VALUE_INTEGER;
}

#pragma mark render interface

- (NSInteger) getIntegerValue
{
	ValueType l_type = [left getValueType];
	ValueType r_type = [right getValueType];
	
	if (l_type != r_type) {
		// if type is not equal, return false.
		return 0;
	}
	
	if (l_type == VALUE_INTEGER) {
		int l = [left getIntegerValue];
		int r = [right getIntegerValue];
		int k = 0;
		
		switch (type) {
			case COMP_TYPE_DF:
				k = (l!=r);
				break;
			case COMP_TYPE_BG:
				k = (l>r);
				break;
			case COMP_TYPE_BG_EQ:
				k = (l>=r);
				break;
			case COMP_TYPE_EQ:
				k = (l==r);
				break;
			case COMP_TYPE_LT_EQ:
				k = (l<=r);
				break;
			case COMP_TYPE_LT:
				k = (l<r);
				break;
			default:
				break;
		}
		
		return  k;
		
	} else if (l_type == VALUE_STRING) {
		NSMutableString *l = [[NSMutableString alloc] init];
		NSMutableString *r = [[NSMutableString alloc] init];
		[left getStringValue:l];
		[right getStringValue:r];
		
		int k = [l compare:r]; 
		
		switch (type) {
			case COMP_TYPE_DF:
				if (k != 0) {
					return 1;
				}
				break;
			case COMP_TYPE_BG:
				if (k > 0) {
					return 1;
				}
				break;
			case COMP_TYPE_BG_EQ:
				if (k >= 0) {
					return 1;
				}
				break;
			case COMP_TYPE_EQ:
				if (k == 0) {
					return 1;
				}
				break;
			case COMP_TYPE_LT_EQ:
				if (k <= 0) {
					return 1;
				}
				break;
			case COMP_TYPE_LT:
				if (k < 0) {
					return 1;
				}
				break;
			default:
				break;
		}
		
		return  0;
		
	}
	
	return 0;
}

- (void) getStringValue:(NSMutableString *)strResult
{
}

- (void)dealloc
{
	[super dealloc];
}

@end
