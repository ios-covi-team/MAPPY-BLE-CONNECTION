//
//  BLEItem.m
//  HudFramework
//
//  Created by Mr.Robo on 11/2/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "BLEItem.h"

@implementation BLEItem
- (instancetype)initWitUUID:(NSString *)UUID
                               andName:(NSString *)name{
    self = [super init];
    if (self) {
        _UUID = UUID;
        _name = name;
    }
    return self;
}
@end
