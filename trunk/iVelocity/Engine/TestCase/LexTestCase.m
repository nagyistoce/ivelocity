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

#import "LexTestCase.h"
#import "Lex.h"

@implementation LexTestCase

- (void) print:(NSString *)test
{
	NSLog(@"START ----- LexTestCase %@ ------\n", test);
	
	Lex *lex = [[Lex alloc] initWithTemplate:test];
	
	NSMutableString *returnString = [[NSMutableString alloc] init];
	
	while (YES) {
		int token = [lex getToken:returnString];
		
		NSLog(@"%d %@", token, returnString);
		
		if (!token) {
			break;
		}
	}
	
	[returnString release];
	
	NSLog(@"END ----- LexTestCase %@ ------\n", test);
}

- (void) testGetToken
{
	[self print:@"<test1>$a.b</test1><test2>#set($a[0]=2)</test2>"];
	[self print:@"<test1>#if(1)<yes>#else<no>#end</test2>"];
	[self print:@"<test3>#foreach($a in $b) $a #end</test3>"];
}

+ (void) test 
{
	LexTestCase *lexTestCase = [[LexTestCase alloc] init];
	
	[lexTestCase testGetToken];
	
	[lexTestCase release];
}

@end
