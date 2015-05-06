//
//  DatabaseGridItem.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 06/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "DatabaseGridItem.h"
#import "AppUtils.h"

@implementation DatabaseGridItem

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (BOOL)acceptsFirstResponder {
    return NO;
}

- (void) mouseDown:(NSEvent *)theEvent
{
    //[super mouseDown:theEvent];
    //NSLog(@"MAWWWS DAWN %@", self.imageView);
    [[AppUtils sharedUtils].dbCont clearSelections];
    _selectionMarker = @"IS_SELECTED";
    [[AppUtils sharedUtils].dbCont updateSelections];
    //NSLog(@"%@", [AppUtils sharedUtils].dbCont.arrayController);
}

@end
