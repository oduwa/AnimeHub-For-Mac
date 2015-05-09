//
//  ViewController.h
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 03/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSOutlineViewDataSource, NSOutlineViewDelegate>


@property (weak) IBOutlet NSOutlineView *outlineView;
@property (weak) IBOutlet NSView *containerView;
@property (weak) IBOutlet NSView *containerView2;
@property (weak) IBOutlet NSView *containerView3;
@property (weak) IBOutlet NSView *containerView4;


@end

