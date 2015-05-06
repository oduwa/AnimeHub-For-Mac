//
//  MostViewedVideoListController.h
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 05/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MostViewedVideoListController : NSViewController <NSXMLParserDelegate, NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;

@end
