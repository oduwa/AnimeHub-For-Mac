//
//  DatabaseGridItem.h
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 06/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DatabaseGridItem : NSView

@property (weak) IBOutlet NSImageView *imageView;

@property (weak) IBOutlet NSTextField *textLabel;
@property (weak) IBOutlet NSTextField *indexLabel;

@property (nonatomic, strong) NSString *selectionMarker;

@end
