//
//  SJBMyModel.m
//  小白
//
//  Created by zyyt on 16/7/18.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBMyModel.h"

@implementation SJBMyModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = (NSInteger)value;
    }
}

@end
