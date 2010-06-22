//
//  WidgetStorageClass.m
//  GaugeCluster
//
//  Created by Jason J. Gullickson on 3/24/10.
//  Copyright Jason Gullickson 2010.
//

/*
 
 This file is part of DashApp.
 
 DashApp is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 DashApp is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with DashApp.  If not, see <http://www.gnu.org/licenses/>.
 
 */

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
