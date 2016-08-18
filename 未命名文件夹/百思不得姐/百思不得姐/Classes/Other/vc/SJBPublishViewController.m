//
//  SJBPublishViewController.m
//  小白
//
//  Created by zyyt on 16/7/6.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBPublishViewController.h"
#import "SJBVerticalButton.h"
#import "SJBPublishTextController.h"


@interface SJBPublishViewController ()

@end

@implementation SJBPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    UIImageView * appSlogn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    appSlogn.x =  [UIScreen mainScreen].bounds.size.width/2 - 101;
    appSlogn.y =  [UIScreen mainScreen].bounds.size.height * 0.2;
    [self.view addSubview:appSlogn];
    [self.view bringSubviewToFront:appSlogn];
    
    NSArray * imageNames = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray * titleNames = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"发链接"];
    
    CGFloat imageH = 72;
    CGFloat imageW = 72;
    
    CGFloat buttonH =   imageH + 30;
    CGFloat buttonW = imageW;
    
    CGFloat startY = [UIScreen mainScreen].bounds.size.height/2 - buttonH  - 10 ;
    
    CGFloat startX = 15;
    
  CGFloat      buttonMargin =  (([UIScreen mainScreen].bounds.size.width - 30) - (buttonW * 3)) /2;
//
    for (int i=0; i<imageNames.count; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleNames[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        button.tag = 100 + i;
        button.frame = CGRectMake(startX + (buttonW + buttonMargin)  *( i%3), startY + (buttonH + 20)*(i/3), buttonW, buttonH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }
    
    
    
}

- (void)buttonClick:(UIButton*)btn{
    
    int    indexTag = (int)btn.tag - 100;
    
    switch (indexTag) {
        case 0:{
            
        }
        
            break;
        case 1:{
            
        }
            
            break;
        case 2:{
          
            SJBPublishTextController * vc = [[SJBPublishTextController alloc] init];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            UIViewController * root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
            
        }
            
            break;
        case 3:{
            
        }
            
            break;
        case 4:{
            
        }
            
            break;
        case 5:{
            
        }
            
            break;
            
        default:
            break;
    }
    
    
}


- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

@end
