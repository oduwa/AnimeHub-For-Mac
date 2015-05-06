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
    
    _titleLabel.stringValue = _contentSource[@"english"];
    [_titleLabel sizeToFit];
    
    _descriptionLabel.stringValue = _contentSource[@"description"];
    [_descriptionLabel sizeToFit];
    
    _contentTypeLabel.stringValue = _contentSource[@"type"];
    [_contentTypeLabel sizeToFit];
    
    _episodeCountLabel.stringValue = _contentSource[@"episodes"];
    [_episodeCountLabel sizeToFit];
    
    _statusLabel.stringValue = _contentSource[@"status"];
    [_statusLabel sizeToFit];
    
    _airingLabel.stringValue = [NSString stringWithFormat:@"%@ - %@", _contentSource[@"start_date"], _contentSource[@"end_date"]];
    [_airingLabel sizeToFit];
    
    _imageView.image = [NSImage imageNamed:@"Video_Icon"];
    
    dispatch_queue_t imageDownloadQueue = dispatch_queue_create("Image Download Queue",NULL);
    dispatch_async(imageDownloadQueue, ^{
        NSImage *img = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:_contentSource[@"img"]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(img){
                _imageView.image = img;
            }
        });
    });
}


@end
