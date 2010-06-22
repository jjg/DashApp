//
//  WidgetView.m
//  GaugeCluster
//
//  Created by Jason Gullickson on 3/21/10.
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

#import "WidgetView.h"
#import <QuartzCore/QuartzCore.h>

@implementation WidgetView
@synthesize readyToRemove;
@synthesize sourceURL;
@synthesize targetURL;
@synthesize widgetWebView;
@synthesize spinner;

//BOOL readyToRemove = NO;

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //[spinner stopAnimating];  
    //spinner.hidden=TRUE;
	[self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.25]];
    NSLog(@"viewDidFinishLoad went through nicely");
}

- (void)webViewDidStartLoad:(UIWebView *)webView {     
    //[spinner startAnimating];     
    //spinner.hidden=FALSE;
	[self setBackgroundColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:.50]];
    NSLog(@"viewDidStartLoad seems to be working");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

	NSLog(@"Failed to load web app: %@", [error localizedDescription]);

	if(![[error localizedDescription] isEqualToString:@"Plug-in handled load"]){
		
		//[self removeFromSuperview:widgetWebView];
		[widgetWebView removeFromSuperview];
	
		//[spinner setHidden:YES];
	
		UILabel *errorMessage = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (self.frame.size.width - 20), (self.frame.size.height - 20))];
		[errorMessage setNumberOfLines:0];
		[errorMessage setLineBreakMode:UILineBreakModeWordWrap];
		[errorMessage setAdjustsFontSizeToFitWidth:NO];
		[errorMessage setTextAlignment:UITextAlignmentCenter];
		[errorMessage setBackgroundColor:[UIColor redColor]];
		[errorMessage setTextColor:[UIColor whiteColor]];
		//[errorMessage setShadowColor:[UIColor blackColor]];
		[errorMessage setFont:[UIFont fontWithName:@"Helvetica" size:24]];
		[errorMessage setText:[NSString stringWithFormat:@"Error loading \r\n%@\r\n tap here to close", [self sourceURL]]];
		
		[self addSubview:errorMessage];
		
		[self setReadyToRemove];
		
		//[self bringSubviewToFront:errorMessage];
	}
	
}


- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSMutableURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	
	if(navigationType == UIWebViewNavigationTypeLinkClicked) {
		
		//	if a link is external, 
		//	we want to open it in Safar
		NSURL *sURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://%@", sourceURL]];
		[self setTargetURL:request.URL];
		NSString *sHost = [sURL host];
		NSString *targetHost = [targetURL host];
		
		NSLog(@"attempting to load: %@", targetHost);
		
		if([sHost isEqualToString:targetHost]){
			
			//	move along
			return YES;
			
		} else {
			
			//	warn
			UIAlertView *launchSafariAlert = [[UIAlertView alloc] initWithTitle:@"External Link" message:@"This may be an external link, would you like to open this link in Safari?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
			[launchSafariAlert show];
			
			return YES;
		}

	}
	
	return YES;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if(buttonIndex == 1){
		
		//	launch safari
		[[UIApplication sharedApplication] openURL:[self targetURL]];
	}
}

-(void)loadWidget{
	
	NSURL *widgetMainHTMLURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[self sourceURL]]];
	NSMutableURLRequest *widgetRequest = [NSMutableURLRequest requestWithURL:widgetMainHTMLURL];
	[widgetRequest setValue: @"iPhone" forHTTPHeaderField: @"User-Agent"];
	[self addSubview:widgetWebView];
	[widgetWebView loadRequest:widgetRequest];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	NSLog(@"WidgetView touchesBegan");
	
	UITouch *touch = [touches anyObject];
	
	if (readyToRemove) {
		
		[self remove];
	}
	
	//if ([t locationInView:someViewWeAreInterestedIn])
	[self performSelector:@selector(setReadyToRemove) withObject:nil afterDelay:0.8f];
	//}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WidgetViewTouchedNotification" object:self];
	
	CGPoint beginCenter = self.center;
	
	CGPoint touchPoint = [touch locationInView:self.superview];
	
	deltaX = touchPoint.x - beginCenter.x;
	deltaY = touchPoint.y - beginCenter.y;
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	
	NSLog(@"WidgetView touchesMoved");
	
	[self cancelRemove];
	
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self.superview];
	
	// Set the correct center when touched 
	touchPoint.x -= deltaX;
	touchPoint.y -= deltaY;
	
	self.center = touchPoint;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[self performSelector:@selector(cancelRemove) withObject:nil afterDelay:2];
	//[self cancelRemove];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	[self cancelRemove];
}

-(void)setReadyToRemove{
	readyToRemove = YES;
	[self setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:.50]];
}

-(void)remove{
	[self removeFromSuperview];
}

-(void)cancelRemove{
	readyToRemove = NO;
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setReadyToRemove) object:nil];
	[self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.25]];
}

- (id)initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
	
	float webViewWidth = (self.frame.size.width - 20);
	float webViewHeight = (self.frame.size.height - 20);
	
	widgetWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 10, webViewWidth, webViewHeight)];
	
	/*
	spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	CGPoint spinnerCenter;
	spinnerCenter.x = (self.frame.size.width/2);
	spinnerCenter.y = (self.frame.size.height/2);
	spinner.center = spinnerCenter;
	[widgetWebView addSubview:spinner];
	*/
	
	widgetWebView.delegate = self;
	
	[self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.25]];
	
	//UIImage *backgroundImage = [[UIImage alloc] initWithContentsOfFile:@"DashAppAppBackground.png"];
	//UIView *backgroundView [[UIView alloc] init];
	//backgroundView.backgroundimage
	
	//UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
	//[self addSubview:backgroundImageView];
	//[self bringSubviewToFront:backgroundImageView];
	
	//[self setAlpha:.5];
	
	[self.layer setCornerRadius:5];
	
	self.readyToRemove = NO;
	
	//	tune into notifications
	//NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	//[notificationCenter addObserver:self selector:@selector(cancelRemove) name:@"WidgetsCancelRemove" object:nil];
	
	/*
	CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = self.bounds;
	gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor grayColor] CGColor],(id)[[UIColor blackColor] CGColor], nil];
	//gradient.type = kCAGradientLayer
	[self.layer insertSublayer:gradient atIndex:0];
	*/
	
	//self.layer.cornerRadius = 5;
	
	
    return self;
}

/*
- (void)drawRect:(CGRect)rect {
	
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(15, -20), 5);
	
    [super drawRect: rect];
	
    CGContextRestoreGState(currentContext);
	
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter removeObserver:self];
	
    [super dealloc];
}


@end
