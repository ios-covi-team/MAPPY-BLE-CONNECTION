//
//  NextTurnInfo.m
//  HudFramework
//
//  Created by Mr.Robo on 11/5/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "NextTurnInfo.h"

@implementation NextTurnInfo
- (instancetype)initCode:(int)code andRemainDist:(int)remainDist{
    self = [super init];
    
    if (self) {
        _code = code;
        _remainDist = remainDist;
    }
    
    return self;
}

+ (NextTurnInfo*)info:(NSDictionary *)dict{
    NextTurnInfo * nextTurn = [[NextTurnInfo alloc] initCode:[dict[@"nextTurnInfo.code"] intValue] andRemainDist:[dict[@"nextTurnInfo.remainDist"] intValue]];

    return nextTurn;
}

@end
