//
//  ReaderViewController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 15/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "ReaderViewController.h"

@interface ReaderViewController (){
    int currentIndex;
}

@end

@implementation ReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    _imageArray = @[ [NSImage imageNamed:@"NSInfo"],
                     [NSImage imageNamed:@"NSAdvanced"],
                     [NSImage imageNamed:@"NSCaution"]];
    
    /* Set delegate for NSPageControl */
    [_pageController setDelegate:self];
    /* Set arranged objects for NSPageControl */
    [_pageController setArrangedObjects:_imageArray];
    /* Set transition style, in this example we use book style */
    [_pageController setTransitionStyle:NSPageControllerTransitionStyleStackBook];
    
    currentIndex = 0;
}


- (void)pageController:(NSPageController *)pageController didTransitionToObject:(id)object {
    /* When image is changed, update info label's text */
    NSString *info = [NSString stringWithFormat:@"Image %ld/%ld", ([_pageController selectedIndex]+1), [_imageArray count]];
    NSLog(@"%@", info);
}

- (NSString *)pageController:(NSPageController *)pageController identifierForObject:(id)object {
    /* Returns object's array index as identiefier */
    NSString *identifier = [[NSNumber numberWithInteger:[_imageArray indexOfObject:object]] stringValue];
    return identifier;
}

- (NSViewController *)pageController:(NSPageController *)pageController viewControllerForIdentifier:(NSString *)identifier {
    NSString *info = [NSString stringWithFormat:@"Image %ld/%ld", ([_pageController selectedIndex]+1), [_imageArray count]];
    NSLog(@"%@", info);
    
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

- (IBAction)press:(id)sender {
    NSLog(@"JDJDJ");
}
@end
