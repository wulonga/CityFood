//
//  NavAddrView.m
//  CityFood
//
//  Created by mac on 2019/2/23.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import "NavAddrView.h"
#import "Masonry.h"


@interface NavAddrView()

@property(nonatomic,strong)UILabel *addLab;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation NavAddrView

-(void)layoutSubviews{
    [self.addLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addLab.mas_right);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
        make.centerY.mas_equalTo(self.addLab.mas_centerY);
    }];
}
-(UILabel*)addLab{
    if (_addLab==nil) {
        _addLab=[[UILabel alloc]init];
        _addLab.textColor=[UIColor blackColor];
        _addLab.font=[UIFont systemFontOfSize:19];
        _addLab.textAlignment=NSTextAlignmentLeft;
        _addLab.text=self.addStr;
        [self addSubview:_addLab];
    }
    return _addLab;
}
-(UIImageView*)imageView{
    if (_imageView==nil) {
        _imageView=[[UIImageView alloc]init];
        _imageView.image=[UIImage imageNamed:@"下拉"];
        [self addSubview:_imageView];
    }
    return _imageView;
}
@end
