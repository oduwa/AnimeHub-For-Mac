//
//  DatabaseCollectionViewItem.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 06/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "DatabaseCollectionViewItem.h"

@interface DatabaseCollectionViewItem ()

@end

@implementation DatabaseCollectionViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (NSView *) hitTest:(NSPoint)aPoint
{
    NSLog(@"P: %f", aPoint.x);
    return (NSView*)self;
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void) mouseDown:(NSEvent *)theEvent
{
    NSLog(@"IM TIRED");
}

@end
