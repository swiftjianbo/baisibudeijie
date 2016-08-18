//
//  AppDelegate+SJBJPush.h
//  小白
//
//  Created by zyyt on 16/7/5.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (SJBJPush)

+ (void)setUpJPushWithOptions:(NSDictionary *)launchOptions;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

@end
