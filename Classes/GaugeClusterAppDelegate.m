//
//  GaugeClusterAppDelegate.m
//  GaugeCluster
//
//  Created by Jason Gullickson on 3/15/10.
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

#import "GaugeClusterAppDelegate.h"
#import "GaugeClusterViewController.h"
#import "WidgetView.h"
#import "WidgetStorageClass.h"

@implementation GaugeClusterAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	return YES;
}

-(void)applicationWillTerminate:(UIApplication *)application{
	
	
	NSMutableArray *widgetsToPersist = [[NSMutableArray alloc] initWithCapacity:25];
	
	for(WidgetView *viewInController in viewController.view.subviews){
		
		if([viewInController class] == [WidgetView class]){
			
			/*
			NSMutableDictionary *widget = [[NSMutableDictionary alloc] initWithCapacity:3];
			
			[widget setObject:viewInController.frame.origin.x forKey:@"widgetXpos"];
			[widget setObject:viewInController.frame.origin.y forKey:@"widgetYpos"];
			[widget setObject:viewInController.sourceURL forKey:@"widgetURL"];
			*/
			
			WidgetStorageClass *widget = [WidgetStorageClass alloc];
			
			widget.x = viewInController.frame.origin.x;
			widget.y = viewInController.frame.origin.y;
			widget.url = viewInController.sourceURL;
			
			[widgetsToPersist addObject:widget];
		}
	}
		
	[self SaveData:widgetsToPersist];
	
	//NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//[defaults setObject:widgetsToPersist forKey:@"Widgets"];
	
}

-(void)SaveData:(NSMutableArray *)widgetData {
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	
	[archiver encodeObject:widgetData forKey:kDataKey];
	[archiver finishEncoding];
	[data writeToFile:[self dataFilePath] atomically:YES];
	[archiver release];
	[data release];
}

-(NSString *)dataFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
