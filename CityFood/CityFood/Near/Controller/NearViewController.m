//
//  NearViewController.m
//  CityFood
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import "NearViewController.h"
#import "NearAddrHeaderView.h"
#import "SectionOneTableViewCell.h"
#import "NearSectionTwoHeader.h"
#import "SectionTwoTableViewCell.h"
#import "NearJinMode.h"
#import "NearYuanMode.h"
#import "NearYuanNum.h"
#import "Masonry.h"

@interface NearViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)dispatch_queue_t myConcurrentQueue;
@property(nonatomic,strong)UITableView *nearTableView;
@property(nonatomic,strong)SectionTwoTableViewCell *sectionOneCell2;
@property(nonatomic,strong)SectionOneTableViewCell *sectionOneCell;
@property(nonatomic,strong)NearAddrHeaderView *nearAddrHeaderView;
@property(nonatomic,strong)NearSectionTwoHeader *nearSectionTwoHeader;
@property (nonatomic, assign) NSInteger lastcontentOffset; //添加此属性的作用，根据差值，判断ScrollView是上滑还是下拉
@property(nonatomic,strong)NSMutableArray *arrayData,*arrayYuanData;
@property(nonatomic,strong)NSMutableArray *randomFourData;
@end

@implementation NearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayYuanData=[NSMutableArray new];
    //并发队列需要自己创建
    //_myConcurrentQueue=dispatch_queue_create("gcd.ciewDidLoadQueue", DISPATCH_QUEUE_CONCURRENT);
    
    ///底下是多个异步请求完成后采取刷新UI
    //信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    //创建全局并行（不需要自己创建，本身就存在）
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //网络请求一
    dispatch_group_async(group, queue, ^{
        [self fromYuanJSONMode];//网络请求完成
        dispatch_semaphore_signal(semaphore);
    });
    //网络请求二
    dispatch_group_async(group, queue, ^{
        [self fromJinJSONtoMode];//网络请求完成
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nearTableView.backgroundColor=[UIColor clearColor];
            NSLog(@"刷新UI");
        });
    });
}

