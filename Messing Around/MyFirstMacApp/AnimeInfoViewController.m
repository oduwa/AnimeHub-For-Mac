//
//  AnimeInfoViewController.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 06/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "AnimeInfoViewController.h"

@interface AnimeInfoViewController ()

@end

@implementation AnimeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    _titleLabel.stringValue = _contentSource[@"title"];
    NSString *englishName = [_contentSource[@"english"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(![englishName isEqualToString:@""]){
        _titleLabel.stringValue = englishName;
    }
    
    _descriptionLabel.stringValue = [self removeHtmlFromString:_contentSource[@"description"]];
    
    _contentTypeLabel.stringValue = _contentSource[@"type"];
    
    if([_contentSource[@"contentType"] isEqualToString:@"manga"]){
        _episodeCountLabel.stringValue = _contentSource[@"chapters"];
        _episodeLabel.stringValue = @"Chapters:";
    }
    else{
        _episodeCountLabel.stringValue = _contentSource[@"episodes"];
    }
    
    
    _statusLabel.stringValue = [NSString stringWithFormat:@"Status: %@", _contentSource[@"status"]];
    
    _airingLabel.stringValue = [NSString stringWithFormat:@"%@ - %@", [_contentSource[@"start_date"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]], _contentSource[@"end_date"]];
    
    _imageView.image = [NSImage imageNamed:@"Video_Icon"];
    [_imageView setImageScaling:NSImageScaleProportionallyUpOrDown];
    
    dispatch_queue_t imageDownloadQueue = dispatch_queue_create("Image Download Queue",NULL);
    dispatch_async(imageDownloadQueue, ^{
        NSImage *img = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:_contentSource[@"img"]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(img){
                _imageView.image = img;
            }
        });
    });
    
    
    // Scroll to top
    NSPoint newScrollOrigin = NSMakePoint(0.0,NSMaxY([[_scrollView documentView] frame]));
    [[self.scrollView contentView] scrollToPoint:newScrollOrigin];
    [self.scrollView reflectScrolledClipView:[self.scrollView contentView]];
}

- (NSString *) removeHtmlFromString:(NSString *)string
{
    NSString *result = @"";
    result = [string stringByReplacingOccurrencesOfString:@"br /" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"div " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"/div" withString:@""];
    return result;
}


@end
