//
//  GaugeClusterViewController.m
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

#import "GaugeClusterViewController.h"
#import "WidgetView.h"
#import "AddWidgetViewController.h"
#import "WidgetStorageClass.h"
#import <QuartzCore/QuartzCore.h>

@implementation GaugeClusterViewController

//@synthesize widgetSourceURL;
@synthesize widgets;
@synthesize lastWidgetX;
@synthesize lastWidgetY;

CAGradientLayer *backgroundGradient;

//@synthesize	arrange;

AddWidgetViewController *addWidgetView;
UIPopoverController *popOverController;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{

	//[backgroundGradient removeFromSuperview];
	//backgroundGradient = [CAGradientLayer layer];
	
	backgroundGradient.frame = self.view.bounds;
	
	//backgroundGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor],(id)[[UIColor blackColor] CGColor], nil];
	//gradient.type = kCAGradientLayer
	//[self.view.layer insertSublayer:backgroundGradient atIndex:0];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//	init add widget positions
	[self setLastWidgetX:5];
	[self setLastWidgetY:5];
	
	backgroundGradient = [CAGradientLayer layer];
	backgroundGradient.frame = self.view.bounds;
	backgroundGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor],(id)[[UIColor blackColor] CGColor], nil];
	[self.view.layer insertSublayer:backgroundGradient atIndex:0];
	
	//	load persisted widgets
	//NSMutableArray *savedWidgets = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"Widgets"]];
	
	//savedWidgets = [[NSUserDefaults standardUserDefaults] objectForKey:@"Widgets"];
	
	NSData *data = [[NSData alloc] initWithContentsOfFile:[self dataFilePath]];
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	
	// heres the bug!
	//if(unarchiver) {
	NSMutableArray *savedWidgets = [unarchiver decodeObjectForKey:kDataKey];
	/*
	if([unarchivedList count] > 0) {
		self.listData = unarchivedList;
	}
	else {
		self.listData = [[NSMutableArray alloc]init];
	}
	*/
	[unarchiver finishDecoding];
	
	//}
	//else {
	//self.listData = [[NSMutableArray alloc]init];
	//}
	
	
	[unarchiver release];
	[data release];
	
	
	//NSMutableArray *savedWidgets = [[NSUserDefaults standardUserDefaults] objectForKey:@"Widgets"];
	
	for(WidgetStorageClass *persistedWidget in savedWidgets){
		//[self.view addSubview:persistedWidgets];
		
		[self AddWidget:persistedWidget];
	}
	
	//	init the add view
	addWidgetView = [[AddWidgetViewController alloc] initWithNibName:@"AddWidgetViewController" bundle:nil];
	addWidgetView.contentSizeForViewInPopover = CGSizeMake(500, 150);
	
	//	register notifications
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	
	[notificationCenter
	 addObserver:self 
	 selector:@selector(handle_widgetAdd:) 
	 name:@"WidgetAddNotification" 
	 object:nil];
	
	/*
	[notificationCenter
	 addObserver:self selector:@selector(handle_removeWidget:) name:@"RemoveWidgetNotification" object:nil];
	 */
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
	NSLog(@"touchesBegan");
	
	//	let an widgets know they need
	//	fear deletion no longer
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"WidgetsCancelRemove" object:self];
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"CancelAddWidget" object:self];
	
	//UITouch *touch = [touches anyObject];
	//CGPoint touchPoint = [touch locationInView:self.view];
	
	/*
	UIPopoverController* aPopover = [[UIPopoverController alloc]
									 initWithContentViewController:addWidgetView];
	aPopover.delegate = self;
	popOverController = aPopover;
	[popOverController presentPopoverFromRect:CGRectMake(touchPoint.x, touchPoint.y, 10, 10) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	 */
	
	AddWidgetViewController *addWidgetView = [[AddWidgetViewController alloc] initWithNibName:@"AddWidgetViewController" bundle:nil];
	
	[addWidgetView setModalPresentationStyle:UIModalPresentationFormSheet];
	[self presentModalViewController:addWidgetView animated:YES];
	
	//UITouch *touch = [touches anyObject];
	//CGPoint touchPoint = [touch locationInView:self];
	
	/*
	 // We only support single touches, so anyObject retrieves just that touch from touches
	 UITouch *touch = [touches anyObject];
	 
	 // Only move the placard view if the touch was in the placard view
	 if ([touch view] != placardView) {
	 // In case of a double tap outside the placard view, update the placard's display string
	 if ([touch tapCount] == 2) {
	 [placardView setupNextDisplayString];
	 }
	 return;
	 }
	 // Animate the first touch
	 CGPoint touchPoint = [touch locationInView:self];
	 [self animateFirstTouchAtPoint:touchPoint];
	 */
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
	NSLog(@"GaugeClusterViewController touchesMoved");
	
	
	//UITouch *touch = [touches anyObject];
	//CGPoint location = [touch locationInView:self.view];
	
	//[touch view].center = location;
	
	
	/*
	 UITouch *touch = [touches anyObject];
	 
	 // If the touch was in the placardView, move the placardView to its location
	 if ([touch view] == placardView) {
	 CGPoint location = [touch locationInView:self];
	 placardView.center = location;        
	 return;
	 }
	 */
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
	NSLog(@"GaugeClusterViewController touchesEnded");
	
	/*
	 UITouch *touch = [touches anyObject];
	 
	 // If the touch was in the placardView, bounce it back to the center
	 if ([touch view] == placardView) {
	 // Disable user interaction so subsequent touches don't interfere with animation
	 self.userInteractionEnabled = NO;
	 [self animatePlacardViewToCenter];
	 return;
	 }  
	 */
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
	NSLog(@"GaugeClusterViewController touchesCancelled");
	
    /*
     To impose as little impact on the device as possible, simply set the placard view's center and transformation to the original values.
     */
	/*
	 placardView.center = self.center;
	 placardView.transform = CGAffineTransformIdentity;
	 */
}


