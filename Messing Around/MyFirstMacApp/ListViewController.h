//
//  ListViewController.h
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 04/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ListViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) NSMutableArray *feeds;

@property (weak) IBOutlet NSTableView *tableView;

@end
