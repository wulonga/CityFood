//
//  ChoiceViewController.m
//  CityFood
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 Gooou. All rights reserved.
//

#import "ChoiceViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationKit/BMKLocationComponent.h>
#import "MyLocation.h"
#import "MyAnnotation.h"
@interface ChoiceViewController ()<BMKMapViewDelegate,BMKLocationManagerDelegate>
{
    BMKMapView *_mapView;
}
@property(nonatomic, strong) BMKLocationManager *locationManager;
@property(nonatomic, copy) BMKLocatingCompletionBlock completionBlock;

@end

@implementation ChoiceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [_mapView setZoomLevel:17];//设置地图显示缩放等级
    _mapView.showMapScaleBar=YES;
    _mapView.showsUserLocation=YES;
    _mapView.userTrackingMode=BMKUserTrackingModeHeading;
    _mapView.mapScaleBarPosition=CGPointMake(self.view.frame.size.width-60,self.view.frame.size.height-100);
    [self.view addSubview:_mapView];
    
    //添加两个大头针
    MyAnnotation *anno0=[[MyAnnotation alloc]init];
    anno0.coordinate=CLLocationCoordinate2DMake(34.258686, 108.999981);
    anno0.title=@"全聚德";
    anno0.subtitle=@"全北京最好的烤鸭店";
    anno0.icon=@"定位红";
    [_mapView addAnnotation:anno0];
    
    MyAnnotation *anno1=[[MyAnnotation alloc]init];
    anno1.coordinate=CLLocationCoordinate2DMake(34.258232, 108.999190);
    anno1.title=@"万达影院";
    anno1.subtitle=@"全中国最顶尖的观影圣地";
    anno1.icon=@"定位红";
    [_mapView addAnnotation:anno1];
    
    //给地图添加一个长按手势
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [_mapView addGestureRecognizer:longPress];
    
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60,self.view.frame.size.height-300, 30, 30)];
    button.titleLabel.text=@"点击";
    button.backgroundColor=[UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    [self initBlock];
    [self initLocation];
    [self btnClick];
    //结束定位
    //[locationManager stopUpdatingLocation];
}
-(void)longPress:(UILongPressGestureRecognizer *)sender
{
    //获取当前位置
    CGPoint location = [sender locationInView:self.view];
    //经纬度
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:location toCoordinateFromView:_mapView];
    //创建新的标注
    MyAnnotation *annotation = [[MyAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = @"新标注";
    annotation.subtitle = @"待开发...";

    //添加标注
    [_mapView addAnnotation:annotation];
}
-(void)initBlock
{
    __weak ChoiceViewController *weakSelf = self;
    self.completionBlock = ^(BMKLocation *location, BMKLocationNetworkState state, NSError *error)
    {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
        }
    
        if (location.location) {//得到定位信息，添加annotation
            
            NSLog(@"LOC = %@",location.location);
            NSLog(@"LOC ID= %@",location.locationID);
            BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
            
            pointAnnotation.coordinate = location.location.coordinate;
            pointAnnotation.title = @"单次定位";
            if (location.rgcData) {
                pointAnnotation.subtitle = [location.rgcData description];
            } else {
                pointAnnotation.subtitle = @"rgc = null!";
            }
            
            ChoiceViewController *strongSelf = weakSelf;
            
            [strongSelf updateMessage:[NSString stringWithFormat:@"当前位置信息： \n经纬度：%.6f,%.6f \n地址信息：%@ \n网络状态：%d",location.location.coordinate.latitude, location.location.coordinate.longitude, [location.rgcData description], state]];
            
            //[_mapView a];
            MyLocation * loc = [[MyLocation alloc]initWithLocation:location.location whitHeading:nil];
            [strongSelf addLocToMapView:loc];
            
        }
        
        if (location.rgcData) {
            NSLog(@"rgc = %@",[location.rgcData description]);
        }
        
        NSLog(@"netstate = %d",state);
    };
    
    
}
-(void)updateMessage:(NSString *)msg
{
    NSLog(@"定位======%@",msg);
    
}
- (void)addLocToMapView:(MyLocation *)loc
{
    [_mapView updateLocationData:loc];
    [_mapView setCenterCoordinate:loc.location.coordinate animated:YES];
}
- (void)addAnnotationToMapView:(BMKPointAnnotation *)annotation
{
    [_mapView addAnnotation:annotation];
}
-(void)initLocation
{
    _locationManager = [[BMKLocationManager alloc] init];
    
    _locationManager.delegate = self;
    
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    _locationManager.allowsBackgroundLocationUpdates = YES;
    _locationManager.locationTimeout = 10;
    _locationManager.reGeocodeTimeout = 10;
    
}
-(void)btnClick{
    //开始定位
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:self.completionBlock];
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    _locationManager = nil;
    _completionBlock = nil;
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    static NSString *ID=@"annoView";
    BMKAnnotationView *annoView=[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annoView==nil) {
        annoView=[[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID];
        //点击大头针出现信息（自定义view的大头针默认点击不弹出）
        annoView.canShowCallout=YES;
    }
    //再传递一次annotation模型（赋值）
    annoView.annotation=annotation;
    MyAnnotation *anno=annotation;
    annoView.image=[UIImage imageNamed:anno.icon];
    
    return annoView;
}
#pragma mark 选中了标注的处理事件
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    NSLog(@"选中了标注");
}

#pragma mark 取消选中标注的处理事件
-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    NSLog(@"取消了标注");
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.showsUserLocation = YES;
}
-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

@end
