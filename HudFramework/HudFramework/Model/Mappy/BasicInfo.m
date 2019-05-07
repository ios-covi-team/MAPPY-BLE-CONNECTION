//
//  BasicInfo.m
//  HudFramework
//
//  Created by Mr.Robo on 11/5/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "BasicInfo.h"

@implementation BasicInfo
- (instancetype)initReaminTime:(int)remainTime andRemainDist:(int)remainDist andSpeed:(int)speed andRegCode:(int)regMode andIsRoute:(BOOL)isRoute{
    self = [super init];
    if (self) {
        _remainTime = remainTime;
        _remainDist = remainDist;
        _speed = speed;
        _regMode = regMode;
        _isRoute = isRoute;
    }
    return self;
}

+ (BasicInfo*)info:(NSDictionary *)dict{
    BOOL basicIsRoute = [dict[@"routeInfo.isRoute"] boolValue];
    int isRoute;
    
    if (basicIsRoute) {
        isRoute = 1;
    }else{
        isRoute = 0;
    }
    
   BasicInfo *bs = [[BasicInfo alloc] initReaminTime:[dict[@"basicInfo.remainTime"] intValue] andRemainDist:[dict[@"basicInfo.remainDist"] intValue] andSpeed:[dict[@"basicInfo.speed"] intValue] andRegCode:[dict[@"basicInfo.rgMode"] intValue] andIsRoute:isRoute];
    
    return  bs;
}
@end
