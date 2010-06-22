//
//  GaugeClusterAppDelegate.h
//  GaugeCluster
//
//  Created by Jason Gullickson on 3/15/10.
//  Copyright the second society 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kFilename	@"archive"
#define kDataKey	@"Data"

@class GaugeClusterViewController;

@interface GaugeClusterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GaugeClusterViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GaugeClusterViewController *viewController;
-(void)SaveData:(NSMutableArray *)widgetData;
-(NSString *)dataFilePath;

@end

