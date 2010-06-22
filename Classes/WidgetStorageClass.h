//
//  WidgetStorageClass.h
//  GaugeCluster
//
//  Created by Jason J. Gullickson on 3/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WidgetStorageClass : NSObject <NSCoding> {
	float x;
	float y;
	NSString *url;
}
@property float x;
@property float y;
@property (nonatomic, retain) NSString *url;

- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;
@end
