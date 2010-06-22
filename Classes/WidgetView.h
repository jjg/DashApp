//
//  WidgetView.h
//  GaugeCluster
//
//  Created by Jason Gullickson on 3/21/10.
//  Copyright 2010 the second society. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WidgetView : UIView <UIWebViewDelegate, UIAlertViewDelegate>{
	@private float deltaX;
	@private float deltaY;
	bool readyToRemove;
	NSString *sourceURL;
	NSURL *targetURL;
	UIWebView *widgetWebView;
	UIActivityIndicatorView *spinner;
}
@property bool readyToRemove;
@property (nonatomic, retain) NSString *sourceURL;
@property (nonatomic, retain) NSURL *targetURL;
@property (nonatomic, retain) UIWebView *widgetWebView;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
-(void)setReadyToRemove;
-(void)cancelRemove;
-(void)remove;
-(void)loadWidget;
@end
