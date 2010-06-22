    //
//  AddWidgetViewController.m
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

#import "AddWidgetViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation AddWidgetViewController
@synthesize	widgetSourceURL;
//@synthesize widgetBrowser;
@synthesize widgetWebBrowser;
@synthesize appData;
@synthesize spinner;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [spinner stopAnimating];  
    spinner.hidden=TRUE;
    NSLog(@"viewDidFinishLoad went through nicely");
}

- (void)webViewDidStartLoad:(UIWebView *)webView {     
    [spinner startAnimating];     
    spinner.hidden=FALSE;
    NSLog(@"viewDidStartLoad seems to be working");
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	CAGradientLayer *backgroundGradient = [CAGradientLayer layer];
	backgroundGradient.frame = self.view.bounds;
	backgroundGradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor],(id)[[UIColor blackColor] CGColor], nil];
	[self.view.layer insertSublayer:backgroundGradient atIndex:0];
	
	widgetWebBrowser.delegate = self;
	
	//	load web apps web page
	NSMutableURLRequest *appsRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.gullicksonlaboratories.com/storage/webapps.html"]];
	//[widgetRequest setValue: @"iPhone" forHTTPHeaderField: @"User-Agent"];
	
	[widgetWebBrowser loadRequest:appsRequest];
	
	/*
	//	for now, do this by hand;
	//	later, fetch from...somewhere :)
	appData = [[NSMutableArray alloc] initWithCapacity:15];
	
	NSMutableDictionary *appInfo = [[NSMutableDictionary alloc] initWithCapacity:2];
	[appInfo setObject:@"Twitter" forKey:@"title"];
	[appInfo setObject:@"mobile.twitter.com" forKey:@"url"];
	
	[appData addObject:appInfo];
	
	NSMutableDictionary *appInfo2 = [[NSMutableDictionary alloc] initWithCapacity:2];
	[appInfo2 setObject:@"Facebook" forKey:@"title"];
	[appInfo2 setObject:@"touch.facebook.com" forKey:@"url"];
	
	[appData addObject:appInfo2];
	
	NSMutableDictionary *appInfo3 = [[NSMutableDictionary alloc] initWithCapacity:2];
	[appInfo3 setObject:@"LP33 Mobile" forKey:@"title"];
	[appInfo3 setObject:@"m.lp33.tv/" forKey:@"url"];
	
	[appData addObject:appInfo3];
	
	
	NSMutableDictionary *appInfo4 = [[NSMutableDictionary alloc] initWithCapacity:2];
	[appInfo4 setObject:@"Genetic Decoder" forKey:@"title"];
	[appInfo4 setObject:@"www.biocourseware.com/iphone/genecode/index.htm" forKey:@"url"];
	
	[appData addObject:appInfo4];
	
	NSMutableDictionary *appInfo5 = [[NSMutableDictionary alloc] initWithCapacity:2];
	[appInfo5 setObject:@"Checklist" forKey:@"title"];
	[appInfo5 setObject:@"checklist.speedymarks.com/" forKey:@"url"];
	
	[appData addObject:appInfo5];
	
	NSMutableDictionary *appInfo6 = [[NSMutableDictionary alloc] initWithCapacity:2];
	[appInfo6 setObject:@"Genetic Decoder" forKey:@"title"];
	[appInfo6 setObject:@"www.biocourseware.com/iphone/genecode/index.htm" forKey:@"url"];
	
	[appData addObject:appInfo6];
	
	int i = 0;
	int xpos = 30;
	
	for(NSMutableDictionary *tw in appData){
		
		//	load browseable widgets
		UIButton *widgetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[widgetButton setTitle:[tw objectForKey:@"title"] forState:UIControlStateNormal];
		[widgetButton setFrame:CGRectMake(25, xpos, 450, 75)]; 
		[widgetButton setTag:i];
		[widgetButton addTarget:self action:@selector(browserClick:) forControlEvents:UIControlEventTouchUpInside];
		[widgetBrowser addSubview:widgetButton];
		
		i++;
		xpos = xpos + 100;
	}
	*/
}

-(void)browserClick:(id)sender{
	
	UIButton *theButton = sender;
	
	int index = theButton.tag;
	
	NSDictionary *theWidget = [appData objectAtIndex:index];
	
	NSLog(@"button with tag %d", theButton.tag);

	[[NSNotificationCenter defaultCenter] postNotificationName:@"WidgetAddNotification" object:[theWidget objectForKey:@"url"]];
	
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)textFieldDoneEditing:(id)sender{
	[sender resignFirstResponder];
}

-(IBAction)addWidget:(id)sender{
	
	if([widgetSourceURL.text length] > 0){
		NSLog(@"addWidgetViewController addWidget");
	
		[[NSNotificationCenter defaultCenter] postNotificationName:@"WidgetAddNotification" object:widgetSourceURL.text];
	
		[self dismissModalViewControllerAnimated:YES];
	}
}

-(IBAction)cancelAddWidget:(id)sender{
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSMutableURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	
	
	if(navigationType == UIWebViewNavigationTypeLinkClicked) {
		
		
		NSURL *url = request.URL;
		NSString *urlString = url.absoluteString;
		NSLog(@"%@", urlString);
		//return YES;
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"WidgetAddNotification" object:urlString];
		
		[self dismissModalViewControllerAnimated:YES];
	}
	
	return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
