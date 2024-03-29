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

#import "iVelocityViewController.h"
#import "NameLevelTestCase.h"
#import "LexTestCase.h"
#import "iVelocity.h"
#import "YaccTestCase.h"
#import "iVelocityTestCase.h"
#import "JSON.h"

@implementation iVelocityViewController

@synthesize webView;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {	
	}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//[NameLevelTestCase test];
	//[LexTestCase test];
	//[YaccTestCase test];
	//[iVelocityTestCase test];
	
	/*
	NSString *filePath2 = [[ [NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestWeb1.html"];
	
	iVelocity *velocity = [[iVelocity alloc] initWithFile:@"TestWeb1.html" forceFlush:YES];
	NSString *filePath = [[ [NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestData1.json"];
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile: filePath
														   encoding: NSUTF8StringEncoding 
															  error: nil];
	NSMutableDictionary *jsonValue = [jsonString JSONValue];
	NSMutableString *strResult = [[NSMutableString alloc] init];
	
	[velocity renderBlockWithData:jsonValue 
					  returnString:strResult];
	
	[webView loadHTMLString:strResult baseURL:[NSURL fileURLWithPath:filePath2]];
	
	
	[jsonString release];
	[strResult release];
	[velocity release];
	*/
	
    
    /*
	NSString *filePath2 = [[ [NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestWeb2.html"];
	
	iVelocity *velocity = [[iVelocity alloc] initWithFile:@"TestWeb2.html" forceFlush:YES];
	NSString *filePath = [[ [NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestData2.json"];
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile: filePath
														   encoding: NSUTF8StringEncoding 
															  error: nil];
	NSMutableDictionary *jsonValue = [jsonString JSONValue];
	NSMutableString *strResult = [[NSMutableString alloc] init];
	
	[velocity renderBlockWithData:jsonValue 
					  returnString:strResult];
	
	[webView loadHTMLString:strResult baseURL:[NSURL fileURLWithPath:filePath2]];
	
	
	[jsonString release];
	[strResult release];
	[velocity release];
    */
    
    /*
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
	NSString *filePath2 = [[ [NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestWeb3.html"];
	
	iVelocity *velocity = [[iVelocity alloc] initWithFile:@"TestWeb3.html" forceFlush:YES];
	NSString *filePath = [[ [NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestData3.json"];
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile: filePath
														   encoding: NSUTF8StringEncoding 
															  error: nil];
	NSMutableDictionary *jsonValue = [jsonString JSONValue];
	NSMutableString *strResult = [[NSMutableString alloc] init];
	
	[velocity renderBlockWithData:jsonValue 
					 returnString:strResult];
	
	[webView loadHTMLString:strResult baseURL:[NSURL fileURLWithPath:filePath2]];
	
	[pool release];
    
    
	//! test null
	iVelocity *velocity2 = [[iVelocity alloc] initWithFile:@"TestWeb3.html" forceFlush:NO];

	
	[jsonString release];
	[strResult release];
	[velocity release];
     */
    
    /*
    NSString *filePath2 = [[ [NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestWeb4.html"];
	
	iVelocity *velocity = [[iVelocity alloc] initWithFile:@"TestWeb4.html" forceFlush:YES];
	NSString *filePath = [[ [NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestData4.json"];
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile: filePath
														   encoding: NSUTF8StringEncoding 
															  error: nil];
	NSMutableDictionary *jsonValue = [jsonString JSONValue];
	NSMutableString *strResult = [[NSMutableString alloc] init];
	
	[velocity renderBlockWithData:jsonValue 
                     returnString:strResult];
	
	[webView loadHTMLString:strResult baseURL:[NSURL fileURLWithPath:filePath2]];
	
	
	[jsonString release];
	[strResult release];
	[velocity release];
     */
	
    
    NSString *filePath2 = [[ [NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestWeb5.html"];
	
	//iVelocity *velocity = [[iVelocity alloc] initWithFile:@"TestWeb5.html" forceFlush:YES];
	iVelocity *velocity = [[iVelocity alloc] initWithFile:filePath2 forceFlush:YES];
	
	NSString *filePath = [[ [NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TestData5.json"];
	NSString *jsonString = [[NSString alloc] initWithContentsOfFile: filePath
														   encoding: NSUTF8StringEncoding 
															  error: nil];
	NSMutableDictionary *jsonValue = [jsonString JSONValue];
	NSMutableString *strResult = [[NSMutableString alloc] init];
	
	[velocity renderBlockWithData:jsonValue 
                     returnString:strResult];
	
	[webView loadHTMLString:strResult baseURL:[NSURL fileURLWithPath:filePath2]];
	
	
	[jsonString release];
	[strResult release];
	[velocity release];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[webView release];
    [super dealloc];
}

@end
