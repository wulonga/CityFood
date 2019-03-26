//
//  SectionOneTableViewCell.h
//  CityFood
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearJinMode.h"
#import "SectionOneCollectionViewCell.h"
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^RefreshClick)(void);
@interface SectionOneTableViewCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray<NearJinMode *> *dataArray;
@property(nonatomic,copy)RefreshClick refreshClick;
-(void)refreshClick:(UIGestureRecognizer *)gestureRecognizer;
-(void)setAnimation:(SectionOneCollectionViewCell *)_sectionCell;
@end

NS_ASSUME_NONNULL_END
