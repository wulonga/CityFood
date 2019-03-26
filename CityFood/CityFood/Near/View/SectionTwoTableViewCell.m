//
//  SectionTwoTableViewCell.m
//  CityFood
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import "SectionTwoTableViewCell.h"
#import "Masonry.h"

@interface SectionTwoTableViewCell()
{
    NSInteger num;
    NSInteger instance;
}
@property(nonatomic,strong)UIImageView *restaurantImg,*priceImgOne,*priceImgTwo,*priceImgThree,*priceImgFour;
@property(nonatomic,strong)UILabel *oneFoodLabel,*nameLabel,*commentLabel,*numCommentLabel,*introductionLabel,*instanceLabel;
@property(nonatomic,strong)UIView *bigView;
@property(nonatomic,strong)UIButton *likeBtn;
@end

@implementation SectionTwoTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(void)setRestaurantImg:(NSString*)img setFoodText:(NSString*)text setName:(NSString*)name setComment:(NSString*)comment setIntroduction:(NSString*)introduction setPrice:(NSInteger)num setOnecomment:(NSString*)content setInstance:(NSString*)instance setLike:(NSString*)btn{
    //self.restaurantImg.image=[UIImage imageNamed:img];
    [self.restaurantImg sd_setImageWithURL:[NSURL URLWithString:img]];
    self.oneFoodLabel.text=text;
    self.nameLabel.text=name;
    self.commentLabel.text=comment;
    self.numCommentLabel.text=content;
    self.introductionLabel.text=introduction;
    self.instanceLabel.text=instance;
    [self.priceImgOne setImage:[UIImage imageNamed:@"人民币(灰)"]];
    [self.priceImgTwo setImage:[UIImage imageNamed:@"人民币(灰)"]];
    [self.priceImgThree setImage:[UIImage imageNamed:@"人民币(灰)"]];
    [self.priceImgFour setImage:[UIImage imageNamed:@"人民币(灰)"]];
    [self.likeBtn setImage:[UIImage imageNamed:btn] forState:UIControlStateNormal];
}

-(void)layoutSubviews{
    [self.restaurantImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(210);
    }];
    [self.oneFoodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.restaurantImg.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    [self.bigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.restaurantImg.mas_bottom).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(130);
    }];
    [self.numCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bigView.mas_top).offset(10);
        make.right.mas_equalTo(self.bigView.mas_right).offset(-5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numCommentLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(self.bigView.mas_right).offset(-5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oneFoodLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.bigView.mas_left).offset(-5);
        make.height.mas_equalTo(50);
    }];
    [self.priceImgOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.height.width.mas_equalTo(20);
    }];
    [self.priceImgTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.priceImgOne.mas_right).offset(-3);
        make.height.width.mas_equalTo(20);
    }];
    [self.priceImgThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.priceImgTwo.mas_right).offset(-3);
        make.height.width.mas_equalTo(20);
    }];
    [self.priceImgFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.priceImgThree.mas_right).offset(-3);
        make.height.width.mas_equalTo(20);
    }];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceImgOne.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.width.mas_equalTo(80);
    }];
    [self.instanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.width.mas_equalTo(20);
        make.width.width.mas_equalTo(20);
    }];
}
#pragma mark 懒加载
-(UIImageView*)restaurantImg{
    if (_restaurantImg==nil) {
        _restaurantImg=[[UIImageView alloc]init];
        //_restaurantImg.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:_restaurantImg];
    }
    return _restaurantImg;
}
-(UIImageView*)priceImgOne{
    if (_priceImgOne==nil) {
        _priceImgOne=[[UIImageView alloc]init];
        //_priceImgOne.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:_priceImgOne];
    }
    return _priceImgOne;
}
-(UIImageView*)priceImgTwo{
    if (_priceImgTwo==nil) {
        _priceImgTwo=[[UIImageView alloc]init];
        //_priceImgTwo.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:_priceImgTwo];
    }
    return _priceImgTwo;
}
-(UIImageView*)priceImgThree{
    if (_priceImgThree==nil) {
        _priceImgThree=[[UIImageView alloc]init];
        //_priceImgThree.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:_priceImgThree];
    }
    return _priceImgThree;
}
-(UIImageView*)priceImgFour{
    if (_priceImgFour==nil) {
        _priceImgFour=[[UIImageView alloc]init];
        //_priceImgFour.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:_priceImgFour];
    }
    return _priceImgFour;
}

