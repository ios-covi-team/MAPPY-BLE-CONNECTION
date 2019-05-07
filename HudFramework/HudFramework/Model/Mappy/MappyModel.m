//
//  MappyModel.m
//  HudFramework
//
//  Created by Mr.Robo on 11/5/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "MappyModel.h"

@implementation MappyModel
- (instancetype)initWithBasic:(BasicInfo *)basic curTurnInfo:(CurTurnInfo *)curTurn nextTurn:(NextTurnInfo *)nextTurn safeInfo:(SafeInfo *)safe highWayInfo:(HighWayInfo *)highWay{
    self = [super init];
    if (self) {
        _basic = basic;
        _curTurn = curTurn;
        _nextTurn = nextTurn;
        _safe = safe;
        _highWay = highWay;
    }
    return  self;
}

@end

