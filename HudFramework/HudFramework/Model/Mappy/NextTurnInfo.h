//
//  NextTurnInfo.h
//  HudFramework
//
//  Created by Mr.Robo on 11/5/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NextTurnInfo : NSObject
@property (nonatomic, assign) int code;
@property (nonatomic, assign) int remainDist;
- (instancetype)initCode:(int)code andRemainDist:(int)remainDist;
+ (NextTurnInfo*)info:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
