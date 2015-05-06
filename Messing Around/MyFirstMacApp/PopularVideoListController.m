//
//  PopularVideoListController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 05/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "PopularVideoListController.h"
#import "WebViewController.h"


@interface PopularVideoListController (){
    NSXMLParser *parser;
    NSMutableArray *feeds;
    
    /* Entry fields */
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *description;
    NSMutableString *score;
    NSMutableString *type;
    NSMutableString *status;
    NSMutableString *startDate;
    NSMutableString *endDate;
    NSMutableString *imgURL;
    NSMutableString *englishName;
    NSMutableString *episodes;
    
    NSString *element;
}

@end

@implementation PopularVideoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://www.nwanime.com/rss/comments"];
    
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}


#pragma mark - NSXML Delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
    }
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }
    else if([element isEqualToString:@"description"]) {
        [description appendString:string];
    }
    else if([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:description forKey:@"description"];
        [feeds addObject:[item copy]];
    }
    
}


/* Redisplay table if once done parsing */
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.tableView reloadData];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSDictionary *userInfo = parseError.userInfo;
    
    NSNumber *lineNumber   = userInfo[@"NSXMLParserErrorLineNumber"];
    NSNumber *errorColumn  = userInfo[@"NSXMLParserErrorColumn"];
    NSString *errorMessage = userInfo[@"NSXMLParserErrorMessage"];
    
    NSLog(@"Error occured in line %@ and column %@\nWith message: %@", lineNumber, errorColumn, errorMessage);
    
    [self.tableView reloadData];
    
}


#pragma mark TableView DataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [feeds count];
}

- (NSView *) tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"Cell" owner:self];
    cellView.textField.stringValue = feeds[row][@"title"];
    [cellView.imageView setImage:[NSImage imageNamed:@"Video_Icon"]];
    return cellView;
}


#pragma mark TableView Delegate

- (void) tableViewSelectionDidChange:(NSNotification *)notification
{
    int selectedRowIndex = (int) _tableView.selectedRow;
    NSString *videoTitle = feeds[selectedRowIndex][@"title"];
    NSString *videoLlink = feeds[selectedRowIndex][@"link"];
    
    WebViewController *wvc = [self.storyboard instantiateControllerWithIdentifier:@"webViewController"];
    wvc.pageTitle = videoTitle;
    wvc.link = videoLlink;
    
    NSDictionary *info = @{@"title":videoTitle, @"link":videoLlink};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ListItemSelectedNotification" object:self userInfo:info];
}

@end
