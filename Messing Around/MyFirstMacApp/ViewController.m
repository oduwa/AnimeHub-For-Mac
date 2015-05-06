//
//  ViewController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 03/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "DatabaseViewController.h"

@implementation ViewController{
    NSArray *dataSource;
    NSArray *icons;
    NSString *destinationTitle;
    NSString *destinationLink;
    NSArray *containers;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    dataSource = [NSArray arrayWithObjects:@"News", @"Videos", @"Database", nil];
    icons = [NSArray arrayWithObjects:@"news_roll", @"tv_show", @"archive", nil];
    [_outlineView reloadData];
    
    containers = @[_containerView, _containerView2, _containerView3];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleListItemSelectionNotification:) name:@"ListItemSelectedNotification" object:nil];
    
    DatabaseViewController *o = [[DatabaseViewController alloc] initWithNibName:@"DatabaseViewController" bundle:[NSBundle mainBundle]];
}


- (void) viewDidAppear
{
    [super viewDidAppear];
    [_outlineView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


#pragma mark - NSOutlineView Datasource

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    return [dataSource count];
}


- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    return NO;
}


- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    return dataSource[index];
}


- (NSView *)outlineView:(NSOutlineView *)outlineView
     viewForTableColumn:(NSTableColumn *)tableColumn
                   item:(id)item
{
    NSTableCellView *cell = [_outlineView makeViewWithIdentifier:@"DataCell" owner:self];
    cell.textField.stringValue = item;
    
    if([item isEqualToString:@"News"]){
        cell.imageView.image = [self tintImage:[NSColor whiteColor] withImage:[NSImage imageNamed:icons[0]]];
    }
    else if([item isEqualToString:@"Videos"]){
        cell.imageView.image = [self tintImage:[NSColor whiteColor] withImage:[NSImage imageNamed:icons[1]]];
    }
    else if([item isEqualToString:@"Database"]){
        cell.imageView.image = [self tintImage:[NSColor whiteColor] withImage:[NSImage imageNamed:icons[2]]];
    }
    
    
    return cell;
}

#pragma mark - NSOutlineView Delegate

- (void) outlineViewSelectionDidChange:(NSNotification *)notification
{
    NSWindow *mainWindow = [[[NSApplication sharedApplication] windows] objectAtIndex:0];
    
    for(int i = 0; i < [containers count]; i++){
        if(i == [_outlineView selectedRow]){
            [(NSView *)containers[i] setHidden:NO];
            mainWindow.title = [(NSView *)containers[i] identifier];
        }
        else{
            [(NSView *)containers[i] setHidden:YES];
        }
    }
    
}


- (void) handleListItemSelectionNotification:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    
    destinationTitle = info[@"title"];
    destinationLink = info[@"link"];
    
    [self performSegueWithIdentifier:@"showListDetail" sender:self];
}

- (void) prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showListDetail"]){
        NSWindowController *cont = (NSWindowController *)[segue destinationController];
        WebViewController *wvc = (WebViewController *) cont.contentViewController;
        wvc.pageTitle = destinationTitle;
        wvc.link = destinationLink;
    }
}

- (NSImage *)tintImage: (NSColor *)color withImage: (NSImage *)image
{
    if (color) {
        NSImage *icon = image;
        NSSize iconSize = [icon size];
        NSRect iconRect = {NSZeroPoint, iconSize};
        
        [icon lockFocus];
        [[color colorWithAlphaComponent: 1.0] set];
        NSRectFillUsingOperation(iconRect, NSCompositeSourceAtop);
        [icon unlockFocus];
        
        return icon;
    }else{
        return image;
    }
}




@end
