//
//  HUDService.m
//  HudFramework
//
//  Created by Mr.Robo on 11/2/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "HUDService.h"
@implementation HUDService
- (NSMutableArray *)getListDevice:(BLE *)ble {
    NSMutableArray *arrray = [[NSMutableArray alloc] init];
    if (ble.peripherals.count > 0)
    {
        int i;
        for (i = 0; i < ble.peripherals.count; i++)
        {
            CBPeripheral *p = [ble.peripherals objectAtIndex:i];
            NSString *name = [[ble.peripherals objectAtIndex:i] name];
            if (p.identifier.UUIDString != NULL)
            {
                if (name != nil)// && ([name isEqualToString:@"SKB"] || [name isEqualToString:@"SKB "])) //Add new condition
                {
                   // BLEItem *item = [[BLEItem alloc] initWitUUID:p.identifier.UUIDString andName:name];
                    [arrray addObject:p];
                    
                }
                
            }
            
        }
        
    }
    return arrray;
    
}
@end
