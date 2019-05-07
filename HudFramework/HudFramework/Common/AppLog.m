//
//  AppLog.m
//  PontusHudFramework
//
//  Created by Mr.Robo on 12/14/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "AppLog.h"

@implementation AppLog
+ (AppLog*)df
{
    
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    // returns the same object each time
    return _sharedObject;
    
    
}

- (void)log:(NSString *)msg{
    if (!_isRelease) {
        NSLog(@"%@",msg);
    }
}

@end
