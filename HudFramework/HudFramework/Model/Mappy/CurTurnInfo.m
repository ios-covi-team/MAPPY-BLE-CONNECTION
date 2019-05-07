//
//  CurTurnInfo.m
//  HudFramework
//
//  Created by Mr.Robo on 11/5/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "CurTurnInfo.h"
#import "Constant.h"

@implementation CurTurnInfo
- (instancetype)initCode:(int)code andRemainDist:(int)remainDist{
    self = [super init];
    
    if (self) {
        _code = code;
        _remainDist = remainDist;
    }
    
    return self;
}

+ (CurTurnInfo*)info:(NSDictionary *)dict{ 
    CurTurnInfo * curTurn = [[CurTurnInfo alloc] initCode:[dict[@"curTurnInfo.code"] intValue] andRemainDist:[dict[@"curTurnInfo.remainDist"] intValue]];
    return curTurn;
}

@end
