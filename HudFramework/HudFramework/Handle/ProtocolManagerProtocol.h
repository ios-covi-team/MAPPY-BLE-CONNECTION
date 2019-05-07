//
//  ProtocolManagerProtocol.h
//  SBKApplication
//
//  Created by Covisoft Viet Nam on 8/9/16.
//  Copyright © 2016 Covisoft Viet Nam. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MappyModel.h"

@protocol ProtocolManagerProtocol <NSObject>
- (void)sendMappyInfo:(MappyModel *)mappy;
@optional

@end
