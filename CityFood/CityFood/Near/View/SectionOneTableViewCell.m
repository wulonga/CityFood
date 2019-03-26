//
//  SectionOneTableViewCell.m
//  CityFood
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import "SectionOneTableViewCell.h"


#define SIZE_RADIUS_WIDTH   30

@interface SectionOneTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
{
}
@property(nonatomic,strong)SectionOneCollectionViewCell *sectionCell;
@property(nonatomic,strong)UIImageView *refreshImageView;
@property(nonatomic, strong)CAShapeLayer *rotateLayer;
@property(nonatomic,strong)UICollectionView *collect;

@end

@implementation SectionOneTableViewCell
@synthesize collect;

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"awakeFromNib方法执行");
    _dataArray=[[NSMutableArray alloc]init];
}
-(void)setup{
    NSLog(@"init方法执行");
    for (SectionOneCollectionViewCell *cell in collect.visibleCells) {
        [self setAnimation:cell];
    }
}
-(void)layoutSubviews{
    NSLog(@"layoutSubviews方法执行");
    if (collect!=nil) {
        [collect removeFromSuperview];
        [_dataArray removeAllObjects];
    }
    //创建一个layout布局类
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直布局
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //设置每个item的大小
    layout.itemSize=CGSizeMake(self.contentView.frame.size.width/2-0.001,self.contentView.frame.size.width/2-1+100);
    layout.minimumLineSpacing=0.001;
    layout.minimumInteritemSpacing=0;
    //创建collectionView通过一个布局策略layout
    collect=[[UICollectionView alloc]initWithFrame:self.contentView.frame collectionViewLayout:layout];
    collect.backgroundColor=[UIColor clearColor];
    //代理设置
    collect.delegate=self;
    collect.dataSource=self;
    collect.userInteractionEnabled=NO;
    //注册item的类型，这里使用系统的类型
    [collect registerClass:[SectionOneCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.contentView addSubview:collect];
    [self loadSperator:collect];
    [self loadRefresh];
}
-(void)loadSperator:(UICollectionView*)collect{
        UIView *horizontal=[[UIView alloc]init];
        horizontal.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:horizontal];
        [self.contentView bringSubviewToFront:horizontal];
        UIView *vertical=[[UIView alloc]init];
        vertical.backgroundColor=[UIColor lightGrayColor];
        [self.contentView addSubview:vertical];
        [self.contentView bringSubviewToFront:vertical];
        [horizontal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.contentView.frame.size.width-20);
            make.height.mas_equalTo(1);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(-10);
        }];
        [vertical mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(self.contentView.frame.size.height-30);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.centerY.mas_equalTo(self.contentView.frame.size.height-20).offset(-10);
        }];
}
-(void)loadRefresh{
    if (_refreshImageView==nil) {
        //添加刷新圈圈
        _refreshImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"刷新"]];
        _refreshImageView.tag=0;
        _refreshImageView.backgroundColor=[UIColor whiteColor];
        _refreshImageView.layer.cornerRadius=_refreshImageView.frame.size.width*0.5;
        //是类CALayer的属性，如果设置为yes，则不显示超出父view layer的部分
        _refreshImageView.layer.masksToBounds=YES;
        _refreshImageView.layer.shadowOffset=CGSizeMake(0,0);
        _refreshImageView.layer.shadowColor=[UIColor blackColor].CGColor;
        // 设置阴影透明度
        _refreshImageView.layer.shadowOpacity = 1;
        // 设置阴影半径
        _refreshImageView.layer.shadowRadius =3;
        //是类view的属性，如果设置为yes，则不显示超过父view的部分
        _refreshImageView.clipsToBounds = NO;
        [self.contentView addSubview:_refreshImageView];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshClick:)];
        [_refreshImageView addGestureRecognizer:singleTap];
        _refreshImageView.userInteractionEnabled=YES;
        [self.refreshImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(-13);
            make.width.height.mas_offset(30);
        }];
    }
    [self.contentView bringSubviewToFront:_refreshImageView];
}
//刷新按钮的点击事件通过delegate传值
-(void)refreshClick:(UIGestureRecognizer *)gestureRecognizer{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //动画的时间节奏控制
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//慢出效果
    rotateAnimation.fromValue = @0;
    rotateAnimation.toValue = @(2*M_PI);
    rotateAnimation.duration = 0.5;
    rotateAnimation.repeatCount = DOMAIN;
    rotateAnimation.removedOnCompletion = YES;
    [self.refreshImageView.layer addAnimation:rotateAnimation forKey:nil];
    self.refreshClick();
}

//注册cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _sectionCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    if (_sectionCell==nil) {
        _sectionCell=[[SectionOneCollectionViewCell alloc]init];
    }
    [_sectionCell setFoodImageView:_dataArray[indexPath.row].pic];
    [_sectionCell setName:_dataArray[indexPath.row].title withFont:[UIFont systemFontOfSize:15] withcolor:[UIColor blackColor]];
    [_sectionCell setLikeButton:@"喜欢" withunselectImg:@"喜欢"];
    [_sectionCell setIntroduce:_dataArray[indexPath.row].comment withFont:[UIFont systemFontOfSize:13] withColor:[UIColor lightGrayColor]];
    [_sectionCell setInstance:_dataArray[indexPath.row].distance withFont:[UIFont systemFontOfSize:10] withColor:[UIColor lightGrayColor]];
    [self setAnimation:_sectionCell];//设置动画
    return _sectionCell;
}
-(void)setAnimation:(SectionOneCollectionViewCell *)_sectionCell{
    _sectionCell.transform = CGAffineTransformMakeScale(0,0);
    __weak typeof(_sectionCell) weakSectionCell=_sectionCell;
    [UIView animateWithDuration:1
                     animations:^{
                         weakSectionCell.transform = CGAffineTransformMakeScale(1,1);
                     }completion:^(BOOL finish){
                     }];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置有几个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataArray count];
}
@end
