//
//  AddWidgetViewController.h
//  GaugeCluster
//
//  Created by Jason J. Gullickson on 3/22/10.
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
