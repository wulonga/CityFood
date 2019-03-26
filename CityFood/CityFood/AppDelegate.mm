//
//  AppDelegate.m
//  CityFood
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 Gooou. All rights reserved.
//



#import "AppDelegate.h"
#import "ContainerViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface AppDelegate ()
@property(nonatomic,strong)CLLocationManager *locationService;
@end

BMKMapManager* _mapManager;
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"CbOta9kOw4nIlibPLCpv5cTsb9c6ckCb" authDelegate:self];
    BOOL ret = [_mapManager start:@"CbOta9kOw4nIlibPLCpv5cTsb9c6ckCb" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    self.window.rootViewController=[[UINavigationController new]initWithRootViewController:[ContainerViewController new]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    return YES;
}
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError
{
    NSLog(@"location auth onGetPermissionState %ld",(long)iError);
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
