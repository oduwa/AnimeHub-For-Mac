//
//  WebViewController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 04/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.title = _pageTitle;
    
    _webView.frameLoadDelegate = self;
}

- (void) viewWillAppear
{
    [super viewWillAppear];
    
    NSURL *myURL = [NSURL URLWithString: [self.link stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    [[self.webView mainFrame] loadRequest:request];
    
    /* Make this controllers window the same size as main window */
    NSWindow *mainWindow = [[[NSApplication sharedApplication] windows] objectAtIndex:0];
    NSWindow *thisWindow = [[[NSApplication sharedApplication] windows] lastObject];
    if(mainWindow.frame.origin.x <= 10 || mainWindow.frame.origin.y <= 10){
        [thisWindow setFrame:mainWindow.frame display:YES animate:YES];
    }
    else{
        CGRect frame = CGRectMake(thisWindow.frame.origin.x, thisWindow.frame.origin.y, mainWindow.frame.size.width, mainWindow.frame.size.height);
        [thisWindow setFrame:frame display:YES animate:YES];
    }
    thisWindow.title = _pageTitle;
    
    
    
    /* Set back button functionality */
    NSToolbar *toolBar = thisWindow.toolbar;
    for(NSToolbarItem *item in toolBar.visibleItems){
        if([item.itemIdentifier isEqualToString:@"backToolBarItem"]){
            [item setAction:@selector(backButtonPressed)];
        }
    }
    
}


#pragma mark WebFrameLoad Delegate

- (void) webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
    [_progressIndicator startAnimation:self];
}

- (void) webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    [_progressIndicator stopAnimation:self];
}

#pragma mark - Selectors

- (void) backButtonPressed
{
    [_webView goBack];
}

@end
