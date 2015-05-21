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

@interface ChapterListViewController (){
    BOOL isReaderMode;
}


@end

@implementation ChapterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.chapterList = [NSArray array];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowSizeStyle = NSTableViewRowSizeStyleCustom;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCloseChapterNotification) name:@"CloseChapterNotification" object:nil];
}

- (void) viewWillAppear
{
    [self fetchMangaInfo];
}

- (void) toggleReaderMode
{
    isReaderMode = !isReaderMode;
    
    if(isReaderMode){
        [_tableView reloadData];
        _tableView.hidden = YES;
        _tableView.enabled = NO;
        _containerView.hidden = NO;
    }
    else{
        [_tableView reloadData];
        _tableView.hidden = NO;
        _tableView.enabled = YES;
        _containerView.hidden = YES;
    }
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
    if(!isReaderMode){
        return [_chapterList count]+1;
    }
    else{
        return 0;
    }
    
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
    int row = self.tableView.selectedRow;
    NSDictionary *info = @{@"chapterId" : _chapterList[self.tableView.selectedRow-1][3]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChapterSelectedNotification" object:nil userInfo:info];
    
    BOOL readerWasInstantiated = YES;
    if([AppUtils sharedUtils].readerCont){
//        [AppUtils sharedUtils].readerCont.chapterId = _chapterList[self.tableView.selectedRow-1][3];
//        [[AppUtils sharedUtils].readerCont loadDataForChapter];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChapterSelectedNotification" object:nil userInfo:info];
    }
    else{
        readerWasInstantiated = NO;
    }
    
    [self toggleReaderMode];
    
    if(!readerWasInstantiated){
//        [AppUtils sharedUtils].readerCont.chapterId = _chapterList[row-1][3];
//        [[AppUtils sharedUtils].readerCont loadDataForChapter];
        // TODO: Send notification to container controller to instantiate new contained controller
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChapterSelectedNotification" object:nil userInfo:info];
    }
}

#pragma mark - Selectors

- (void) handleCloseChapterNotification
{
    [self toggleReaderMode];
}

@end
