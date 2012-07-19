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

#import "StringBlock.h"

@implementation StringBlock

- (id) initWithString:(NSString *)textValue
{
	if (self = [super init]) {
		
		strValue = [[NSMutableString alloc] initWithString:textValue]; 
	}
	return self;
}

- (ValueType) getValueType
{
	return VALUE_STRING;
}

- (void) print:(NSString *)prompt
{
	NSLog(@"%@<STRING>%@</STRING>\n",prompt,strValue);
}

- (NSInteger) getIntegerValue
{
    // check if this is a integer.
    NSScanner* scan = [NSScanner scannerWithString:strValue]; 
    int val; 
    if ([scan scanInt:&val] && [scan isAtEnd] ) {
        return val;
    } else {
        return 0;
    }
}

- (void) getStringValue:(NSMutableString *)strResult
{
	[strResult setString:strValue];
}

- (void)dealloc
{
    [strValue release];
	[super dealloc];
}

@end
