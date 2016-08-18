//
//  SJBTabBar.h
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJBTabBar;

@protocol SJBTabBarDelegate <NSObject>

- (void)publishButtonDidClicked;

@end

@interface SJBTabBar : UITabBar

@property (nonatomic,weak)id<SJBTabBarDelegate>delegat;



@end
