//
//  Constant.h
//  HudFramework
//
//  Created by Mr.Robo on 11/2/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//
#import "DefinePublic.h"

#ifndef Constant_h
#define Constant_h
#define App @"HUD-LIB"
#define MAXIMUM_SEARCH  30
#define MINIUM_SEARCH 3
#define TIME_WAITING  4
#define TIME_OUT_CONNECTION  10
#define curTurnInfo_SERVICETYPE_TG 50
#define REMAIN_DISTANCE_TO_SHOW_TOLL_FEE 5000

//const struct MappyKeyReadable MappyKey = {
//    .CUR_TURN_INFO = @"event.curTurnInfo.code",
//    .NEXT_TURN_INFO = @"event.nextTurnInfo.code",
//    .BASIC_REMAIN_DIST = @"event.basicInfo.remainDist",
//    .BASIC_SPEED = @"event.basicInfo.speed",
//    .BASIC_RG_MODE = @"event.basicInfo.rgMode",
//    .BASIC_ESTIMATE_TIME = @"event.basicInfo.caculate.estimatedtime",
//    .SAFE_LIMIT_SPEED = @"event.safeInfo.limitSpeed",
//    .SAFE_REMAIN_DIST = @"event.safeInfo.remainDist",
//    .SAFE_AVR_SPEED = @"event.safeInfo.avrSpeed",
//    .BASIC_REMAIN_TIME = @"event.safeInfo.remainTime",
//    .SAFE_OVER_SPEED = @"event.safeInfo.overSpeed",
//    .SAFE_SAFECODE = @"event.safeInfo.safeCode",
//    .CUR_HIGH_WAY_INFO_REMAIN_DIST = @"event.curHighwayInfo.remainDist",
//    .CUR_HIGH_WAY_INFO_FEE = @"event.curHighwayInfo.fee",
//    .CUR_HIGH_WAY_INFO_SPEED = @"event.curHighwayInfo.speed",
//};


enum TIME_FORMAT{
    AM = 0,
    PM,
};
#endif /* Constant_h */
