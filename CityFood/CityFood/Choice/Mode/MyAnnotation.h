//
//  MyAnnotation.h
//  CityFood
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
NS_ASSUME_NONNULL_BEGIN

@interface MyAnnotation : NSObject<BMKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
//自定义大头针图片
@property(nonatomic,copy) NSString *icon;

@end

NS_ASSUME_NONNULL_END
