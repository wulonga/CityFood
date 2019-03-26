//
//  NearAddrHeaderView.m
//  CityFood
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import "NearAddrHeaderView.h"
#import "Masonry.h"

@implementation NearAddrHeaderView
-(void)layoutSubviews{
    [self.bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.bigLabel.mas_top);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    [self.weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timelabel.mas_right).offset(5);
        make.top.mas_equalTo(self.timelabel.mas_top);
        make.width.height.mas_equalTo(30);
    }];
    [self.addrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.timelabel.mas_bottom).offset(20);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(30);
    }];
}
-(UILabel*)bigLabel{
    if (_bigLabel==nil) {
        _bigLabel=[[UILabel alloc]init];
        _bigLabel.textColor=[UIColor blackColor];
        _bigLabel.font=[UIFont systemFontOfSize:100];
        [self addSubview:_bigLabel];
    }
    return _bigLabel;
}
-(UILabel*)timelabel{
    if (_timelabel==nil) {
        _timelabel=[[UILabel alloc]init];
        _timelabel.textColor=[UIColor blackColor];
        _timelabel.font=[UIFont systemFontOfSize:30];
        [self addSubview:_timelabel];
    }
    return _timelabel;
}
-(UIImageView*)weatherImageView{
    if (_weatherImageView==nil) {
        _weatherImageView=[[UIImageView alloc]init];
        [self addSubview:_weatherImageView];
    }
    return _weatherImageView;
}
-(UILabel*)addrLabel{
    if (_addrLabel==nil) {
        _addrLabel=[[UILabel alloc]init];
        _addrLabel.numberOfLines=0;
        _addrLabel.textColor=[UIColor blackColor];
        _addrLabel.font=[UIFont systemFontOfSize:20];
        [self addSubview:_addrLabel];
    }
    return _addrLabel;
}
@end
