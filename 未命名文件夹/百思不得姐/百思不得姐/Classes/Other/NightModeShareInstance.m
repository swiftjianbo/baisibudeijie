//
//  NightModeShareInstance.m
//  夜间模式2
//
//  Created by zyyt on 16/7/27.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "NightModeShareInstance.h"


static NightModeShareInstance * instance;

@implementation NightModeShareInstance

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NightModeShareInstance alloc] init];
        
        NSNumber * num = [[NSUserDefaults standardUserDefaults] objectForKey:@"night"];
        
        if (num) {
            instance.mode = [num intValue];
        }else
   instance.mode = NightModeDay;
        
    });
    return instance;
}

- (void)setMode:(NightMode)mode
{
    _mode = mode;
    
    [[NSUserDefaults standardUserDefaults] setObject:@(mode) forKey:@"night"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (UIColor *)commonTextColor
{
    switch (self.mode) {
        case NightModeDay:
            return [UIColor blackColor];
            break;
           
        case NightModeNight:
            return SJBRGBColor(200, 200, 200);
            break;
            
        default:
            break;
    }
}


- (UIColor *)commonBgColor
{
    switch (self.mode) {
        case NightModeDay:
            return [UIColor whiteColor];
            break;
            
        case NightModeNight:
            return [UIColor grayColor];
            break;
            
        default:
            break;
    }

}

- (UIImage*)commonTabBarImage
{
    switch (self.mode) {
        case NightModeDay:
            return [UIImage imageNamed:@"2"];
            break;
            
        case NightModeNight:
            return [UIImage imageNamed:@"1"];
            break;
            
        default:
            break;
    }

}

@end
