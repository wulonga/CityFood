//
//  ContainerViewController.h
//  CityFood
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContainerViewController : UIViewController
/*
 *控制器跳转到某个tab的参数，默认为0，就是第一个tab
 */
@property(nonatomic,assign)NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
