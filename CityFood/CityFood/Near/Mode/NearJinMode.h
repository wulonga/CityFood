//
//  NearJinMode.h
//  CityFood
//
//  Created by mac on 2019/3/7.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h" 

NS_ASSUME_NONNULL_BEGIN

@interface NearJinMode:JSONModel
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *pic;
@property(nonatomic,assign)double score;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *comment;
@property(nonatomic,assign)NSInteger isCollect;
@property(nonatomic,strong)NSString *distance;
@end

NS_ASSUME_NONNULL_END
