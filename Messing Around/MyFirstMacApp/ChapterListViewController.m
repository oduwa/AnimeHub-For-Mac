//
//  ChapterListViewController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 08/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "ChapterListViewController.h"
#import "AppUtils.h"
#import "PVAsyncImageView.h"

@interface ChapterListViewController ()

@end

@implementation ChapterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.chapterList = [NSArray array];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowSizeStyle = NSTableViewRowSizeStyleCustom;
}

- (void) viewWillAppear
{
    [self fetchMangaInfo];
}


- (void) fetchMangaInfo
{
    NSError *error;
    NSString *urlString = [NSString stringWithFormat:@"%@/api/manga/%@/",[[AppUtils sharedUtils] mangaRootSource],  _mangaItem[@"i"]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    self.chapterList = json[@"chapters"];
    self.mangaInfo = json;
    
    [self.tableView reloadData];
}

#pragma mark TableView DataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [_chapterList count]+1;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    if(row == 0){
        return 300;
    }
    else{
        return 128;
    }
}

- (NSView *) tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if(row == 0){
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"HeaderCell" owner:self];
        cellView.textField.stringValue = _mangaInfo[@"description"];
        NSString *imgUrlString = [NSString stringWithFormat:@"https://cdn.mangaeden.com/mangasimg/%@", _mangaItem[@"im"]];
        [(PVAsyncImageView *)cellView.imageView downloadImageFromURL:imgUrlString];
        return cellView;
    }
    else{
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"Cell" owner:self];
        cellView.textField.stringValue = _chapterList[row-1][0];
        return cellView;
    }
    
}


#pragma mark TableView Delegate

- (void) tableViewSelectionDidChange:(NSNotification *)notification
{
    
}

@end