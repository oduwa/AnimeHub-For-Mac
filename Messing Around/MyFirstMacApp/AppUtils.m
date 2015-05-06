//
//  AppUtils.m
//  Jive
//
//  Created by Odie Edo-Osagie on 13/06/2014.
//  Copyright (c) 2014 Odie Edo-Osagie. All rights reserved.
//

#import "AppUtils.h"
#import <EventKit/EventKit.h>

static EKEventStore *eventStore = nil;
static AppUtils *globalInstance = nil;

@implementation AppUtils


- (id) init
{
    self = [super init];
    
    if(self){

    }
    
    return self;
}

/**
 *
 *  sharedUtils singleton object
 *
 */
+ (AppUtils *) sharedUtils
{
    @synchronized(self)
    {
        if (!globalInstance)
            globalInstance = [[self alloc] init];
        
        return globalInstance;
    }
    
    return globalInstance;
}





@end