-(UILabel*)oneFoodLabel{
    if (_oneFoodLabel==nil) {
        _oneFoodLabel=[[UILabel alloc]init];
        _oneFoodLabel.layer.borderWidth=1;
        _oneFoodLabel.layer.borderColor=[UIColor blackColor].CGColor;
        //_oneFoodLabel.backgroundColor=[UIColor lightGrayColor];
        _oneFoodLabel.textColor=[UIColor blackColor];
        _oneFoodLabel.font=[UIFont systemFontOfSize:17];
        _oneFoodLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_oneFoodLabel];
    }
    return _oneFoodLabel;
}
-(UILabel*)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc]init];
        //_nameLabel.backgroundColor=[UIColor redColor];
        _nameLabel.textColor=[UIColor blackColor];
        _nameLabel.font=[UIFont systemFontOfSize:25];
        _nameLabel.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}
-(UILabel*)commentLabel{
    if (_commentLabel==nil) {
        _commentLabel=[[UILabel alloc]init];
        //_commentLabel.backgroundColor=[UIColor lightGrayColor];
        _commentLabel.textColor=[UIColor grayColor];
        _commentLabel.font=[UIFont systemFontOfSize:20];
        _commentLabel.textAlignment=NSTextAlignmentLeft;
        _commentLabel.numberOfLines=0;
        [self.contentView addSubview:_commentLabel];
    }
    return _commentLabel;
}
-(UILabel*)numCommentLabel{
    if (_numCommentLabel==nil) {
        _numCommentLabel=[[UILabel alloc]init];
        //_numCommentLabel.backgroundColor=[UIColor lightGrayColor];
        _numCommentLabel.textColor=[UIColor blackColor];
        _numCommentLabel.font=[UIFont systemFontOfSize:13];
        _numCommentLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_numCommentLabel];
    }
    return _numCommentLabel;
}
-(UILabel*)introductionLabel{
    if (_introductionLabel==nil) {
        _introductionLabel=[[UILabel alloc]init];
        //_introductionLabel.backgroundColor=[UIColor lightGrayColor];
        _introductionLabel.textColor=[UIColor blackColor];
        _introductionLabel.font=[UIFont systemFontOfSize:13];
        _introductionLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_introductionLabel];
    }
    return _introductionLabel;
}
-(UILabel*)instanceLabel{
    if (_instanceLabel==nil) {
        _instanceLabel=[[UILabel alloc]init];
        //_instanceLabel.backgroundColor=[UIColor lightGrayColor];
        _instanceLabel.textColor=[UIColor grayColor];
        _instanceLabel.font=[UIFont systemFontOfSize:8];
        _instanceLabel.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:_instanceLabel];
    }
    return _instanceLabel;
}
-(UIButton*)likeBtn{
    if (_likeBtn==nil) {
        _likeBtn=[[UIButton alloc]init];
        //_likeBtn.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:_likeBtn];
    }
    return _likeBtn;
}
-(UIView*)bigView{
    if (_bigView==nil) {
        _bigView=[[UIView alloc]init];
        //_bigView.backgroundColor=[UIColor yellowColor];
        _bigView.layer.borderWidth=1;
        _bigView.layer.borderColor=[UIColor blackColor].CGColor;
        [_bigView addSubview:self.numCommentLabel];
        [_bigView addSubview:self.introductionLabel];
        [self.contentView addSubview:_bigView];
    }
    return _bigView;
}
@end