-(IBAction)AddWidget:(WidgetStorageClass *)widget{
	
	//	load widget plist
	//NSURL *widgetPlistURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/Info.plist", appURL]];
	//NSDictionary *widgetPlist = [NSDictionary dictionaryWithContentsOfURL:widgetPlistURL];
	
	//NSString *widgetMainHTML = @"";
	float widgetWidth;
	float widgetHeight;
	//NSURL *widgetMainHTMLURL;
	
	/*
	if (widgetPlist) {
	
		//	get widget parameters
		widgetMainHTML = [widgetPlist valueForKey:@"MainHTML"];
		widgetWidth = [[widgetPlist valueForKey:@"Width"] floatValue];
		widgetHeight = [[widgetPlist valueForKey:@"Height"] floatValue];
		
		widgetMainHTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", appURL, widgetMainHTML]];
		
	}else {
	*/	
		//	if it doesn't have a plist,
		//	treat it like a "web app"
	widgetWidth = 320;
	widgetHeight = 480;
		
	
	//	strip the "http://" if necissary
	if([widget.url length] > 7){
		
		NSString *urlSubstring = [widget.url substringToIndex:7];
		
		if([urlSubstring isEqualToString:@"http://"]){
			widget.url = [widget.url substringFromIndex:7];
		}
	
	}
	
	//NSLog(@"protocol stripped url string: %@", widget.url);
	
	//widgetMainHTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",widget.url]];
	//}
	
	//	create webview
	//UIWebView *widgetWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 10, widgetWidth, widgetHeight)];
	//[widgetWebView.layer setCornerRadius:5];
	
	//	load widget into webview
	//NSURLRequest *widgetRequest = [NSURLRequest requestWithURL:widgetMainHTMLURL];
	//NSMutableURLRequest *widgetRequest = [NSMutableURLRequest requestWithURL:widgetMainHTMLURL];
	//[widgetRequest setValue: @"iPhone" forHTTPHeaderField: @"User-Agent"];
	
	//[widgetWebView loadRequest:widgetRequest];
	
	WidgetView *newWidgetView = [[WidgetView alloc] initWithFrame:CGRectMake(widget.x, widget.y, (widgetWidth + 20), (widgetHeight + 20))];
	[newWidgetView setSourceURL:widget.url];
	[newWidgetView loadWidget];
	
	//[newWidgetView addSubview:widgetWebView];
	//[newWidgetView	setAlpha:.5];
	
	//	add widgetview to view
	[self.view addSubview:newWidgetView];
	
	[newWidgetView release];
	
	//	register notifications
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	
	[notificationCenter
	 addObserver:self 
	 selector:@selector(handle_widgetViewTouched:) 
	 name:@"WidgetViewTouchedNotification" 
	 object:newWidgetView];
	
	//	add to collection for persist
	//[widgets addObject:newWidgetView];

}
										 
