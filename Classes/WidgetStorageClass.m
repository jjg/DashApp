//
//  WidgetStorageClass.m
//  GaugeCluster
//
//  Created by Jason J. Gullickson on 3/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WidgetStorageClass.h"


@implementation WidgetStorageClass
@synthesize x;
@synthesize y;
@synthesize url;


- (id)initWithCoder:(NSCoder *)decoder{
	
	if(self = [super init]){
		self.x = [decoder decodeFloatForKey:@"x"];
		self.y = [decoder decodeFloatForKey:@"y"];
		self.url = [decoder decodeObjectForKey:@"url"];
	}
	return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder{
	[encoder encodeFloat:x forKey:@"x"];
	[encoder encodeFloat:y forKey:@"y"];
	[encoder encodeObject:url forKey:@"url"];
}

@end
