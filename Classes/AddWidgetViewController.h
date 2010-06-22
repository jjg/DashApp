//
//  AddWidgetViewController.h
//  GaugeCluster
//
//  Created by Jason J. Gullickson on 3/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddWidgetViewController : UIViewController <UIWebViewDelegate>{
	
	IBOutlet UITextField *widgetSourceURL;
	//IBOutlet UIScrollView *widgetBrowser;
	IBOutlet UIWebView *widgetWebBrowser;
	NSMutableArray *appData;
	IBOutlet UIActivityIndicatorView *spinner;
}
@property (nonatomic, retain) UITextField *widgetSourceURL;
//@property (nonatomic, retain) UIScrollView *widgetBrowser;
@property (nonatomic, retain) UIWebView *widgetWebBrowser;
@property (nonatomic, retain) NSMutableArray *appData;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)addWidget:(id)sender;
-(IBAction)cancelAddWidget:(id)sender;
@end
