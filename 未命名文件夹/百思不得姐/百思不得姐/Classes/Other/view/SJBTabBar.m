//
//  SJBTabBar.m
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBTabBar.h"

@interface SJBTabBar ()
@property (nonatomic,weak)UIButton * publishBtn;
@end

@implementation SJBTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
  
        UIButton * publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[[UIImage imageNamed:@"tabBar_publish_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[[UIImage imageNamed:@"tabBar_publish_click_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [publishButton addTarget:self action:@selector(publishBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishBtn = publishButton;
     
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.publishBtn.size = self.publishBtn.currentBackgroundImage.size;
    self.publishBtn.center = CGPointMake(self.width/2, self.height/2);
    
    int index = 0;
    
    CGFloat W = self.width/5;
    CGFloat H = self.height;
    CGFloat Y = 0;

    for (UIView * view in self.subviews) {
        
        if (![view isKindOfClass:[UIControl class]] || view == self.publishBtn)
            continue;
        
        view.frame  =   index <= 1? CGRectMake(W * index, Y, W, H): CGRectMake(W * (index+1), Y, W, H);
        
        index ++;
        
    }
}

- (void)publishBtnDidClicked:(UIButton*)publishBtn
{
        if ([self.delegat respondsToSelector:@selector(publishButtonDidClicked)]) {
            [self.delegat publishButtonDidClicked];
        }
    
}



@end
