//
//  SJBTabBarController.m
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBTabBarController.h"
#import "SJBEssenceViewController.h"
#import "SJBNewViewController.h"
#import "SJBFriendTrendsViewController.h"
#import "SJBMeViewController.h"
#import "SJBNavigationController.h"
#import "SJBTabBar.h"
#import "SJBPublishViewController.h"

@interface SJBTabBarController ()<SJBTabBarDelegate>

@end

@implementation SJBTabBarController

+ (void)initialize
{
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
         [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateSelected];
    }else{
         [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    }
    
   
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSubViewControllers];
 
    SJBTabBar * tabBar = [[SJBTabBar alloc] init];
    tabBar.delegat = self;
   
    
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        
        [tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
    }else{
              [tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-lightN"]];
    }


    
    [self setValue:tabBar forKeyPath:@"tabBar"];

}

- (void)addSubViewControllers
{
    NSArray * dayMode = @[@"tabBar_essence_icon",@"tabBar_new_icon",@"tabBar_friendTrends_icon",@"tabBar_me_icon"];
    NSArray * dayModeSelect = @[@"tabBar_essence_click_icon",@"tabBar_new_click_icon",@"tabBar_friendTrends_click_icon",@"tabBar_me_click_icon"];
    NSArray * nightMode = @[@"tabBar_essence_iconN",@"tabBar_new_iconN",@"tabBar_friendTrends_iconN",@"tabBar_me_iconN"];
    NSArray * nightModeSelect = @[@"tabBar_essence_click_iconN",@"tabBar_new_click_iconN",@"tabBar_friendTrends_click_iconN",@"tabBar_me_click_iconN"];
    
    
    NSArray * imageNames = [NSArray array];
    NSArray * selectImageNames = [NSArray array];
    
    
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        imageNames = dayMode;
        selectImageNames = dayModeSelect;
        
        [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    
    }else{
        imageNames = nightMode;
        selectImageNames = nightModeSelect;
         [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-lightN"]];
    }
    
    
    [self addChildViewController:[[SJBEssenceViewController alloc] init] titile:@"精华" image:[imageNames  objectAtIndex:0] selectImage:[selectImageNames objectAtIndex:0]];
     [self addChildViewController:[[SJBNewViewController alloc] init] titile:@"新帖" image:[imageNames  objectAtIndex:1] selectImage:[selectImageNames objectAtIndex:1]];
     [self addChildViewController:[[SJBFriendTrendsViewController alloc] init] titile:@"关注" image:[imageNames  objectAtIndex:2] selectImage:[selectImageNames objectAtIndex:2]];
     [self addChildViewController:[[SJBMeViewController alloc] init] titile:@"我的" image:[imageNames  objectAtIndex:3] selectImage:[selectImageNames objectAtIndex:3]];
    
}

- (void)addChildViewController:(UIViewController *)childController titile:(NSString*)title image:(NSString*)imageName selectImage:(NSString*)selectImageName{
    
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   // SJBNavigationController * naVc = [;
    [self addChildViewController:[[SJBNavigationController alloc] initWithRootViewController:childController]];

}

- (void)publishButtonDidClicked
{
    
    SJBPublishViewController * vc = [[SJBPublishViewController alloc] init];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:nil];
}

@end
