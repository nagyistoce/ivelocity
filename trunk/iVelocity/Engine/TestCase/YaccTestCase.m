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

#import "YaccTestCase.h"
#import "TransLayer.h"

@implementation YaccTestCase

- (void) print:(NSString *)test
{
	NSLog(@"START ----- YaccTestCase %@ ------\n", test);
	
	initLex(test);
	int res = yyparse();
	if (res == 0) {
		printStatements();
	}
	
	NSLog(@"END ----- YaccTestCase %@ ------\n", test);
}

- (void) testParse
{
	[self print:@"<test1>$a.b</test1><test2>#set($a[0]=2)</test2>"];
	[self print:@"<test1>#if(1)<yes>#else<no>#end</test2>"];
	[self print:@"<test3>#foreach($a in $b) $a #end</test3>"];

}

+ (void) test 
{
	YaccTestCase *yaccTestCase = [[YaccTestCase alloc] init];
	
	[yaccTestCase testParse];
	
	[yaccTestCase release];
}


@end
