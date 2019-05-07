//
//  HighWayInfo.m
//  HudFramework
//
//  Created by Mr.Robo on 11/6/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "HighWayInfo.h"
#import "Constant.h"
@implementation HighWayInfo
- (instancetype)initReaminDist:(int)remainDist andFee:(int)fee andSpeed:(int)speed andServiceType:(int)serviceType{
    self = [super init];
    if (self) {
        _remainDist = remainDist;
        _fee = fee;
        _speed = speed;
        _serviceType = serviceType;
    }
    
    return self;
}

+ (HighWayInfo*)info:(NSDictionary *)dict;{
    int serviceType = [dict[@"curHighwayInfo.serviceType"] intValue];
    int remainDist = [dict[@"curTurnInfo.remainDist"] intValue];
    int code = [dict[@"curTurnInfo.code"] intValue];
    int fee = 0;
    if (serviceType == curTurnInfo_SERVICETYPE_TG || (remainDist < REMAIN_DISTANCE_TO_SHOW_TOLL_FEE && code == curTurnInfo_SERVICETYPE_TG)) {
        fee = [dict[@"curHighwayInfo.fee"] intValue];
    }
        
        
        
    HighWayInfo * highWay = [[HighWayInfo alloc] initReaminDist:[dict[@"curHighwayInfo.remainDist"] intValue] andFee:fee andSpeed:[dict[@"curHighwayInfo.speed"] intValue] andServiceType:serviceType];
    return highWay;
}

@end
