//
//  PontusHUDManager.h
//  HudFramework
//
//  Created by Mr.Robo on 11/1/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
NS_ASSUME_NONNULL_BEGIN

//! Project version number for HudFramework.
FOUNDATION_EXPORT double HudFrameworkVersionNumber;

//! Project version string for HudFramework.
FOUNDATION_EXPORT const unsigned char HudFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <HudFramework/PublicHeader.h>

@protocol PontusHUDManagerDelegate <NSObject>
@required
/**
 Callback connection status

 @param connected connection status (true, false)
 */
- (void)pontusHudDidUpdateConnection:(BOOL)connected;

@end

@interface PontusHUDManager : NSObject
@property(nonatomic,weak) id<PontusHUDManagerDelegate>delegate;

/**
 BLE connection status
 */
@property(readonly) BOOL isConnected;


/**
 Serial number
 */
@property(readonly) NSString *strSN;

/**
 SingleTone share instance

 @return iself
 */
+ (instancetype)sharedInstance;

/**
 Connect to BLE device
 */
- (void)hudConnect;


/**
 Disconnect to BLE device
 */
- (void)hudDisConnect;

/**
 Update data to hud device

 @param dict include  of data want to update
 */
- (void)hudUpdateRGData:(nonnull NSDictionary *)dict;


/**
 Show log
 @param isON request show log
 */
- (void)setDebugLog:(BOOL)isON;
@end

NS_ASSUME_NONNULL_END
