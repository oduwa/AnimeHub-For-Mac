//
//  DatabaseProxyController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 06/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "DatabaseProxyController.h"
#import "DatabaseViewController.h"

@interface DatabaseProxyController ()

@end

@implementation DatabaseProxyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    
}

- (void) viewWillAppear
{
    [super viewWillAppear];
    
    DatabaseViewController *o = [[DatabaseViewController alloc] initWithNibName:@"DatabaseViewController" bundle:[NSBundle mainBundle]];
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

@end
