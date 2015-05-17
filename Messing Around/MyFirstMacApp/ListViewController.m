//
//  ListViewController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 04/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "ListViewController.h"
#import "PVAsyncImageView.h"
#import "WebViewController.h"
#import <ParseOSX/ParseOSX.h>

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    
    // iVar Initialization
    self.feeds = [[NSMutableArray alloc] init];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowSizeStyle = NSTableViewRowSizeStyleCustom;
    
    // Initialize Parse.
    [Parse setApplicationId:@"sZHbbjk7aiDf4RG3vnJch1ZVxsqZDJXZOcmeFVqS" clientKey:@"5cv7jMDGNhIHeYGBrpmKba77xCsqZSYB5fadkpJb"];
    //[Parse setApplicationId:@"s2oejTsg3uB73wDquebMnRYNtNBg1c9UAfAE9djP" clientKey:@"z8kDs6BvNtkNER9YZm583t5eDTtgph0Ryth8YM6s"];
    [self loadDataFromParse];
}

- (void) loadDataFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"Crunchyroll"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // There was an error
        } else {
            for(PFObject *post in objects){
                NSMutableDictionary *anItem = [[NSMutableDictionary alloc] init];
                
                if(post[@"title"] != nil){
                    anItem[@"title"] = post[@"title"];
                }
                else{
                    anItem[@"title"] = @"Oops!";
                }
                if(post[@"link"] != nil){
                    anItem[@"link"] = post[@"link"];
                }
                else{
                    anItem[@"link"] = @"https://sites.google.com/site/animehubapp/home/support";
                }
                if(post[@"description"] != nil){
                    anItem[@"description"] = post[@"description"];
                }
                if(post[@"img"] != nil){
                    anItem[@"img"] = post[@"img"];
                }
                
                /* Making Date */
                if(post[@"pubDate"] != nil){
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"E, d LLL yyyy HH:mm:ss zzz"]; // Thu, 18 Jun 2010 04:48:09 -0700
                    NSDate *date = [dateFormatter dateFromString:[post[@"pubDate"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
                    anItem[@"pubDate"] = date;
                    [anItem setObject:date forKey:@"pubDate"];
                }
                
                
                [_feeds addObject:anItem];
            }
            
            /* Parse 2nd source */
            PFQuery *query = [PFQuery queryWithClassName:@"Haruhichan"];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (error) {
                    // There was an error
                } else {
                    for(PFObject *post in objects){
                        NSMutableDictionary *anItem = [[NSMutableDictionary alloc] init];
                        
                        if(post[@"title"] != nil){
                            anItem[@"title"] = post[@"title"];
                        }
                        else{
                            anItem[@"title"] = @"Oops!";
                        }
                        if(post[@"link"] != nil){
                            anItem[@"link"] = post[@"link"];
                        }
                        else{
                            anItem[@"link"] = @"https://sites.google.com/site/animehubapp/home/support";
                        }
                        if(post[@"description"] != nil){
                            anItem[@"description"] = post[@"description"];
                        }
                        if(post[@"img"] != nil){
                            anItem[@"img"] = post[@"img"];
                        }
                        
                        /* Making Date */
                        if(post[@"pubDate"] != nil){
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateFormat:@"E, d LLL yyyy HH:mm:ss zzz"]; // Thu, 18 Jun 2010 04:48:09 -0700
                            NSDate *date = [dateFormatter dateFromString:[post[@"pubDate"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
                            anItem[@"pubDate"] = date;
                            [anItem setObject:date forKey:@"pubDate"];
                        }
                        
                        
                        [_feeds addObject:anItem];
                    }
                    
                    /* Parse 3rd source */
                    PFQuery *query = [PFQuery queryWithClassName:@"AnimeNation"];
                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        if (error) {
                            // There was an error
                        } else {
                            for(PFObject *post in objects){
                                NSMutableDictionary *anItem = [[NSMutableDictionary alloc] init];
                                
                                if(post[@"title"] != nil){
                                    anItem[@"title"] = post[@"title"];
                                }
                                else{
                                    anItem[@"title"] = @"Oops!";
                                }
                                if(post[@"link"] != nil){
                                    anItem[@"link"] = post[@"link"];
                                }
                                else{
                                    anItem[@"link"] = @"https://sites.google.com/site/animehubapp/home/support";
                                }
                                if(post[@"description"] != nil){
                                    anItem[@"description"] = post[@"description"];
                                }
                                if(post[@"img"] != nil){
                                    anItem[@"img"] = post[@"img"];
                                }
                                
                                /* Making Date */
                                if(post[@"pubDate"] != nil){
                                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                    [dateFormatter setDateFormat:@"E, d LLL yyyy HH:mm:ss zzz"]; // Thu, 18 Jun 2010 04:48:09 -0700
                                    NSDate *date = [dateFormatter dateFromString:[post[@"pubDate"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
                                    anItem[@"pubDate"] = date;
                                    [anItem setObject:date forKey:@"pubDate"];
                                }
                                
                                
                                [_feeds addObject:anItem];
                            }
                            
                            /* Sort feeds */
                            NSSortDescriptor *Sorter = [[NSSortDescriptor alloc] initWithKey:@"pubDate" ascending:NO];
                            [_feeds sortUsingDescriptors:[NSArray arrayWithObject:Sorter]];
                            
                            [self.tableView reloadData];
                        }
                    }];
                }
            }];
            
        }
    }];
}


#pragma mark TableView DataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [_feeds count];
}

- (NSView *) tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"Cell" owner:self];
    cellView.textField.stringValue = _feeds[row][@"title"];
    [(PVAsyncImageView *)cellView.imageView downloadImageFromURL:_feeds[row][@"img"]];
    return cellView;
}


#pragma mark TableView Delegate

- (void) tableViewSelectionDidChange:(NSNotification *)notification
{
    int selectedRowIndex = (int) _tableView.selectedRow;
    NSString *title = _feeds[selectedRowIndex][@"title"];
    NSString *link = _feeds[selectedRowIndex][@"link"];
    

    NSDictionary *info = @{@"title":title, @"link":link};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ListItemSelectedNotification" object:self userInfo:info];
}


@end
