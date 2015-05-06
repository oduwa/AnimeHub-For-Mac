//
//  AppUtils.h
//  Jive
//
//  Created by Odie Edo-Osagie on 13/06/2014.
//  Copyright (c) 2014 Odie Edo-Osagie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "DatabaseViewController.h"


@interface AppUtils : NSObject

@property (strong, nonatomic) DatabaseViewController *dbCont;

/**
 * Creates a singleton instance of an AppUtils object from which methods and resources can be shraed
 * throughout the application
 *
 * @return AppUtils singleton instance
 */
+ (AppUtils *)sharedUtils;




@end
