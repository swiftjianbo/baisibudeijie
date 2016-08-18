//
//  SJBPublishBarButtonItem.m
//  小白
//
//  Created by zyyt on 16/7/15.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBPublishBarButtonItem.h"

@implementation SJBPublishBarButtonItem

 + (__kindof UIBarButtonItem*)leftItemTitle:(NSString*)title font:(NSInteger)font  color:(UIColor*)color  highStateColor:(UIColor*)highStateColor target:(id)target action:(SEL)selector
{
      UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
      [button setTitle:title forState:UIControlStateNormal];
      button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
     [button setTitleColor:(color?color:[UIColor blackColor]) forState:UIControlStateNormal];
     [button setTitleColor:highStateColor?highStateColor:[UIColor grayColor] forState:UIControlStateHighlighted];
     [button sizeToFit];

     [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:highStateColor?highStateColor:[UIColor grayColor] forState:UIControlStateDisabled];
     UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}

+ (__kindof UIBarButtonItem*)rightItemTitle:(NSString*)title font:(NSInteger)font  color:(UIColor*)color  highStateColor:(UIColor*)highStateColor target:(id)target action:(SEL)selector
{

    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [button setTitleColor:(color?color:[UIColor blackColor]) forState:UIControlStateNormal];
    [button setTitleColor:highStateColor?highStateColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button sizeToFit];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;

}



@end
