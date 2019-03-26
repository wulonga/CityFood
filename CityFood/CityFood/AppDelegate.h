//
//  AppDelegate.h
//  CityFood
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BMKLocationkit/BMKLocationAuth.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate, BMKLocationAuthDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

