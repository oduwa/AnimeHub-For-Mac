//
//  DatabaseViewController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 06/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "DatabaseViewController.h"

@interface DatabaseViewController ()

@end

@implementation DatabaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    for(int i = 0; i < 50; i++){
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        d[@"itemTitle"] = [NSString stringWithFormat:@"ITEM %d", i];
        d[@"itemImage"] = [NSImage imageNamed:@"Video_Icon"];
        [_arrayController addObject:d];
    }
}

@end
