//
//  SJBCategaryModel.m
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBCategaryModel.h"

@implementation SJBCategaryModel

- (NSMutableArray *)userArrM
{
    if (_userArrM == nil) {
        _userArrM = [NSMutableArray array];
    }
    return _userArrM;
}

@end
