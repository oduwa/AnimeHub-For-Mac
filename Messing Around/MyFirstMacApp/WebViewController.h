//
//  WebViewController.h
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 04/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface WebViewController : NSViewController 

@property (nonatomic, strong) NSString *pageTitle;
@property (nonatomic, strong) NSString *link;

@property (weak) IBOutlet WebView *webView;
@property (weak) IBOutlet NSProgressIndicator *progressIndicator;

@end
