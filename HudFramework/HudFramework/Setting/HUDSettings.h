//
//  HUDSettings.h
//  HudFramework
//
//  Created by Mr.Robo on 11/1/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface HUDSettings : NSObject

/**
 UUID of BLE item
 */
@property(nonatomic, assign) NSString * bleUUID;
@property(nonatomic, assign) CBPeripheral * cbPeripheral;


/**
 Url of URL Schemes
 */
@property(nonatomic, strong) NSURL * url;

@end
