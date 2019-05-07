//
//  BasicInfo.h
//  HudFramework
//
//  Created by Mr.Robo on 11/5/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicInfo : NSObject
@property (nonatomic, assign) int remainTime;
@property (nonatomic, assign) int remainDist;
@property (nonatomic, assign) int speed;
@property (nonatomic, assign) int regMode;
@property (nonatomic, assign) BOOL isRoute;
- (instancetype)initReaminTime:(int)remainTime andRemainDist:(int)remainDist andSpeed:(int)speed andRegCode:(int)regMode andIsRoute:(BOOL)isRoute;

+ (BasicInfo *)info:(NSDictionary *)dict;
@end
