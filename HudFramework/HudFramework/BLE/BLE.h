 
//
//  BLE.h
//  SBKApplication
//
//  Created by Covisoft Viet Nam on 6/6/16.
//  Copyright © 2016 Covisoft Viet Nam. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
    #import <CoreBluetooth/CoreBluetooth.h>
#else
    #import <IOBluetooth/IOBluetooth.h>
#endif
#import "BLEData.h"
#import <UIKit/UIKit.h>

@protocol BLEDelegate <NSObject>
@optional


/*!
    @discussion Delegate when have update a new data from BLE device, delegate will call at view controller call it
 */
- (void) notificationDidUpdateData;

/*!
    @discussion Delegate when have App connected with BLE device success delegate will call at view controller call it
 */
- (void) bleDidConnect;

/*!
    @discussion Delegate when have App disconnected with BLE device success delegate will call at view controller call it
 */
- (void) bleDidDisconnect;

/*!
    @discussion Delegate when user turn off bluetooth on iphone, delegate will call at view controller call it
 */
- (void)turnOnBluetoothWithAccessories:(BOOL)ret;

- (void)checkSearchAndConnectAfterChangeStateBLE;

/*!
    @discussion Delegate when search device fisrt time
 */
- (void)didDiscoverPeripheralFirstDevice;

@required


@end

@interface BLE : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate ,CBPeripheralManagerDelegate> {
    
}

/*!
     The delegate object that will receive BLE events
 */
@property (nonatomic,strong) id <BLEDelegate> delegate;

/*!
     List peripherals after serach
 */
@property (strong, nonatomic) NSMutableArray *peripherals;

/*!
    Entry point to the central role. Commands should only be issued when its state is <code>CBCentralManagerStatePoweredOn</code>.
 */
@property (strong,nonatomic) CBCentralManager *CM;

/*!
      Represents a peripheral.
 */
@property (strong, nonatomic) CBPeripheral *activePeripheral;

/*!
 @discussion The <code>CBPeripheralManager</code> class is an abstraction of the Peripheral and Broadcaster GAP roles, and the GATT Server
 *              role. Its primary function is to allow you to manage published services within the GATT database, and to advertise these services
 *              to other devices.
 *              Each application has sandboxed access to the shared GATT database. You can add services to the database by calling {@link addService:};
 *              they can be removed via {@link removeService:} and {@link removeAllServices}, as appropriate. While a service is in the database,
 *              it is visible to and can be accessed by any connected GATT Client. However, applications that have not specified the "bluetooth-peripheral"
 *              background mode will have the contents of their service(s) "disabled" when in the background. Any remote device trying to access
 *              characteristic values or descriptors during this time will receive an error response.
 *              Once you've published services that you want to share, you can ask to advertise their availability and allow other devices to connect
 *              to you by calling {@link startAdvertising:}. Like the GATT database, advertisement is managed at the system level and shared by all
 *              applications. This means that even if you aren't advertising at the moment, someone else might be!

 */
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

/*!
 *
 *	@discussion Used to create a local characteristic, which can be added to the local database via <code>CBPeripheralManager</code>. Once a characteristic
 *				is published, it is cached and can no longer be changed.
 *				If a characteristic value is specified, it will be cached and marked <code>CBCharacteristicPropertyRead</code> and
 *				<code>CBAttributePermissionsReadable</code>. If a characteristic value needs to be writeable, or may change during the lifetime of the
 *				published <code>CBService</code>, it is considered a dynamic value and will be requested on-demand. Dynamic values are identified by a
 *				<i>value</i> of <i>nil</i>.
 *
 */
@property (strong, nonatomic) CBMutableCharacteristic *transferCharacteristic;

/*!
    @discussion Checkd skb device connected in iphone setting, use UUID for check
 */

/*!
    @discussion Enable notification with Peripheral let recevied new data update from device
 */
- (void) enableReadNotification:(CBPeripheral *)p;

/*!
    @discussion Read data send from app
 */
- (void) read;

/*!
    @discussion write data send from app
    @param serviceUUID define by BLE device (current FFF0)
    @param characteristicUUID define by device (current FFF1)
    @param p Peripheral active after connected success
    @param data  data command from app

 */
- (void) writeValue:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID p:(CBPeripheral *)p data:(NSData *)data;

/*!
    @discussion status connect with BLE device
    @return BOOL status connected
 */
- (BOOL) isConnected;
/*!
    @discussion GET LIST DEVICE CONNECT WITH MY IPHONE FOR CHECK RETRYCONNECT */
- (void)getListDeviceConnectingInPhone;

/*!
    @discussion write data send from app
    @param d command for
 */
- (void) write:(NSData *)d;

- (void)writeWithRecivedData:(NSData*)d andBLEData:(BLEData *)bleDt;

/*!
    @discussion init CBCentralManager and list  CBPeripheral for init BLE
 */
- (void) controlSetup;

/*!
    @discussion find BLE device , just find device bluetooth  4.0
    @param timeout timeout for stop find
 */
- (int) findBLEPeripherals:(int) timeout;

/*!
    @discussion connect to BLE device
    @param peripheral after search and selected for connect
 */
- (void) connectPeripheral:(CBPeripheral *)peripheral;


/**
 Connect with local, not connect to ble

 @param peripheral CBPeripheral
 */
/*!
    @discussion in progressing connected , can cancel connect to BLE device
 */
- (void) cancelConnect;

/*!
    @discussion print log status current of BLE device
    @param state after state BLE device
 */
- (const char *) centralManagerStateToString:(int)state;

/*!
    @discussion scan with timer for stop scan
    @param timer timeout stop scan
 */
- (void) scanTimer:(NSTimer *)timer;

/*!
    @discussion print status in progressing search
 */
- (void) printKnownPeripherals;

/*!
    @discussion print detail infor status in progressing search
    @param peripheral connecting
 */
- (void) printPeripheralInfo:(CBPeripheral*)peripheral;

- (void) getAllCharacteristicsFromPeripheral:(CBPeripheral *)p;

- (CBService *) findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p;
- (CBCharacteristic *) findCharacteristicFromUUID:(CBUUID *)UUID andToUUID2:(CBUUID *) UUID2 service:(CBService*)service;
//-(NSString *) NSUUIDToString:(NSUUID *) UUID;
- (NSString *) CBUUIDToString:(CBUUID *) UUID;

- (int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2;
- (int) compareCBUUIDToInt:(CBUUID *) UUID1 UUID2:(UInt16)UUID2;
- (UInt16) CBUUIDToInt:(CBUUID *) UUID;
- (BOOL) UUIDSAreEqual:(NSUUID *)UUID1 UUID2:(NSUUID *)UUID2;
- (void) stopScans;
- (NSArray *)listDevicePairPhone;

@end
