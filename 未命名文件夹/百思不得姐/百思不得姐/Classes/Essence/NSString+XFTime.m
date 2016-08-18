//
//  NSString+XFTime.m
//  小白
//
//  Created by zyyt on 16/7/14.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "NSString+XFTime.h"

@implementation NSString (XFTime)
+ (NSString *)stringWithTime:(NSTimeInterval)time {
    
    NSInteger min = time / 60;
    NSInteger second = (NSInteger)time % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld", min, second];
}
@end
