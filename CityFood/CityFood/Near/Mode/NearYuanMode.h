//
//  NearYuanMode.h
//  CityFood
//
//  Created by mac on 2019/3/9.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NearYuanMode : NSObject
@property(nonatomic,strong)NSMutableArray *num;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *scene;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)NSInteger price;
@property(nonatomic,copy)NSString *comment;
@property(nonatomic,copy)NSString *distance;
@end

NS_ASSUME_NONNULL_END
