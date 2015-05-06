//
//  GridImageView.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 06/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "GridImageView.h"

@implementation GridImageView

- (id) initWithImageNamed:(NSString *)imageName
{
    self = [super init];
    
    if(!self){
        self.image = [NSImage imageNamed:imageName];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void) mouseDown:(NSEvent *)theEvent
{
    NSLog(@"MAWS DAWN");
}

@end
