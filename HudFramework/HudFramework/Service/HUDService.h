//
//  HUDService.h
//  HudFramework
//
//  Created by Mr.Robo on 11/2/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLE.h"
#import "BLEItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUDService : NSObject
- (NSMutableArray *)getListDevice:(BLE *)ble;
@end

NS_ASSUME_NONNULL_END
