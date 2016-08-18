//
//  SJBNavigationController.m
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBNavigationController.h"

@implementation SJBNavigationController

+ (void)initialize
{
    UIImage * bgImage = [[UIImage imageNamed:@"navigationbarBackgroundWhite"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    [[UINavigationBar appearance] setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        //日间
        [self button:button SetImageWithColor:[UIColor blackColor] highlightedColor:[UIColor redColor] imageName:@"navigationButtonReturn" highlightedImage:@"navigationButtonReturnClick"];
        
            }else{
                 [self button:button SetImageWithColor:SJBRGBColor(91, 91, 91) highlightedColor:[UIColor redColor] imageName:@"navigationButtonReturnN" highlightedImage:@"navigationButtonReturnClickN"];
           }
   
    button.size = CGSizeMake(70, 30);
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //        [button sizeToFit];
    // 让按钮的内容往左边偏移10
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    // 修改导航栏左边的item
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    // 隐藏tabbar
    viewController.hidesBottomBarWhenPushed = YES;
}

// 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
[super pushViewController:viewController animated:animated];

}

- (void)button:(UIButton*)btn  SetImageWithColor:(UIColor*)color highlightedColor:(UIColor*)highlightedColor  imageName:(NSString*)imageName highlightedImage:(NSString*)highlightedImageName
{
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:highlightedColor  forState:UIControlStateHighlighted];

}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
