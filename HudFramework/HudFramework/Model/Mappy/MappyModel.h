//
//  MappyModel.h
//  HudFramework
//
//  Created by Mr.Robo on 11/5/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicInfo.h"
#import "CurTurnInfo.h"
#import "NextTurnInfo.h"
#import "SafeInfo.h"
#import "HighWayInfo.h"
@interface MappyModel : NSObject
@property (nonatomic, strong, nonnull) BasicInfo *basic;
@property (nonatomic, strong, nonnull) CurTurnInfo *curTurn;
@property (nonatomic, strong, nonnull) NextTurnInfo *nextTurn;
@property (nonatomic, strong, nonnull) SafeInfo *safe;
@property (nonatomic, strong, nonnull) HighWayInfo *highWay;

- (instancetype)initWithBasic:(nonnull BasicInfo *)basic curTurnInfo:(nonnull CurTurnInfo *)curTurn nextTurn:(nonnull NextTurnInfo *)nextTurn safeInfo:(nonnull SafeInfo *)safe highWayInfo:(HighWayInfo *)highWay;
@end
