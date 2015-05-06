//
//  DatabaseViewController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 06/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "DatabaseViewController.h"
#import "GridImageView.h"
#import "DatabaseGridItem.h"
#import "AppUtils.h"

@interface DatabaseViewController (){
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item; // contains a title and a corresponding link
    
    /* Entry fields */
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
    NSMutableString *chapters;
    
    NSString *query;
    
    /* parsing vars */
    NSString *element;
    BOOL gotFirstImage;
    NSString *urlString;
    NSString *queryType;
}

@end

@implementation DatabaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    // iVar initialisation
    feeds = [[NSMutableArray alloc] init];
    queryType = @"anime";
    
    // observe array controller selection
    [_arrayController addObserver:self forKeyPath:@"selectionIndex" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [AppUtils sharedUtils].dbCont = self;
    
}

- (void) searchForTitlesWithName:(NSString *)searchQuery andMediaType:(NSString *)mediaType
{
    [_activityIndicator startAnimation:self];
    [[_arrayController mutableArrayValueForKey:@"content"] removeAllObjects];
    feeds = [[NSMutableArray alloc] init];
    
    searchQuery = [searchQuery stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    urlString = [NSString stringWithFormat:@"http://oduwa:uchiha16@myanimelist.net/api/%@/search.xml?q=%@", mediaType, searchQuery];
    NSLog(@"%@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    parser = [[NSXMLParser alloc] initWithData:[self removeHtmlEntities:urlData]];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    
    
    for(NSDictionary *result in feeds){
        NSMutableDictionary *dataSourceItem = [NSMutableDictionary dictionary];
        dataSourceItem[@"itemTitle"] = result[@"title"];
        dataSourceItem[@"itemImage"] = [NSImage imageNamed:@"Video_Icon"];
        /* Create Queue */
        dispatch_queue_t mangaListQueue = dispatch_queue_create("Manga List Queue",NULL);
        
        /* Dispatch some work to the queue to perform asynchronously */
        dispatch_async(mangaListQueue, ^{
            NSImage *img = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:result[@"img"]]];
            if(img){
                dataSourceItem[@"itemImage"] = img;
            }
        });
        
        [_arrayController addObject:dataSourceItem];
    }
    
   [_activityIndicator stopAnimation:self];
}



#pragma mark - NSXML Delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"entry"]) {
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        score = [[NSMutableString alloc] init];
        type = [[NSMutableString alloc] init];
        status = [[NSMutableString alloc] init];
        startDate = [[NSMutableString alloc] init];
        endDate = [[NSMutableString alloc] init];
        imgURL  = [[NSMutableString alloc] init];
        englishName = [[NSMutableString alloc] init];
        episodes = [[NSMutableString alloc] init];
        chapters = [[NSMutableString alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
        gotFirstImage = NO;
    }
    else if([element isEqualToString:@"score"]) {
        [score appendString:string];
    }
    else if([element isEqualToString:@"type"]) {
        [type appendString:string];
    }
    else if([element isEqualToString:@"status"]) {
        [status appendString:string];
    }
    else if([element isEqualToString:@"start_date"]) {
        [startDate appendString:string];
    }
    else if([element isEqualToString:@"end_date"]) {
        [endDate appendString:string];
    }
    else if([element isEqualToString:@"synopsis"]) {
        [description appendString:string];
    }
    else if([element isEqualToString:@"english"]) {
        [englishName appendString:string];
    }
    else if([element isEqualToString:@"episodes"]) {
        [episodes appendString:string];
    }
    else if([element isEqualToString:@"chapters"]) {
        [chapters appendString:string];
    }
    else if([element isEqualToString:@"image"] && !gotFirstImage){
        [imgURL appendString:string];
        gotFirstImage = YES;
    }
    
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"entry"]) {
        [item setObject:title forKey:@"title"];
        [item setObject:score forKey:@"score"];
        [item setObject:type forKey:@"type"];
        [item setObject:status forKey:@"status"];
        [item setObject:startDate forKey:@"start_date"];
        [item setObject:endDate forKey:@"end_date"];
        [item setObject:description forKey:@"description"];
        [imgURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [item setObject:imgURL forKey:@"img"];
        [item setObject:englishName forKey:@"english"];
        [item setObject:episodes forKey:@"episodes"];
        [item setObject:chapters forKey:@"chapters"];
        [feeds addObject:[item copy]];
    }
    
}


/* Redisplay table if once done parsing */
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    // TODO reload array controller
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSDictionary *userInfo = parseError.userInfo;
    NSNumber *lineNumber   = userInfo[@"NSXMLParserErrorLineNumber"];
    NSNumber *errorColumn  = userInfo[@"NSXMLParserErrorColumn"];
    NSString *errorMessage = userInfo[@"NSXMLParserErrorMessage"];
    
    NSLog(@"Error occured in line %@ and column %@\nWith message: %@", lineNumber, errorColumn, errorMessage);
    
    // TODO reload array controller
}


#pragma mark NSCOllectionView Selection

- (void) updateSelections
{
    int i = 0;
    for(DatabaseGridItem *gridItemView in [_collectionView subviews]){
        if([gridItemView.selectionMarker isEqualToString:@"IS_SELECTED"]){
            _arrayController.selectionIndex = i;
        }
        i++;
    }
}

- (IBAction)searchButtonPressed:(id)sender
{
    if(![_searchField.stringValue isEqualToString:@""]){
        [self searchForTitlesWithName:_searchField.stringValue andMediaType:queryType];
    }
    else{
        [[_arrayController mutableArrayValueForKey:@"content"] removeAllObjects];
        feeds = [[NSMutableArray alloc] init];
    }
    
}

- (IBAction)segmentControlPressed:(id)sender
{
    if(_segmentedControl.selectedSegment == 0){
        queryType = @"anime";
    }
    else if(_segmentedControl.selectedSegment == 1){
        queryType = @"manga";
    }
    else{
        queryType = @"anime";
    }
    
}

- (void) clearSelections
{
    for(DatabaseGridItem *gridItemView in [_collectionView subviews]){
        gridItemView.selectionMarker = @"";
    }
}


#pragma mark - KVO

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"selectionIndex"]){
        //NSLog(@"%d", (int)[_arrayController selectionIndex]);
    }
}


#pragma mark - Helper methods for handling HTML entities within XML file

- (NSData *)removeHtmlEntities:(NSData *)data {
    
    NSString *htmlCode = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    NSMutableString *temp = [NSMutableString stringWithString:htmlCode];
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"&.{0,}?;" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *newString = [regex stringByReplacingMatchesInString:temp options:0 range:NSMakeRange(0, [temp length]) withTemplate:@" "];
    
    NSData *finalData = [newString dataUsingEncoding:NSISOLatin1StringEncoding];
    return finalData;
}

@end

