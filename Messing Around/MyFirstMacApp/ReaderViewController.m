//
//  ReaderViewController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 15/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "ReaderViewController.h"
#import "AppUtils.h"

@interface ReaderViewController (){
    int currentIndex;
    int loadCount;
}

@end

@implementation ReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChapterSelectedNotification:) name:@"ChapterSelectedNotification" object:nil];
    
    _imageArray = @[ [NSImage imageNamed:@"NSInfo"],
                     [NSImage imageNamed:@"NSAdvanced"],
                     [NSImage imageNamed:@"NSCaution"]];
    
    /* Set delegate for NSPageControl */
    [_pageController setDelegate:self];
    /* Set arranged objects for NSPageControl */
    [_pageController setArrangedObjects:_imageArray];
    /* Set transition style, in this example we use book style */
    //[_pageController setTransitionStyle:NSPageControllerTransitionStyleStackBook];
    
    currentIndex = 0;
    loadCount = 0;
    
    [AppUtils sharedUtils].readerCont = self;
}


- (void) viewDidAppear
{
    [super viewDidAppear];
    
    if(loadCount == 1){
        NSWindow *thisWindow = [[[NSApplication sharedApplication] windows] lastObject];
        NSToolbar *toolBar = thisWindow.toolbar;
        toolBar.visible = YES;
        
        for(NSToolbarItem *item in toolBar.visibleItems){
            if([item.itemIdentifier isEqualToString:@"leftButton"]){
                [item setAction:@selector(leftReaderToolbarPressed)];
                [item setTarget:[AppUtils sharedUtils].mainCont];
            }
            if([item.itemIdentifier isEqualToString:@"rightButton"]){
                [item setAction:@selector(rightReaderToolbarPressed)];
                [item setTarget:[AppUtils sharedUtils].mainCont];
                NSLog(@"%@", [AppUtils sharedUtils].mainCont);
            }
        }
    }
    
    loadCount++;
}


- (void)pageController:(NSPageController *)pageController didTransitionToObject:(id)object {
    /* When image is changed, update info label's text */
    NSString *info = [NSString stringWithFormat:@"Image %ld/%ld", ([_pageController selectedIndex]+1), [_imageArray count]];
    //NSLog(@"%@", info);
}

- (NSString *)pageController:(NSPageController *)pageController identifierForObject:(id)object {
    /* Returns object's array index as identiefier */
    NSString *identifier = [[NSNumber numberWithInteger:[_imageArray indexOfObject:object]] stringValue];
    NSLog(@"%@", identifier);
    return identifier;
}

- (NSViewController *)pageController:(NSPageController *)pageController viewControllerForIdentifier:(NSString *)identifier {
    NSString *info = [NSString stringWithFormat:@"Image %ld/%ld", ([_pageController selectedIndex]+1), [_imageArray count]];
    //NSLog(@"%@", info);
    
    /* Create new view controller and image view */
    NSViewController *vController = [NSViewController new];
    NSImageView *iView = [[NSImageView alloc] initWithFrame:[_imageView frame]];
    
    /* Get image from image array using identiefier and set image to view */
    [iView setImage:(NSImage *)[_imageArray objectAtIndex:[identifier integerValue]]];
    /* Set image view's frame style to none */
    //[iView setImageFrameStyle:NSImageFrameNone];
    
    /* Add image view to view controller and return view controller */
    [vController setView:iView];
    return vController;
}

- (IBAction)leftButtonPressed:(id)sender {
    if(currentIndex >= 1){
        currentIndex--;
        _pageController.selectedIndex = currentIndex;
    }
}

- (IBAction)rightButtonPressed:(id)sender {
    if(currentIndex < [_imageArray count]-1){
        currentIndex++;
        _pageController.selectedIndex = currentIndex;
    }
}

- (void) handleLeftButtonPressed
{
    if(currentIndex >= 1){
        currentIndex--;
        _pageController.selectedIndex = currentIndex;
    }
}

- (void) handleRightButtonPressed
{
    if(currentIndex < [_imageArray count]-1){
        currentIndex++;
        _pageController.selectedIndex = currentIndex;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseChapterNotification" object:nil];
}

- (void) handleChapterSelectedNotification:(NSNotification *)notification
{
    _chapterId = [notification userInfo][@"chapterId"];
    [self loadDataForChapter];
    
}

- (void) loadDataForChapter
{
    NSError *error;
    NSString *urlString = [NSString stringWithFormat:@"%@/api/chapter/%@/",[[AppUtils sharedUtils] mangaRootSource],  _chapterId];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    self.chapterItems = json[@"images"];
    
    _imageArray = @[ [NSImage imageNamed:@"NSGoLeftTemplate"],
                     [NSImage imageNamed:@"NSGoRightTemplate"],
                     [NSImage imageNamed:@"NSGoLeftTemplate"]];
    
    //_imageArray = nil;
    
    //[_pageController setArrangedObjects:nil];
}

- (IBAction)press:(id)sender {
    NSLog(@"JDJDJ");
}
@end
