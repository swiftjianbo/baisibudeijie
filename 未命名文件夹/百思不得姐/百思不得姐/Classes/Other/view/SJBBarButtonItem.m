//
//  SJBBarButtonItem.m
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBBarButtonItem.h"

@implementation SJBBarButtonItem

+ (instancetype)creatBarButtonItemWithImage:(NSString *)imageName selectImage:(NSString *)selectImageName target:(id)target action:(SEL)selector
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
  
    [button setBackgroundImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
   
     [button setBackgroundImage:[[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    
     [button addTarget:target  action:selector forControlEvents:UIControlEventTouchUpInside];
   
      button.size = button.currentBackgroundImage.size;
    
      return  [[SJBBarButtonItem alloc] initWithCustomView:button];

}

+ (instancetype)creatBarButtonItemWithTitleName:(NSString *)title target:(id)target action:(SEL)selector
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button addTarget:target  action:selector forControlEvents:UIControlEventTouchUpInside];
    
    [button sizeToFit];
    
    return  [[SJBBarButtonItem alloc] initWithCustomView:button];
}

@end
