//
//  GaugeClusterViewController.h
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
#import <UIKit/UIWebView.h>
#import "WidgetStorageClass.h"

#define kFilename	@"archive"
#define kDataKey	@"Data"

@interface GaugeClusterViewController : UIViewController <UIPopoverControllerDelegate> {

	NSMutableArray *widgets;
	int lastWidgetX;
	int lastWidgetY;
	//IBOutlet UITextField *widgetSourceURL;
	//IBOutlet UIButton *arrange;
}
//@property (nonatomic, retain) UITextField *widgetSourceURL;
//@property (nonatomic, retain) UIButton *arrange;
@property (nonatomic, retain) NSMutableArray *widgets;
@property int lastWidgetX;
@property int lastWidgetY;
-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)AddWidget:(WidgetStorageClass *)widget;
//-(IBAction)Arrange:(id)sender;
-(void)SaveData:(NSMutableArray *)widgetData;
-(NSString *)dataFilePath;

@end