-(void)fromJinJSONtoMode{
    NSLog(@"当前线程1===========%@",[NSThread currentThread]);
    //获取文件路径
    NSString *path=[[NSBundle mainBundle] pathForResource:@"jin" ofType:@"geojson"];
    //系统中有一个默认的manager
    NSFileManager *fileMgr=[NSFileManager defaultManager];
    //判断路径下是否存在json文件
    if ([fileMgr fileExistsAtPath:path]) {
        //保存json文件中的信息，j就是那些字符串
        NSString *jsonStr=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        //将json字符串使用UTF-8编码为nsdata对象
        NSData *jsonData=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        //解析NSData对象的数据
        id jsonObj=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        if ([jsonObj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic=(NSDictionary*)jsonObj;
            _arrayData=[NSMutableArray new];
            for (NSDictionary *dicInner in dic[@"data"][@"data"][@"poi"]) {
                NearJinMode *mode=[[NearJinMode alloc]init];
                mode.pid=[dicInner objectForKey:@"pid"];
                mode.pic=[dicInner objectForKey:@"pic"];
                mode.score=[[dicInner objectForKey:@"pid"] integerValue];
                mode.title=[dicInner objectForKey:@"title"];
                mode.comment=[dicInner objectForKey:@"comment"];
                mode.isCollect=[[dicInner objectForKey:@"iscollect"] integerValue];
                mode.distance=[dicInner objectForKey:@"distance"];
                [_arrayData addObject:mode];
            }
            //NSLog(@"json数据为==%@",_arrayData);
        }
        [self selectFourElement];
    }
    
}
-(void)fromYuanJSONMode{
    NSLog(@"当前线程2===========%@",[NSThread currentThread]);
    //获取文件路径
    NSString *path=[[NSBundle mainBundle] pathForResource:@"yuan" ofType:@"geojson"];
    //系统中有一个默认的manager
    NSFileManager *fileMgr=[NSFileManager defaultManager];
    //判断路径下是否存在json文件
    if ([fileMgr fileExistsAtPath:path]) {
        //保存json文件中的信息,就是那些字符串
        NSString *jsonStr=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        //将json字符串使用UTF-8编码为nsdata对象
        NSData *jsonData=[jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        //解析NSData对象的数据
        id jsonObj=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        if ([jsonObj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic=(NSDictionary*)jsonObj;
            for (NSDictionary *dicInner in dic[@"data"][@"list"]) {
                NearYuanMode *mode=[NearYuanMode new];
                mode.pic=[dicInner objectForKey:@"pic"];
                mode.scene=[dicInner objectForKey:@"scene"];
                mode.title=[dicInner objectForKey:@"title"];
                mode.price=[[dicInner objectForKey:@"price"] integerValue];
                mode.distance=[dicInner objectForKey:@"distance"];
                mode.comment=[dicInner objectForKey:@"comment"];
                NSArray *d=[dicInner objectForKey:@"number"];
                mode.num=[NSMutableArray new];
                [mode.num removeAllObjects];
                NSString *oneComment=[NSString stringWithFormat:@"%@%@",[d[0] objectForKey:@"num"],[d[0] objectForKey:@"name"]];
                NSString *oneStrategy=[NSString stringWithFormat:@"%@%@",[d[1] objectForKey:@"num"],[d[1] objectForKey:@"name"]];
                [mode.num addObject:oneComment];
                [mode.num addObject:oneStrategy];
                [_arrayYuanData addObject:mode];
            }
            NSLog(@"json远数据为==%@",_arrayYuanData);
        }
    }
}
-(void)selectFourElement{
    _randomFourData=[[NSMutableArray alloc]init];
    [_randomFourData removeAllObjects];
    for (int i=0; i<4; i++) {
        int k=[self getRandomNumber:0 to:(int)([_arrayData count]-1)];
        [_randomFourData addObject:_arrayData[k]];
    }
}
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from + 1))); //产生随机数包括from不包括to
}
#pragma mark 表格的懒加载
-(UITableView*)nearTableView{
    if (_nearTableView==nil) {
        long a=SCHEIGHT;
        long b=Height_NavBar;
        long c=a-b;
        _nearTableView=[[UITableView alloc]initWithFrame:CGRectMake(10, 0, SCWIDTH-20,c) style:UITableViewStyleGrouped];
        _nearTableView.backgroundColor=[UIColor redColor];
        _nearTableView.scrollEnabled=YES;
        _nearTableView.showsVerticalScrollIndicator=NO;
        __weak typeof(_nearTableView) selfNearTableView=_nearTableView;
        __weak typeof(self) weakSelf=self;
        _nearTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //进入刷新状态会调用这个block
            NSLog(@"正在刷新");
            dispatch_async(weakSelf.myConcurrentQueue, ^{
                [NSThread sleepForTimeInterval:2.0];
                [weakSelf selectFourElement];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.nearTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
                });
            });
            [selfNearTableView.mj_header endRefreshing];
        }];
        _nearTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        if (@available(iOS 11.0, *)) {
            _nearTableView.estimatedRowHeight = 0;
            _nearTableView.estimatedSectionHeaderHeight = 0;
            _nearTableView.estimatedSectionFooterHeight = 0;
        }
        _nearTableView.delegate=self;
        _nearTableView.dataSource=self;
        [self.view addSubview:_nearTableView];
    }
    return _nearTableView;
}
-(void)loadMoreData{
    NSLog(@"正在加载");
    __weak typeof(_nearTableView) selfNearTableView=_nearTableView;
    __weak typeof(self) weakSelf=self;
    dispatch_async(weakSelf.myConcurrentQueue, ^{
        [NSThread sleepForTimeInterval:3.0];
        [weakSelf fromYuanJSONMode];
        dispatch_async(dispatch_get_main_queue(), ^{
            [selfNearTableView reloadData];
        });
    });
    [_nearTableView.mj_footer endRefreshing];
}
#pragma mark tableview的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return _arrayYuanData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"cellStr";
    static NSString *str2=@"cellStr2";
    if (indexPath.section==0) {
        //cell复用
        _sectionOneCell=[tableView dequeueReusableCellWithIdentifier:str];
        if (_sectionOneCell==nil) {
            _sectionOneCell=[[SectionOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            _sectionOneCell=[[SectionOneTableViewCell alloc]init];
        }
        _sectionOneCell.dataArray=_randomFourData;
        _sectionOneCell.selectionStyle=UITableViewCellSelectionStyleNone;
        [_sectionOneCell setBackgroundColor:[UIColor whiteColor]];
        _sectionOneCell.userInteractionEnabled=YES;
        __weak typeof(self) WeakSelf=self;
        //刷新按钮的回调事件
        _sectionOneCell.refreshClick = ^{
            dispatch_async(WeakSelf.myConcurrentQueue, ^{
                [WeakSelf selectFourElement];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [WeakSelf.nearTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
                });
            });
        };
        return _sectionOneCell;
    }else{
        _sectionOneCell2=[tableView dequeueReusableCellWithIdentifier:str2];
        if (_sectionOneCell2==nil) {
            _sectionOneCell2=[[SectionTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str2];
        }
        _sectionOneCell2.selectionStyle=UITableViewCellSelectionStyleNone;
        [_sectionOneCell2 setBackgroundColor:[UIColor whiteColor]];
        _sectionOneCell2.userInteractionEnabled=YES;
        NearYuanMode *mode=_arrayYuanData[indexPath.row];
        
        [_sectionOneCell2 setRestaurantImg:mode.pic setFoodText:mode.scene setName:mode.title setComment:mode.comment setIntroduction:mode.num[1] setPrice:4 setOnecomment:mode.num[0] setInstance:mode.distance setLike:@"喜欢"];
        return _sectionOneCell2;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        if (_nearAddrHeaderView==nil) {
            _nearAddrHeaderView=[[NearAddrHeaderView alloc]init];
        }
        _nearAddrHeaderView.bigLabel.text=@"近";
        _nearAddrHeaderView.timelabel.text=@"白天";
        _nearAddrHeaderView.weatherImageView.image=[UIImage imageNamed:@"晴天"];
        _nearAddrHeaderView.addrLabel.text=@"碑林区东二环西安理工大学";
        return _nearAddrHeaderView;
    }
    if (section==1) {
        //调用xib必须要写的
        _nearSectionTwoHeader=[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([NearSectionTwoHeader class]) owner:self options:nil] lastObject];
        return _nearSectionTwoHeader;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
//设置单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0 ) {
            return SCWIDTH+200;
        }
    }
        return 500;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

//监听tableview向上滑动还是向下滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint point=[scrollView.panGestureRecognizer translationInView:scrollView];
    CGFloat offsetY=point.y;
    NSLog(@"tableview偏移量为==%f",_nearTableView.contentOffset.y);
    if (offsetY<0) {
        NSLog(@"上滑");
        if (_nearTableView.contentOffset.y<690) {
            //设置动画来解决没有动画d滑动到指定地点过慢的问题
            __weak typeof(_nearTableView) weakNearTableView=_nearTableView;
            [UIView animateWithDuration:0.5 animations:^{
                [weakNearTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            } completion:^(BOOL finished) {
                
            }];
            
        }
    }else{
        NSLog(@"下滑");
        if (_nearTableView.contentOffset.y<690) {
            //设置动画来解决没有动画d滑动到指定地点过慢的问题
            __weak typeof(_nearTableView) weakNearTableView=_nearTableView;
            [UIView animateWithDuration:0.5 animations:^{
                [weakNearTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            } completion:^(BOOL finished) {
                
            }];
            
        }
    }
}
@end
