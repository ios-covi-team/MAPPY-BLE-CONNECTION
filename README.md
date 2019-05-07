# MAPPY-BLE-CONNECTION

## Features
- Support communication between BLE Device and MAPPY app.Because MAPPY company only support Android SDK and not iOS SDK. So if we want to communication on iOS we have to create a SDK by myself.And this framework resolved it.


- This BLE SDK for iOS provides a framework for iOS developers to develop Bluetooth 4.0 Low Energy (aka BLE) Apps easily using a simeple TXRX Service for exchanging data. It is based on Apple's CoreBluetooth framework.

- Connection to any device support BLE 4.0 above
- Transmit data and receive data from device BLE
- The app look for the peripherals, connect to one and then look for the services and characteristics.

## Support
- For iOS devices, only device support BLE 4.0 above.
- iOS Deployment target 10.0 and above
- Support Swift and Objective-C

![a](https://user-images.githubusercontent.com/15991780/57281368-0e31cb00-70d5-11e9-9012-b55e5cdb40a4.png)

## Edit Service and Characteristic UUID
- Check BLEDefines.h

## How to extract to framework
- Select HUD-Universal target and run
<img width="1149" alt="Screen Shot 2019-05-07 at 2 34 26 PM" src="https://user-images.githubusercontent.com/15991780/57281594-81d3d800-70d5-11e9-9fb5-fab2ab73eb81.png">

- After the xcode auto generate a HudFramework.framework in root project folder
<img width="551" alt="Screen Shot 2019-05-07 at 2 37 32 PM" src="https://user-images.githubusercontent.com/15991780/57281686-ac259580-70d5-11e9-9168-e49f93c35cb7.png">

## Installation
---- Manual ----
- Just drag the PontusHudFramework.framework to your project.
- Import the PontusHudFramework module to class you want to use.

## Example
    #import "ViewController.h"
    #import <PontusHudFramework/PontusHUDManager.h>

    @interface ViewController ()<PontusHUDManagerDelegate>

    @end

    @implementation ViewController

    - (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
        [[PontusHUDManager sharedInstance] setDelegate:self];
        [[PontusHUDManager sharedInstance] setDebugLog:YES];
    }

    - (void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
    }

    - (IBAction)didChangeOnfOffSwitch:(id)sender {
        BOOL isOn = [(UISwitch *)sender isOn];
        if (isOn) {
            [[PontusHUDManager sharedInstance] hudConnect];
        } else {
            [[PontusHUDManager sharedInstance] hudDisConnect];
        }
    }

    - (IBAction)didTapDebuggingButton:(id)sender {
        NSLog(@"[DEBUG] isConnected : [%d]", [[PontusHUDManager sharedInstance] isConnected]);
        NSLog(@"[DEBUG] strSN : [%@]", [[PontusHUDManager sharedInstance] strSN]);
    }

    #pragma mark - HUDManagerDelegate
    - (void)pontusHudDidUpdateConnection:(BOOL)connected{
        if (connected) {
            _titleLbl.text =  [NSString stringWithFormat:@"연결 되었습니다.\n시리얼:%@", [[PontusHUDManager sharedInstance] strSN]];
            NSDictionary *dict = @{@"basicInfo.remainTime":@(60),
                                   @"basicInfo.remainDist":@(90000),
                                   @"basicInfo.speed":@(500),
                                   @"basicInfo.rgMode":@(1),
                                   @"routeInfo.isRoute":@(YES),
                                   @"curTurnInfo.code":@(10),
                                   @"curTurnInfo.remainDist":@(100),
                                   @"nextTurnInfo.code":@(120),
                                   @"nextTurnInfo.remainDist":@(1),
                                   @"safeInfo.limitSpeed":@(100),
                                   @"safeInfo.cameraCode":@(1),
                                   @"safeInfo.remainDist":@(1),
                                   @"safeInfo.avrSpeed":@(1),
                                   @"safeInfo.remainTime":@(1),
                                   @"safeInfo.overSpeed":@(1),
                                   @"safeInfo.safeCode":@(1),
                                   @"curHighwayInfo.remainDist":@(1),
                                   @"curHighwayInfo.fee":@(1),
                                   @"curHighwayInfo.speed":@(1000),
                                   @"curHighwayInfo.serviceType":@(1)
                                   };
            [[PontusHUDManager sharedInstance] hudUpdateRGData:dict];
        }else{
            _titleLbl.text =  [NSString stringWithFormat:@"연결이 끊어졌습니다."];

        }
    }
    
## Demo
There is a demo project added to this repository, so you can see how it works.

## License
Copyright (c) 2018 COVISOFT INCOPORATION

Author : mrrobo1510

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
