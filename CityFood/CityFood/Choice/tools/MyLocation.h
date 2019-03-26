//
//  MyLocation.h
//  CityFood
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>


@class CLLocation;//系统报告的经度，纬度，航向信息
@class CLHeading;//用户相对于正北方的位置
@interface MyLocation : BMKUserLocation

-(id)initWithLocation:(CLLocation*)loc whitHeading:(CLHeading*)head;

@end

