//
//  AppLog.h
//  PontusHudFramework
//
//  Created by Mr.Robo on 12/14/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AppLog : NSObject
+ (AppLog*)df;
@property (nonatomic) BOOL isRelease;
- (void)log:(NSString *)msg;

@end
