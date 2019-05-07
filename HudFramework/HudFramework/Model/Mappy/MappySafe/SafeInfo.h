//
//  SafeInfo.h
//  HudFramework
//
//  Created by Mr.Robo on 11/5/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SafeInfo : NSObject
@property (nonatomic, assign) int limitSpeed;
@property (nonatomic, assign) int cameraCode;
@property (nonatomic, assign) int remainDist;
@property (nonatomic, assign) int arvgSpeed;
@property (nonatomic, assign) int remainTime;
@property (nonatomic, assign) int overSpeed;
@property (nonatomic, assign) int safeCode;
- (instancetype)initLimitSpeed:(int)limitSpeed andCameraCode:(int)cameraCode andRemainDist:(int)remainDist andArvgSpeed:(int)arvgSpeed andRemainTime:(int)remainTime andOverSpeed:(int)overSpeed andSafeCode:(int)safeCode;

+ (SafeInfo*)info:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
