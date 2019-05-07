//
//  HUDManager.m
//  HudFramework
//
//  Created by Mr.Robo on 11/1/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "PontusHUDManager.h"
#import "BLE.h"
#import "Constant.h"
#import "HUDService.h"
#import "DefinePublic.h"
#import "ProtocolManager.h"
#import "Util.h"
#import "HUDSettings.h"
#import "MappyModel.h"
#import "AppLog.h"

@interface PontusHUDManager()<BLEDelegate>
@property(nonatomic, assign) BOOL isStopSearch;
@property(nonatomic, assign) BOOL isSearching;
@property(nonatomic, assign) float timeWait;
@property(nonatomic, strong) HUDSettings *hudSettings;
@property(nonatomic, assign) NSTimer *timeOutConnection;

@end

@implementation PontusHUDManager{
    BOOL isReconnection;
    __block BOOL isStartMappy;
    __block BOOL isDebugLog;
    NSString *serriNumber;

}

__strong static BLE *ble;
__strong static HUDService * service;
__strong static ProtocolManager *protocolM;

extern const struct MappyKeyReadable MappyKey;

+ (PontusHUDManager*) sharedInstance
{
    
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;

    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
        ble = [[BLE alloc] init];
        [ble controlSetup];
        service = [[HUDService alloc] init];
        protocolM = [[ProtocolManager alloc] initProtocolManagerWithBLE:ble];
    });
    // returns the same object each time
    return _sharedObject;
    
    
}

- (NSString*)strSN{
    return [self isConnected] ? serriNumber : @"";
}

- (BOOL)isConnected{
    return ble.isConnected;
}

- (void)terminateApp{
    [self hudStopMappy];
}

- (void)checkUnSubmitData{
    if ([protocolM.bleData getCommand] == UPDATE_FILE_START_ACK_RESPONSE) {
        protocolM.isUnSubmit = true;
    }else if ([protocolM.bleData getCommand] == UPDATE_FILE_END_ACK_RESPONSE){
        protocolM.isUnSubmit = false;
    }
}

- (void)setDelegate:(id<PontusHUDManagerDelegate>)delegate{
    _delegate = delegate;
    ble.delegate = self;
    isReconnection = true;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminateApp) name:UIApplicationWillTerminateNotification object:nil];

}


- (void)hudUpdateRGData:(NSDictionary *)dict{
    [[AppLog df] log:[NSString stringWithFormat:@"%s",__func__]];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self->isStartMappy) {
            self->isStartMappy = true;
            [[PontusHUDManager sharedInstance] hudStartMappy];
        }
        BasicInfo * basic = [BasicInfo info:dict];
        
        CurTurnInfo * curTurn = [CurTurnInfo info:dict];
        
        NextTurnInfo * nextTurn = [NextTurnInfo info:dict];
        
        SafeInfo * safe = [SafeInfo info:dict];
        
        HighWayInfo * highWay = [HighWayInfo info:dict];
        
        MappyModel * mappy = [[MappyModel alloc] initWithBasic:basic curTurnInfo:curTurn nextTurn:nextTurn safeInfo:safe highWayInfo:highWay];
        
        [protocolM sendMappyInfo:mappy];
    });
}

- (void)hudConnect{
    if (![self isConnected]) {
        [[AppLog df] log:[NSString stringWithFormat:@"%s",__func__]];

        if (self.hudSettings.cbPeripheral){
            [[AppLog df] log:@"cbPeripheral"];
            
            [ble connectPeripheral:self.hudSettings.cbPeripheral];
            self.timeOutConnection = [NSTimer scheduledTimerWithTimeInterval:TIME_OUT_CONNECTION target:self selector:@selector(hudReconnection) userInfo:nil repeats:NO];
        }else{
            // in case mappy
            NSArray *listDeviceConnected = [ble listDevicePairPhone];
            if (listDeviceConnected.count > 0) {
                for (CBPeripheral * retryCBPeripheral in listDeviceConnected) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [ble connectPeripheral:retryCBPeripheral];
                        self.timeOutConnection = [NSTimer scheduledTimerWithTimeInterval:TIME_OUT_CONNECTION target:self selector:@selector(hudReconnection) userInfo:nil repeats:NO];
                    });
                    break;
                }
            }else{
                // recheck the list BLE connected in the iphone
//                [self performSelector:@selector(hudConnect) withObject:nil afterDelay:5.0];
            }
            
            
        }
        
    }
}

- (void)hudDisConnect{
//    isReconnection = isReconnect;
    [ble cancelConnect];
}

- (void)hudReconnection{
    [self.timeOutConnection invalidate];
    self.timeOutConnection = nil;
    if (isReconnection) {
        [self hudConnect];
    }
}

- (void)hudStopMappy{
    [protocolM startMappy:false];
}

- (void)hudStartMappy{
    [protocolM startMappy:true];
}

#pragma mark - BLEDelegate

- (void)bleDidConnect{
    [[AppLog df] log:@"- bleDidConnect"];
    [self.timeOutConnection invalidate];
    self.timeOutConnection = nil;
    protocolM.ble = ble;
    protocolM.isUnSubmit = false;
    [self checkUniqueIDAvailable];
 
}


- (void)bleDidDisconnect{
    [[AppLog df] log:@"%@ - bleDidDisconnect"];
    
    isStartMappy = false;
    serriNumber = nil;
    protocolM.ble = ble;
    if ([_delegate respondsToSelector:@selector(pontusHudDidUpdateConnection:)]) {
        [_delegate pontusHudDidUpdateConnection:false];
    }
}

- (void)turnOnBluetoothWithAccessories:(BOOL)ret{
    if (!ret) {
        [self bleDidDisconnect];
    }
}

- (void)notificationDidUpdateData{
    [[AppLog df] log:[NSString stringWithFormat:@"%@",[protocolM.bleData getDataBLE]]];

    if ([protocolM.bleData getDataBLE].length > 0) {
//        [self checkUnSubmitData];
        int command = [protocolM.bleData getCommand];
        switch (command) {
            case UNIQUE_ID_GET:
                serriNumber = [protocolM.bleData getUniqueID];
                if ([_delegate respondsToSelector:@selector(pontusHudDidUpdateConnection:)]) {
                    [_delegate pontusHudDidUpdateConnection:true];
                }
                break;
                
            default:
                break;
        }
       // [_delegate pontusHudNotificationDidUpdateData:[protocolM.bleData getDataBLE]];
    }
}

- (void)checkUniqueIDAvailable{
    if (serriNumber) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(checkUniqueIDAvailable) object:nil];
    }else{
        [protocolM sendUniqueID];
        [self performSelector:@selector(checkUniqueIDAvailable) withObject:nil afterDelay:0.2];
    }
}

- (void)setDebugLog:(BOOL)isON{
    isDebugLog = isON;
    AppLog.df.isRelease = !isDebugLog;
}

@end
