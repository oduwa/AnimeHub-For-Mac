//
//  DatabaseViewController.h
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 06/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DatabaseViewController : NSViewController <NSCollectionViewDelegate, NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (weak) IBOutlet NSCollectionView *collectionView;
@property (strong) IBOutlet NSArrayController *arrayController;
@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSSegmentedControl *segmentedControl;
@property (weak) IBOutlet NSProgressIndicator *activityIndicator;

- (void) clearSelections;
- (void) updateSelections;

- (IBAction)searchButtonPressed:(id)sender;
- (IBAction)segmentControlPressed:(id)sender;

@end
