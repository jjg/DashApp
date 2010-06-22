//
//  GaugeClusterAppDelegate.h
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

