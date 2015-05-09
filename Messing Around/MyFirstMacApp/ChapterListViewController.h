//
//  ChapterListViewController.h
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 08/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ChapterListViewController : NSViewController<NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) NSDictionary *mangaItem;
@property (nonatomic, strong) NSDictionary *mangaInfo;
@property (nonatomic, strong) NSArray *chapterList;


@property (weak) IBOutlet NSTableView *tableView;


@end
