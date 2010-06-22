    //
//  WidgetViewController.m
//  GaugeCluster
//
//  Created by Jason J. Gullickson on 3/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WidgetViewController.h"

@implementation WidgetViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
	NSLog(@"touchesBegan");
	
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
    
	NSLog(@"touchesMoved");
	
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
    
	NSLog(@"touchesEnded");
	
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
    
	NSLog(@"touchesCancelled");
	
    /*
     To impose as little impact on the device as possible, simply set the placard view's center and transformation to the original values.
     */
	/*
	 placardView.center = self.center;
	 placardView.transform = CGAffineTransformIdentity;
	 */
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
