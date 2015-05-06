//
//  AnimeInfoViewController.h
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 06/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AnimeInfoViewController : NSViewController

@property (nonatomic, strong) NSDictionary *contentSource;

@property (weak) IBOutlet NSTextField *descriptionLabel;
@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSTextField *contentTypeLabel;
@property (weak) IBOutlet NSTextField *episodeCountLabel;
@property (weak) IBOutlet NSTextField *statusLabel;
@property (weak) IBOutlet NSTextField *airingLabel;
@property (weak) IBOutlet NSImageView *imageView;

@end
