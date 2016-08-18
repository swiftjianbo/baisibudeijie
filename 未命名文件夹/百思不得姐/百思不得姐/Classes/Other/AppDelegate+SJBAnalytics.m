//
//  AppDelegate+SJBAnalytics.m
//  小白
//
//  Created by zyyt on 16/7/19.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "AppDelegate+SJBAnalytics.h"
#import "UMMobClick/MobClick.h"


@implementation AppDelegate (SJBAnalytics)

+ (void)setupUmengAnalytics
{
    UMConfigInstance.appKey = UmengAnalyticsKey;
    UMConfigInstance.channelId = @"App Store";
   // UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
 
    [MobClick startWithConfigure:UMConfigInstance];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
}


@end
