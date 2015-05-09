//
//  MangaListViewController.h
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 08/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MangaListViewController : NSViewController<NSTableViewDataSource, NSTableViewDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableArray *mangaList;
@property (nonatomic, strong) NSMutableArray *searchResults;

@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSSearchField *searchField;

- (IBAction)searchButtonPressed:(id)sender;


@end
