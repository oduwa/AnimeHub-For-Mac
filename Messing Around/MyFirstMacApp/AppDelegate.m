//
//  AppDelegate.m
//  MyFirstMacApp
//
//  Created by Odie Edo-Osagie on 03/05/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

#import "AppDelegate.h"
#import <ParseOSX/ParseOSX.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    // Initialize Parse.
    //[Parse setApplicationId:@"sZHbbjk7aiDf4RG3vnJch1ZVxsqZDJXZOcmeFVqS" clientKey:@"5cv7jMDGNhIHeYGBrpmKba77xCsqZSYB5fadkpJb"];
    [Parse setApplicationId:@"s2oejTsg3uB73wDquebMnRYNtNBg1c9UAfAE9djP"
                  clientKey:@"z8kDs6BvNtkNER9YZm583t5eDTtgph0Ryth8YM6s"];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
