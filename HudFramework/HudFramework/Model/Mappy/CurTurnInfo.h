//
//  CurTurnInfo.h
//  HudFramework
//
//  Created by Mr.Robo on 11/5/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurTurnInfo : NSObject
@property (nonatomic, assign) int code;
@property (nonatomic, assign) int remainDist;
- (instancetype)initCode:(int)code andRemainDist:(int)remainDist;
+ (CurTurnInfo*)info:(NSDictionary *)dict;

@end
