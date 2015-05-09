//
//  MangaListViewController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 08/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "MangaListViewController.h"
#import "PVAsyncImageView.h"
#import "AppUtils.h"

@interface MangaListViewController (){
    BOOL isSearching;
}

@end

@implementation MangaListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    // iVar Initialization
    self.mangaList = [[NSMutableArray alloc] init];
    self.searchResults = [[NSMutableArray alloc] init];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowSizeStyle = NSTableViewRowSizeStyleCustom;
    
    // Load data
    dispatch_queue_t mangaListQueue = dispatch_queue_create("Manga List Queue",NULL);
    dispatch_async(mangaListQueue, ^{
        [self loadMangaList];
        
        /* Dispatch some work to the main queue */
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            //[activityIndicator stopAnimating];
            [self.tableView reloadData];
        });
    });
    
}

- (void) loadMangaList
{
    //parse out the json data
    NSError* error;
    
    NSString *urlString = [NSString stringWithFormat:@"%@/api/list/0/", [[AppUtils sharedUtils] mangaRootSource]];
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString] options:0 error:&error];
    
    if(!error){
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        self.mangaList = [json objectForKey:@"manga"];
        //NSLog(@"%@", _mangaList);
    }
}


#pragma mark TableView DataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    if(isSearching){
        return [_searchResults count];
    }
    else{
        return [self.mangaList count];
    }
}

- (NSView *) tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if(!isSearching){
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"Cell" owner:self];
        cellView.textField.stringValue = self.mangaList[row][@"a"];
        NSString *imgUrlString = [NSString stringWithFormat:@"https://cdn.mangaeden.com/mangasimg/%@", self.mangaList[row][@"im"]];
        [(PVAsyncImageView *)cellView.imageView downloadImageFromURL:imgUrlString];
        return cellView;
    }
    else{
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"Cell" owner:self];
        cellView.textField.stringValue = self.searchResults[row][@"a"];
        NSString *imgUrlString = [NSString stringWithFormat:@"https://cdn.mangaeden.com/mangasimg/%@", self.searchResults[row][@"im"]];
        [(PVAsyncImageView *)cellView.imageView downloadImageFromURL:imgUrlString];
        return cellView;
    }
    
}


#pragma mark TableView Delegate

- (void) tableViewSelectionDidChange:(NSNotification *)notification
{
    int selectedRowIndex = (int) _tableView.selectedRow;
    if(isSearching){
        NSDictionary *info = _searchResults[selectedRowIndex];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MangaListItemSelectedNotification" object:self userInfo:info];
    }
    else{
        NSDictionary *info = _mangaList[selectedRowIndex];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MangaListItemSelectedNotification" object:self userInfo:info];
    }
}


#pragma mark - IBActions

- (IBAction)searchButtonPressed:(id)sender
{
    if(![_searchField.stringValue isEqualToString:@""]){
        [self.searchResults removeAllObjects];
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"a contains[cd] %@", _searchField.stringValue];
        self.searchResults = [NSMutableArray arrayWithArray: [self.mangaList filteredArrayUsingPredicate:resultPredicate]];
        
        isSearching = YES;
        [self.tableView reloadData];
    }
    else{
        isSearching = NO;
        [self.tableView reloadData];
    }
}


@end
