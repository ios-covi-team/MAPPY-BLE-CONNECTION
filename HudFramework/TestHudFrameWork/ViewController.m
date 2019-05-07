//
//  ViewController.m
//  TestHudFrameWork
//
//  Created by Mr.Robo on 11/2/18.
//  Copyright © 2018 HudFramework. All rights reserved.
//

#import "ViewController.h"
#import <PontusHudFramework/PontusHUDManager.h>

@interface ViewController ()<PontusHUDManagerDelegate>

@end

@implementation ViewController{
    int speed;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[PontusHUDManager sharedInstance] setDelegate:self];
    [[PontusHUDManager sharedInstance] setDebugLog:true];
    speed = 500;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[PontusHUDManager sharedInstance] hudConnect];
}

#pragma mark - HUDManagerDelegate
- (void)pontusHudDidUpdateConnection:(BOOL)connected{
    if (connected) {
        _statusLbl.text = @"Connected";
        [self sendTBTInfor];
    }else{
        _statusLbl.text = @"Disconnected";
    }
    
}

- (IBAction)getInfoAction:(id)sender{
    NSLog(@"%@", [PontusHUDManager sharedInstance].strSN);
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendTBTInfor) userInfo:nil repeats:true];

}

- (void)sendTBTInfor{
    NSDictionary *dict = @{@"basicInfo.remainTime":@(60),
                           @"basicInfo.remainDist":@(speed += 20),
                           @"basicInfo.speed":@(speed += 1),
                           @"basicInfo.rgMode":@(1),
                           @"routeInfo.isRoute":@(true),
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
 
}

@end
