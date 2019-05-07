 //
//  ProtocolManager.m
//  SBKApplication
//
//  Created by Covisoft Viet Nam on 8/9/16.
//  Copyright © 2016 Covisoft Viet Nam. All rights reserved.
//

#import "ProtocolManager.h"
#import "Util.h"
#import "Constant.h"

@implementation ProtocolManager{
}
- (instancetype)initProtocolManagerWithBLE:(BLE *)theBle{
    self = [super init];
    if (self) {
        _bleData = [[BLEData alloc] init];
        _ble = theBle;
    }
    return self;
}


- (void)sendCommandWithValue:(NSData *)data{
    if (_ble != nil && _ble.isConnected && !_isUnSubmit) {
        [_ble writeWithRecivedData:data andBLEData:_bleData];
    }
}

- (void)bleResetRequest{
    Byte payload[6] = {};
    int offset = 0;
    payload[offset++] = HEADER;
    payload[offset++] = ID;
    payload[offset++] = BLE_RESET_REQUEST;
    payload[offset++] = (Byte) (0xFF & 0); //lenght
    payload[offset++] = (Byte) (0xFF & ([Util sumCRCWithData:[NSData dataWithBytes:payload length:sizeof(payload)]]));
    payload[offset] =  TAIL;
    NSData *dataToSend = [NSData dataWithBytes:payload length:sizeof(payload)];
    [self sendCommandWithValue:dataToSend];
}

#pragma mark - Mappy
- (void)startMappy:(BOOL)isStart{
    Byte payload[7] = {};
    int offset = 0;
    payload[offset++] = HEADER;
    payload[offset++] = ID;
    payload[offset++] = MAPPY_RUNNING;
    payload[offset++] = (Byte) (0xFF & 1); //lenght
    payload[offset++] = (Byte) (0xFF & (isStart ? 0 : 1));
    payload[offset++] = (Byte) (0xFF & ([Util sumCRCWithData:[NSData dataWithBytes:payload length:sizeof(payload)]]));
    payload[offset] =  TAIL;
    NSData *dataToSend = [NSData dataWithBytes:payload length:sizeof(payload)];
    [self sendCommandWithValue:dataToSend];

}

- (void)sendMappyInfo:(MappyModel *)mappy{
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self sendMappyData1:mappy];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self sendMappyData2:mappy];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self sendMappySafeInfo:mappy];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self sendMappyHighWay:mappy];
                });
            });
        });
    });
    
    
    
   
    
    ;

//    [self sendTest];
}

- (void)sendTest{
    Byte payload[9] = {};
    int offset = 0;
    payload[offset++] = HEADER;
    payload[offset++] = ID;
    payload[offset++] = 0x04;
    payload[offset++] = (Byte) (0xFF & 3); //lenght
    payload[offset++] = (Byte) (0xFF & 1);
    payload[offset++] = (Byte) (0xFF & 0);
    payload[offset++] = (Byte) (0xFF & 35);
    payload[offset++] = (Byte) (0xFF & ([Util sumCRCWithData:[NSData dataWithBytes:payload length:sizeof(payload)]]));
    payload[offset] =  TAIL;
    
    NSData *dataToSend = [NSData dataWithBytes:payload length:sizeof(payload)];
    [self sendCommandWithValue:dataToSend];

}

- (void)sendMappyData1:(MappyModel *)data{
    Byte payload[20] = {};
    int offset = 0;
    payload[offset++] = HEADER;
    payload[offset++] = ID;
    payload[offset++] = MAPPY_DATA1;
    payload[offset++] = (Byte) (0xFF & 14); //lenght
    payload[offset++] = (Byte) (0xFF & (data.curTurn.code));
    
    payload[offset++] = (Byte) (0xFF & (data.curTurn.remainDist));
    payload[offset++] = (Byte) (0xFF & (data.curTurn.remainDist >> 8));
    
    payload[offset++] = (Byte) (0xFF & (data.nextTurn.code));
    payload[offset++] = (Byte) (0xFF & (data.nextTurn.remainDist));
    payload[offset++] = (Byte) (0xFF & (data.nextTurn.remainDist >> 8));
    
    payload[offset++] = (Byte) (0xFF & (data.basic.remainDist));
    payload[offset++] = (Byte) (0xFF & (data.basic.remainDist >> 8));
    payload[offset++] = (Byte) (0xFF & (data.basic.remainDist >> 16));
    payload[offset++] = (Byte) (0xFF & (data.basic.remainDist >> 24));

    payload[offset++] = (Byte) (0xFF & (data.basic.remainTime));
    payload[offset++] = (Byte) (0xFF & (data.basic.remainTime >> 8));

    payload[offset++] = (Byte) (0xFF & (data.basic.speed));
    payload[offset++] = (Byte) (0xFF & (data.basic.speed >> 8));
    payload[offset++] = (Byte) (0xFF & ([Util sumCRCWithData:[NSData dataWithBytes:payload length:sizeof(payload)]]));
    payload[offset] =  TAIL;
    
    NSData *dataToSend = [NSData dataWithBytes:payload length:sizeof(payload)];
    [self sendCommandWithValue:dataToSend];


}
- (void)sendMappyData2:(MappyModel *)data{
    Byte payload[11] = {};
    int offset = 0;
    payload[offset++] = HEADER;
    payload[offset++] = ID;
    payload[offset++] = MAPPY_DATA2;
    payload[offset++] = (Byte) (0xFF & 5); //lenght
    payload[offset++] = (Byte) (0xFF & (data.basic.regMode));
    payload[offset++] = (Byte) (0xFF & (data.basic.isRoute ? 1 : 0));
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[Util estimateTimeWithRemainTime:data.basic.remainTime]];
    int timeFormat = ([[Util getTimeFormatWithDate:date]  isEqual: @"AM"] ? AM : PM);
    NSDateComponents *dateComponents  = [Util getDateComponentsWithDate:date];

    payload[offset++] = (Byte) (0xFF & (timeFormat));
    payload[offset++] = (Byte) (0xFF & ([Util convertHour:dateComponents.hour]));
    payload[offset++] = (Byte) (0xFF & (dateComponents.minute));

    payload[offset++] = (Byte) (0xFF & ([Util sumCRCWithData:[NSData dataWithBytes:payload length:sizeof(payload)]]));
    payload[offset] =  TAIL;
    
    NSData *dataToSend = [NSData dataWithBytes:payload length:sizeof(payload)];
    [self sendCommandWithValue:dataToSend];
}

