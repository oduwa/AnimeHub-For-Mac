//
//  ReaderProxyController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 15/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "ReaderProxyController.h"
#import "ReaderViewController.h"

@interface ReaderProxyController ()

@end

@implementation ReaderProxyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChapterSelectedNotification:) name:@"ChapterSelectedNotification" object:nil];
}

- (void) viewWillAppear
{
    [super viewWillAppear];
    
    ReaderViewController *o = [[ReaderViewController alloc] initWithNibName:@"ReaderViewController" bundle:[NSBundle mainBundle]];
    [self.view addSubview:o.view];
    [self addAutoLayoutForProxyChild:o];
}

- (void) addAutoLayoutForProxyChild:(NSViewController *)o
{
    o.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:o.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:o.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:o.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:o.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
}

- (void) handleChapterSelectedNotification:(NSNotification *)notification
{
    ReaderViewController *o = [[ReaderViewController alloc] initWithNibName:@"ReaderViewController" bundle:[NSBundle mainBundle]];
    [self.view addSubview:o.view];
    [self addAutoLayoutForProxyChild:o];
}

@end
