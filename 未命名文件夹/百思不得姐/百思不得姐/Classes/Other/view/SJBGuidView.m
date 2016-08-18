//
//  SJBGuidView.m
//  小白
//
//  Created by zyyt on 16/6/28.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBGuidView.h"

#define AppVersion [NSBundle mainBundle].infoDictionary[versionKey]

@interface SJBGuidView ()

@end

static NSString * const versionKey = @"CFBundleShortVersionString";

@implementation SJBGuidView


+ (instancetype)guidView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

+ (void)show
{
    
    SJBGuidView * guidView = [SJBGuidView guidView];
    
    NSString * version = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
    if (![version isEqualToString:AppVersion]) {
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        guidView.frame = window.bounds;
        [window addSubview:guidView];
        [[NSUserDefaults standardUserDefaults] setObject:AppVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
  
    
}

- (IBAction)closeGuidView:(id)sender {
    
    [self removeFromSuperview];
}

@end
