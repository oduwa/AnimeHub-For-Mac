//
//  ReaderViewController.h
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 15/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ReaderViewController : NSViewController <NSPageControllerDelegate>

@property (nonatomic, strong) NSString *chapterId;
@property (nonatomic, strong) NSArray *chapterItems;

@property (strong) IBOutlet NSPageController *pageController;
@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSImageView *imageView;

@property (nonatomic) NSArray *imageArray;



- (IBAction)leftButtonPressed:(id)sender;
- (IBAction)rightButtonPressed:(id)sender;
- (IBAction)press:(id)sender;

- (void) handleLeftButtonPressed;
- (void) handleRightButtonPressed;

- (void) loadDataForChapter;

@end
