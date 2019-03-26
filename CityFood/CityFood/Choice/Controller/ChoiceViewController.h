//
//  ChoiceViewController.h
//  CityFood
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 Gooou. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationKit/BMKLocationManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChoiceViewController : UIViewController <BMKLocationManagerDelegate>

@property (nonatomic , retain) UINavigationController *navigationController;

@end

NS_ASSUME_NONNULL_END
