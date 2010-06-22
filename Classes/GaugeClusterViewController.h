//
//  GaugeClusterViewController.h
//  GaugeCluster
//
//  Created by Jason Gullickson on 3/15/10.
//  Copyright the second society 2010. All rights reserved.
//

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

