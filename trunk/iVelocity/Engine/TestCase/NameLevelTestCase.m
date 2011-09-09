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

#import "NameLevelTestCase.h"
#import "NameLevel.h"


@implementation NameLevelTestCase

- (void) print:(NSString *)test
{
	@try {
		NSLog(@"START ----- NameLevelTestCase %@ ------", test);
		
		NameLevel *level = [[NameLevel alloc] initWithName:test 
												  withPath:PATH_LEVEL_KEY];
		
		[level print:@"#"];
		
		[level release];
		
		NSLog(@"END ----- NameLevelTestCase %@ ------", test);
	}
	@catch (NSException * e) {
		NSLog (@"Caught %@%@", [e name], [e reason]);
	}	
}

- (void) testNameInit
{
	[self print:@"a.b"];
	
	[self print:@"a[2]"];
	
	[self print:@"a[2].b"];
	
	[self print:@"a[2][2]"];
	
	[self print:@"a[2].b[2]"];
}

+ (void) test 
{
	NameLevelTestCase *nameLevelTestCase = [[NameLevelTestCase alloc] init];
	
	[nameLevelTestCase testNameInit];
	
	[nameLevelTestCase release];
}

@end
