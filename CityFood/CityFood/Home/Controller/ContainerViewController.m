//
//  ContainerViewController.m
//  CityFood
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 Gooou. All rights reserved.
//


#ifndef __OPTIMIZE__
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#endif

#import "ContainerViewController.h"
#import "NearViewController.h"
#import "ChoiceViewController.h"
#import "SearchViewController.h"
#import "MineViewController.h"
#import "NavAddrView.h"


@interface ContainerViewController ()<UIScrollViewDelegate>
{
    NearViewController *nearVC;
    ChoiceViewController *choiceVC;
    SearchViewController *searchVC;
    MineViewController *mineVC;
    UIScrollView *mainScrollView;
    UIView *navView;
    UILabel *sliderLabel;
    UIButton *nearBtn;
    UIButton *choiceBtn;
    UIButton *searchBtn;
    UIButton *mineBtn;
}
@property(nonatomic,strong)NavAddrView *navAddrView;
@end

@implementation ContainerViewController


//视图控制器中的视图加载完成，viewController自带的view加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self initUI];
    [self setMainScrollView];
    //设置默认
    [self sliderWithTag:self.currentIndex+1];
}
//视图将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //用于导航栏的阴影图像
    [self.navigationController.navigationBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
}
//解决标题栏底部横线
- (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    //创建基于上下文的位图图像
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
-(void)initUI{
    navView = [[UIView alloc]initWithFrame:CGRectMake(0,Height_NavBar-44,SCWIDTH, 45)];
    nearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nearBtn setImage:[UIImage imageNamed:@"首页"] forState:UIControlStateNormal];
    [nearBtn setImage:[UIImage imageNamed:@"首页(1)"] forState:UIControlStateSelected];
    
    nearBtn.frame = CGRectMake(SCWIDTH/2-20,14,30,30);
    [nearBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    nearBtn.tag = 1;
    nearBtn.selected = YES;
    [navView addSubview:nearBtn];
    
    choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    choiceBtn.frame = CGRectMake(nearBtn.frame.origin.x+nearBtn.frame.size.width+20, nearBtn.frame.origin.y, 30,30);
    [choiceBtn setImage:[UIImage imageNamed:@"附近"] forState:UIControlStateNormal];
    [choiceBtn setImage:[UIImage imageNamed:@"附近(1)"] forState:UIControlStateSelected];
    
    [choiceBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    choiceBtn.tag = 2;
    [navView addSubview:choiceBtn];
    
    
    searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(choiceBtn.frame.origin.x+choiceBtn.frame.size.width+20, choiceBtn.frame.origin.y, 30,30);
    [searchBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"搜索(1)"] forState:UIControlStateSelected];
    
    [searchBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.tag = 3;
    [navView addSubview:searchBtn];
    
    mineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mineBtn.frame = CGRectMake(searchBtn.frame.origin.x+searchBtn.frame.size.width+20, searchBtn.frame.origin.y, 30,30);
    [mineBtn setImage:[UIImage imageNamed:@"我的"] forState:UIControlStateNormal];
    [mineBtn setImage:[UIImage imageNamed:@"我的(1)"] forState:UIControlStateSelected];
    [mineBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    mineBtn.tag = 4;
    [navView addSubview:mineBtn];
    
    sliderLabel = [[UILabel alloc]initWithFrame:CGRectMake(nearBtn.frame.origin.x,0,2,14)];
    sliderLabel.backgroundColor = [UIColor redColor];
    [navView addSubview:sliderLabel];
    
    self.navAddrView=[[NavAddrView alloc]initWithFrame:CGRectMake(20,14, 60, 20)];
    self.navAddrView.addStr=@"西安";
    //self.navAddrView.backgroundColor=[UIColor redColor];
    [navView addSubview:self.navAddrView];
    
    self.navigationItem.titleView = navView;
    

}
-(void)setMainScrollView{
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,SCWIDTH, self.view.frame.size.height)];
    mainScrollView.delegate = self;
    mainScrollView.backgroundColor = [UIColor whiteColor];
    mainScrollView.pagingEnabled = YES;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    
    NSArray *views=@[self.nearVC.view,self.choiceVC.view,self.searchVC.view,self.mineVC.view];
    for (NSInteger i=0; i<views.count; i++) {
        //把四个vc的view一次贴在mainScrollView上面
        UIView *pageView=[[UIView alloc]initWithFrame:CGRectMake(SCWIDTH*i, 0, mainScrollView.frame.size.width,SCHEIGHT)];
        [pageView addSubview:views[i]];
        [mainScrollView addSubview:pageView];
    }
    mainScrollView.contentSize=CGSizeMake(SCWIDTH*(views.count), 0);
    //滚动到_currentIndex对应的tab
    [mainScrollView setContentOffset:CGPointMake((mainScrollView.frame.size.width)*_currentIndex, 0) animated:YES];
}
#pragma mark 懒加载四个控制器
-(NearViewController*)nearVC{
    if (nearVC==nil) {
        nearVC=[[NearViewController alloc]init];
        nearVC.navigationController=self.navigationController;
    }
    return nearVC;
}
-(ChoiceViewController*)choiceVC{
    if (choiceVC==nil) {
        choiceVC=[[ChoiceViewController alloc]init];
        choiceVC.navigationController=self.navigationController;
    }
    return choiceVC;
}
-(SearchViewController*)searchVC{
    if (searchVC==nil) {
        searchVC=[[SearchViewController alloc]init];
        searchVC.navigationController=self.navigationController;
    }
    return searchVC;
}
-(MineViewController*)mineVC{
    if (mineVC==nil) {
        mineVC=[[MineViewController alloc]init];
        mineVC.navigationController=self.navigationController;
    }
    return mineVC;
}
//按钮的点击事件
-(void)sliderAction:(UIButton *)sender{
    if (self.currentIndex==sender.tag) {
        return;
    }
    [self sliderAnimationWithTag:sender.tag];
    [UIView animateWithDuration:0.3 animations:^{
        mainScrollView.contentOffset=CGPointMake(SCWIDTH*(sender.tag-1), 0);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)sliderWithTag:(NSInteger)tag{
    self.currentIndex=tag;
    nearBtn.selected=NO;
    choiceBtn.selected=NO;
    searchBtn.selected=NO;
    mineBtn.selected=NO;
    UIButton *sender=[self buttonWithTag:tag];//根据tag返回对应的button
    sender.selected=YES;
    //动画-按钮点击处理顶部的竖线
    [UIView animateWithDuration:0.3 animations:^{
    sliderLabel.frame=CGRectMake(sender.frame.origin.x+14, sliderLabel.frame.origin.y, sliderLabel.frame.size.width, sliderLabel.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    //NSLog(@"竖线的位置%f",sliderLabel.frame.origin.x);
}
-(UIButton *)buttonWithTag:(NSInteger )tag{
    if (tag==1) {
        return nearBtn;
    }else if (tag==2){
        return choiceBtn;
    }else if (tag==3){
        return searchBtn;
    }else if (tag==4){
        return mineBtn;
    }else{
        return nil;
    }
}
-(void)sliderAnimationWithTag:(NSInteger)tag{
    self.currentIndex = tag;
    nearBtn.selected = NO;
    choiceBtn.selected = NO;
    searchBtn.selected = NO;
    mineBtn.selected = NO;
    UIButton *sender = [self buttonWithTag:tag];
    sender.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        sliderLabel.frame=CGRectMake(sender.frame.origin.x+14, sliderLabel.frame.origin.y, sliderLabel.frame.size.width, sliderLabel.frame.size.height);
    } completion:^(BOOL finished) {
        sender.selected=YES;
    }];
}
//已经结束减速滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat contentOffSetX = scrollView.contentOffset.x;
    int index_ = contentOffSetX/SCWIDTH;
    [self sliderWithTag:index_+1];
}
@end
