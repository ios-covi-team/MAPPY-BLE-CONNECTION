//
//  BLEData.m
//  SBKApplication
//
//  Created by Covisoft Viet Nam on 6/6/16.
//  Copyright © 2016 Covisoft Viet Nam. All rights reserved.
//

#import "BLEData.h"
#import "BLE.h"
@implementation BLEData
// SET TO BLE
{
    NSMutableArray *dataBLE;
    NSData *dataRecevied;
}

- (void)findSKB:(BLE *)ble andData:(id)dataFind{
    
}
//GET FROM BLE
// recevied data from BLE
- (void)receiveDataBLE:(NSData *)data{
    dataRecevied = data;
}
- (NSData *)getDataBLE{
    // HANDLE AT HERE
    return dataRecevied;
}
- (Byte*)byteData{
    Byte *bytes = (Byte *)[dataRecevied bytes];
    return bytes;
}

- (int)getHeader{
    Byte *bytes = [self byteData];
    return  (bytes[0] & 0xFF);
}

- (int)getID{
    Byte *bytes = [self byteData];
    return  (bytes[1] & 0xFF);
}

- (int)getCommand{
    Byte *bytes = [self byteData];
    return  (bytes[2] & 0xFF);
}

- (NSString *)getUniqueID{
    Byte *bytes = [self byteData];
    int id0 = (bytes[4] & 0xFF);
    int id1 = (bytes[5] & 0xFF);
    int id2 = (bytes[6] & 0xFF);
    int id3 = (bytes[7] & 0xFF);
    int id4 = (bytes[8] & 0xFF);
    int id5 = (bytes[9] & 0xFF);
    int id6 = (bytes[10] & 0xFF);
    int id7 = (bytes[11] & 0xFF);
    int id8 = (bytes[12] & 0xFF);
    int id9 = (bytes[13] & 0xFF);
    int id10 = (bytes[14] & 0xFF);
    int id11 = (bytes[15] & 0xFF);
    
    return [NSString stringWithFormat:@"%d.%d.%d.%d.%d.%d.%d.%d.%d.%d.%d.%d",id0,id1,id2,id3,id4,id5,id6,id7,id8,id9,id10,id11];
}
@end
