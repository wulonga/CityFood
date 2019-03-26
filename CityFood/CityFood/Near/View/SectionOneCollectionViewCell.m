//
//  SectionOneCollectionViewCell.m
//  CityFood
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import "SectionOneCollectionViewCell.h"
#import "Masonry.h"
#import "UILabel+LeftTopAlign.h"

@interface SectionOneCollectionViewCell()
@property(nonatomic,strong)UIImageView *foodImage;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,)UILabel *introduceLabel;
@property(nonatomic,strong)UIButton *likeButton;
@property(nonatomic,strong)UILabel *instanceLabel;

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIView *rightView;
@end

@implementation SectionOneCollectionViewCell
-(void)layoutSubviews{
    [self.foodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(self.contentView.frame.size.width*2/3);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.foodImage.mas_bottom).offset(5);
        make.left.mas_equalTo(self.foodImage.mas_left).offset(1);
        make.width.mas_equalTo(self.foodImage.mas_width);
        make.height.mas_equalTo(50);
    }];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.width.mas_equalTo(self.nameLabel.mas_width);
        make.height.mas_equalTo(70);
    }];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-2);
        make.left.mas_equalTo(self.introduceLabel.mas_left);
        make.height.width.mas_equalTo(20);
    }];
    [self.instanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-2);
        make.right.mas_equalTo(self.introduceLabel.mas_right);
        make.height.width.mas_equalTo(30);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.foodImage.mas_left);
        make.width.mas_equalTo(self.foodImage.mas_width);
        make.height.mas_equalTo(0.5);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.left.mas_equalTo(self.foodImage.mas_left);
        make.width.mas_equalTo(self.foodImage.mas_width);
        make.height.mas_equalTo(0.5);
    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
}
-(void)setFoodImageView:(NSString*) imagePath{
//    [self.foodImage setImage:[self getImageFromURL:imagePath]];
    [self.foodImage sd_setImageWithURL:[NSURL URLWithString:imagePath]];
}
-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}
-(void)setName:(NSString*) nameStr withFont:(UIFont*) font withcolor:(UIColor*) color{
    self.nameLabel.text=nameStr;
    self.nameLabel.font=font;
    self.nameLabel.textColor=color;
}
-(void)setIntroduce:(NSString*) str withFont:(UIFont*) font withColor:(UIColor*) color{
    self.introduceLabel.text=str;
    self.introduceLabel.font=font;
    self.introduceLabel.textColor=color;
};
-(void)setInstance:(NSString*) str withFont:(UIFont*) font withColor:(UIColor*) color{
    self.instanceLabel.text=str;
    self.instanceLabel.font=font;
    self.instanceLabel.textColor=color;
};
-(void)setLikeButton:(NSString*) selectImage withunselectImg:(NSString*) unselectImage{
    [self.likeButton setImage:[UIImage imageNamed:selectImage] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:unselectImage] forState:UIControlStateSelected];
}
-(UIImageView*)foodImage{
    if (_foodImage==nil) {
        _foodImage=[[UIImageView alloc]init];
        _foodImage.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_foodImage];
    }
    return _foodImage;
}
-(UILabel*)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.textAlignment=NSTextAlignmentLeft;
        //_nameLabel.backgroundColor=[UIColor grayColor];
        _nameLabel.numberOfLines=0;
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}
-(UILabel*)introduceLabel{
    if (_introduceLabel==nil) {
        _introduceLabel=[[UILabel alloc]init];
        //_introduceLabel.backgroundColor=[UIColor grayColor];
        _introduceLabel.numberOfLines=0;
        [self.contentView addSubview:_introduceLabel];
    }
    return _introduceLabel;
}
-(UIButton*)likeButton{
    if (_likeButton==nil) {
        _likeButton=[[UIButton alloc]init];
        _likeButton.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_likeButton];
    }
    return _likeButton;
}
-(UILabel*)instanceLabel{
    if (_instanceLabel==nil) {
        _instanceLabel=[[UILabel alloc]init];
        _instanceLabel.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:_instanceLabel];
    }
    return _instanceLabel;
}
#pragma mark cell的四个分割线
-(UIView*)topView{
    if (_topView==nil) {
        _topView=[[UIView alloc]init];
        _topView.backgroundColor=[UIColor lightGrayColor];
        _topView.hidden=YES;
        _topView.tag=0;
        [self.contentView addSubview:_topView];
    }
    return _topView;
}
-(UIView*)leftView{
    if (_leftView==nil) {
        _leftView=[[UIView alloc]init];
        _leftView.backgroundColor=[UIColor lightGrayColor];
        _leftView.hidden=YES;
        _leftView.tag=1;
        [self.contentView addSubview:_leftView];
    }
    return _leftView;
}
-(UIView*)bottomView{
    if (_bottomView==nil) {
        _bottomView=[[UIView alloc]init];
        _bottomView.backgroundColor=[UIColor lightGrayColor];
        _bottomView.hidden=YES;
        _bottomView.tag=2;
        [self.contentView addSubview:_bottomView];
    }
    return _bottomView;
}
-(UIView*)rightView{
    if (_rightView==nil) {
        _rightView=[[UIView alloc]init];
        _rightView.backgroundColor=[UIColor lightGrayColor];
        _rightView.hidden=YES;
        _rightView.tag=3;
        [self.contentView addSubview:_rightView];
    }
    return _rightView;
}

@end
