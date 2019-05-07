//
//  ProtocolManager.h
//  SBKApplication
//
//  Created by Covisoft Viet Nam on 8/9/16.
//  Copyright © 2016 Covisoft Viet Nam. All rights reserved.
//
#import "ProtocolManagerProtocol.h"
#import "BLE.h"
#import "BLEDefines.h"
@interface ProtocolManager : NSObject <ProtocolManagerProtocol>
- (instancetype)initProtocolManagerWithBLE:(BLE *)theBle;
- (void)startMappy:(BOOL)isStart;
- (void)bleResetRequest;
- (void)sendUniqueID;

@property (nonatomic, strong) BLE *ble;
@property (nonatomic, strong) BLEData *bleData;
@property (nonatomic, assign) BOOL isUnSubmit;

@end
