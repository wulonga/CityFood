//
//  SectionTwoTableViewCell.h
//  CityFood
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearYuanMode.h"
NS_ASSUME_NONNULL_BEGIN

@interface SectionTwoTableViewCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray<NearYuanMode *> *dataYuanArray;

-(void)setRestaurantImg:(NSString*)img setFoodText:(NSString*)text setName:(NSString*)name setComment:(NSString*)comment setIntroduction:(NSString*)introduction setPrice:(NSInteger)num setOnecomment:(NSString*)content setInstance:(NSString*)instance setLike:(NSString*)btn;

@end

NS_ASSUME_NONNULL_END
