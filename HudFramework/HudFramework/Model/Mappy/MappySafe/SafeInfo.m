//
//  SafeInfo.m
//  HudFramework
//
//  Created by Mr.Robo on 11/5/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "SafeInfo.h"

@implementation SafeInfo
- (instancetype)initLimitSpeed:(int)limitSpeed andCameraCode:(int)cameraCode andRemainDist:(int)remainDist andArvgSpeed:(int)arvgSpeed andRemainTime:(int)remainTime andOverSpeed:(int)overSpeed andSafeCode:(int)safeCode{
    
    self = [super init];
    if (self) {
        _limitSpeed = limitSpeed;
        _cameraCode = cameraCode;
        _remainDist = remainDist;
        _arvgSpeed = arvgSpeed;
        _remainTime = remainTime;
        _overSpeed = overSpeed;
        _safeCode = safeCode;
    }
    
    return self;
}

+ (SafeInfo*)info:(NSDictionary *)dict{
    SafeInfo * safe = [[SafeInfo alloc] initLimitSpeed:[dict[@"safeInfo.limitSpeed"] intValue] andCameraCode:[dict[@"safeInfo.cameraCode"] intValue] andRemainDist:[dict[@"safeInfo.remainDist"] intValue] andArvgSpeed:[dict[@"safeInfo.avrSpeed"] intValue] andRemainTime:[dict[@"safeInfo.remainTime"] intValue] andOverSpeed:[dict[@"safeInfo.overSpeed"] intValue] andSafeCode:[dict[@"safeInfo.safeCode"] intValue]];

    return safe;
}
@end
