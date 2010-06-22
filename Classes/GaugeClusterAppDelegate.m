//
//  GaugeClusterAppDelegate.m
//  GaugeCluster
//
//  Created by Jason Gullickson on 3/15/10.
//  Copyright the second society 2010. All rights reserved.
//

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