-(void)handle_widgetViewTouched:(NSNotification *)notification{
	
	WidgetView *theWidgetView = [notification object];
	
	[self.view bringSubviewToFront:theWidgetView];
}

-(void)handle_widgetAdd:(NSNotification *)notification{
	
	NSString *theURL = [notification object];
	
	WidgetStorageClass *widget = [WidgetStorageClass alloc];
	
	widget.url = theURL;

	//int newWidgetX = lastWidgetX;
	//int newWidgetY = lastWidgetY;
	
	if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait){
	
		if((lastWidgetX + 320) >= self.view.frame.size.width){
			
			widget.x = 5;
			
			widget.y = lastWidgetY + 505;
			
		} else {
			widget.x = lastWidgetX;
			widget.y = lastWidgetY;
		}

		
		if((widget.y + 480) >= self.view.frame.size.height){
			widget.y = 5;
		}
		
		lastWidgetX = widget.x + 350;
		lastWidgetY = widget.y;
		
	} else {
		if((lastWidgetX + 320) >= self.view.frame.size.height){
			
			widget.x = 5;
			
			widget.y = lastWidgetY + 505;
			
		} else {
			widget.x = lastWidgetX;
			widget.y = lastWidgetY;
		}
		
		
		if((widget.y + 480) >= self.view.frame.size.width){
			widget.y = 5;
		}
		
		lastWidgetX = widget.x + 350;
		lastWidgetY = widget.y;
	}
	
	[self AddWidget:widget];
	

	

	
	//[popOverController dismissPopoverAnimated:YES];
	
	//[self.view bringSubviewToFront:theWidgetView];
}

/*
-(void)handle_removeWidget:(NSNotification *)notification{
	
	WidgetView *theWidgetView = [notification object];
	
	[theWidgetView removeFromSuperview];
	
	[widgets removeObject:theWidgetView];
}
*/
/*
-(IBAction)Arrange:(id)sender{
	
	if([arrange currentTitle] == @"Arrange"){
		
		//	loop through WidgetViews
		//	and disable interaction
		for(UIView *v in self.view.subviews){
			
			if([v class] == [WidgetView class]){
				
				for(UIView *sv in v.subviews){
					
					[sv setUserInteractionEnabled:NO];
				}
			}
		}
		
		[arrange setTitle:@"Done" forState:UIControlStateNormal];
	}else {
		
		//	loop through WidgetViews
		//	and enable interaction
		for(UIView *v in self.view.subviews){
			
			if([v class] == [WidgetView class]){
				for(UIView *sv in v.subviews){
					
					[sv setUserInteractionEnabled:YES];
				}
			}
		}
		
		[arrange setTitle:@"Arrange" forState:UIControlStateNormal];
	}

	
}
*/

-(IBAction)textFieldDoneEditing:(id)sender{
	[sender resignFirstResponder];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
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

@end
