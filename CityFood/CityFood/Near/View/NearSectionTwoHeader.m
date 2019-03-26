//
//  NearSectionTwoHeader.m
//  CityFood
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import "NearSectionTwoHeader.h"

@interface NearSectionTwoHeader()

@end

@implementation NearSectionTwoHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
//如果要用代码修改控件内容就写在这里
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (void)setup{
    self.bigLabel.text=@"远";
    self.introduceLabel.text=@"全城去处推荐";
    [self setBackgroundColor:[UIColor whiteColor]];
}

@end
