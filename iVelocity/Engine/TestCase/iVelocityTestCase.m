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

#import "iVelocityTestCase.h"
#import "JSON.h"
#import "iVelocity.h"

@implementation iVelocityTestCase

- (void) print:(NSString *)test withData:(NSMutableDictionary *)dictionaryData
{
	NSLog(@"START ----- iVelocityTestCase %@ ------\n", test);
	
	iVelocity *velocity = [[iVelocity alloc] initWithTemplate:test withKey:test forceFlush:NO];
	[velocity print];
	
	NSMutableString *strResult = [[NSMutableString alloc] init];
	
	[velocity renderBlockWithData:dictionaryData returnString:strResult];
	
	NSLog(@"%@\n", strResult);
	[strResult release];
	[velocity release];
	
	NSLog(@"END ----- iVelocityTestCase %@ ------\n", test);
}

- (void) testRender
{
	NSMutableDictionary *dictionaryData = [[NSMutableDictionary alloc] init];
	
	[self print:@"<test1>#set($b[0]=1)</test1><test2>#set($b[1]=2)</test2>" 
	   withData:dictionaryData];
	[self print:@"<test3>#if(1)<yes>#else<no>#end</test3>"
	   withData:dictionaryData];
	[self print:@"<test3>#foreach ($a in $b) $a #end</test3>"
	   withData:dictionaryData];
	
	[dictionaryData release];
}

- (void) testRenderHtmlWithJson
{
	iVelocity *velocity = [[iVelocity alloc] initWithFile:@"TestWeb1.html" forceFlush:YES];
	
	[velocity print];
	
	NSString *filePath = [[ [NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestData1.json"];
	
	NSLog(@"%@", filePath);
	
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile: filePath
													 encoding: NSUTF8StringEncoding 
														error: nil];
	NSMutableDictionary *jsonValue = [jsonString JSONValue];
	
	NSMutableString *strResult = [[NSMutableString alloc] init];
	
	[velocity renderBlockWithData:jsonValue 
					  returnString:strResult];
	
	NSLog(@"%@", strResult);
	
	[velocity release];
}

+ (void) test 
{
	iVelocityTestCase *velocityTestCase = [[iVelocityTestCase alloc] init];
	
	[velocityTestCase testRender];
	
	//[velocityTestCase testRenderHtmlWithJson];
	
	[velocityTestCase release];
}


@end
