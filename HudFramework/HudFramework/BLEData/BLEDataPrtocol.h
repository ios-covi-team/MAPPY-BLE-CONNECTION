//
//  BLEDataPrtocol.h
//  SBKApplication
//
//  Created by Covisoft Viet Nam on 6/21/16.
//  Copyright © 2016 Covisoft Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BLEDataPrtocol <NSObject>

/*!
    @discussion received data when ble update the new data
    @param data  data get from
 */
- (void)receiveDataBLE:(NSData *)data;

/*!
    @discussion received data of BLE after get from BLE
    @return NSData data of BLE
 */
- (NSData *)getDataBLE;

- (int)getHeader;
- (int)getID;
- (int)getCommand;
- (int)getFileStartACK;
- (NSString *)getUniqueID;

@end