- (void)sendMappySafeInfo:(MappyModel *)data{
    Byte payload[18] = {};
    int offset = 0;
    payload[offset++] = HEADER;
    payload[offset++] = ID;
    payload[offset++] = MAPPY_SAFE;
    payload[offset++] = (Byte) (0xFF & 12); //lenght
    
    payload[offset++] = (Byte) (0xFF & (data.safe.limitSpeed));
    
    payload[offset++] = (Byte) (0xFF & (data.safe.cameraCode));
    
    payload[offset++] = (Byte) (0xFF & (data.safe.remainDist));
    payload[offset++] = (Byte) (0xFF & (data.safe.remainDist >> 8));
    payload[offset++] = (Byte) (0xFF & (data.safe.remainDist >> 16));
    payload[offset++] = (Byte) (0xFF & (data.safe.remainDist >> 24));

    payload[offset++] = (Byte) (0xFF & (data.safe.arvgSpeed));
    payload[offset++] = (Byte) (0xFF & (data.safe.arvgSpeed >> 8));

    payload[offset++] = (Byte) (0xFF & (data.safe.remainTime));
    payload[offset++] = (Byte) (0xFF & (data.safe.remainTime >> 8));

    payload[offset++] = (Byte) (0xFF & (data.safe.overSpeed));

    payload[offset++] = (Byte) (0xFF & (data.safe.safeCode));

    payload[offset++] = (Byte) (0xFF & ([Util sumCRCWithData:[NSData dataWithBytes:payload length:sizeof(payload)]]));
    payload[offset] =  TAIL;
    
    NSData *dataToSend = [NSData dataWithBytes:payload length:sizeof(payload)];
    [self sendCommandWithValue:dataToSend];
}


- (void)sendMappyHighWay:(MappyModel *)data{
    Byte payload[16] = {};
    int offset = 0;
    payload[offset++] = HEADER;
    payload[offset++] = ID;
    payload[offset++] = MAPPY_HIGHWAY;
    payload[offset++] = (Byte) (0xFF & 10); //lenght
    
    
    payload[offset++] = (Byte) (0xFF & (data.highWay.remainDist));
    payload[offset++] = (Byte) (0xFF & (data.highWay.remainDist >> 8));
    payload[offset++] = (Byte) (0xFF & (data.highWay.remainDist >> 16));
    payload[offset++] = (Byte) (0xFF & (data.highWay.remainDist >> 24));
    
    payload[offset++] = (Byte) (0xFF & (data.highWay.fee));
    payload[offset++] = (Byte) (0xFF & (data.highWay.fee >> 8));
    payload[offset++] = (Byte) (0xFF & (data.highWay.fee >> 16));
    payload[offset++] = (Byte) (0xFF & (data.highWay.fee >> 24));
    
    payload[offset++] = (Byte) (0xFF & (data.highWay.speed));
    payload[offset++] = (Byte) (0xFF & (data.highWay.speed >> 8));
    
    payload[offset++] = (Byte) (0xFF & ([Util sumCRCWithData:[NSData dataWithBytes:payload length:sizeof(payload)]]));
    payload[offset] =  TAIL;
    
    NSData *dataToSend = [NSData dataWithBytes:payload length:sizeof(payload)];
    [self sendCommandWithValue:dataToSend];
}

- (void)sendUniqueID{
    Byte payload[6] = {};
    int offset = 0;
    payload[offset++] = HEADER;
    payload[offset++] = ID;
    payload[offset++] = UNIQUE_ID_SET;
    payload[offset++] = (Byte) (0xFF & 0); //lenght
    payload[offset++] = (Byte) (0xFF & ([Util sumCRCWithData:[NSData dataWithBytes:payload length:sizeof(payload)]]));
    payload[offset] =  TAIL;
    NSData *dataToSend = [NSData dataWithBytes:payload length:sizeof(payload)];
    [self sendCommandWithValue:dataToSend];

}
@end
