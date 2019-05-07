//
//  BLEItem.h
//  HudFramework
//
//  Created by Mr.Robo on 11/2/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLEItem : NSObject
@property (nonatomic, readwrite)  NSString *UUID , *name;
- (instancetype)initWitUUID:(NSString *)UUID
                               andName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
