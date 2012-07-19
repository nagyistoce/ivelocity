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

#import <Foundation/Foundation.h>
#import "CoreInterface.h"

typedef enum {
	COMP_TYPE_DF = 0,	// !=
	COMP_TYPE_BG,		// >
	COMP_TYPE_BG_EQ,	// >=
	COMP_TYPE_EQ,		// ==
	COMP_TYPE_LT_EQ,	// <=
	COMP_TYPE_LT		// <
} COMP_TYPE;

@interface ExpCompBlock : NSObject <Expression,Block> {
	
	id			left;
	COMP_TYPE	type;
	id			right;
}

- (id) initWithLeft:(id)l 
			 withOp:(COMP_TYPE)t 
		  withRight:(id)r;

@end
