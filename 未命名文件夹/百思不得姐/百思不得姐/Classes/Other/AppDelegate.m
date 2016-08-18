//
//  AppDelegate.m
//  小白
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "AppDelegate.h"
#import "SJBTabBarController.h"
#import "SJBGuidView.h"
#import "AppDelegate+SJBJPush.h"
#import "AppDelegate+SJBShare.h"
#import "AppDelegate+SJBAnalytics.h"
#import "JPUSHService.h"
#import <iflyMSC/iflyMSC.h>



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor  = [UIColor whiteColor];
    self.window.rootViewController = [[SJBTabBarController alloc] init];
    
    [AppDelegate setUpJPushWithOptions:launchOptions];
   // [AppDelegate setUpUMSocial];
    //[AppDelegate setupIFLy];
    [AppDelegate setupUmengAnalytics];
    
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
    }else{
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundN-44"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:SJBRGBColor(91, 91, 91)}];

        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    }
    
    
    
    [self setupIfly];
   
    [self.window makeKeyAndVisible];
    

    [SJBGuidView show];


    return YES;
}

- (void)setupIfly
{
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_ALL];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:NO];
    
    //设置sdk的工作路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    
    NSString * initString = [[NSString alloc] initWithFormat:@"appid=%@",IFlyKey];
    [IFlySpeechUtility createUtility:initString];
    

}

//当收到Received memory warning.会调用次方法
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    //取消下载
    [mgr cancelAll];
    //清空缓存
    [mgr.imageCache clearMemory];
    
}


@end
