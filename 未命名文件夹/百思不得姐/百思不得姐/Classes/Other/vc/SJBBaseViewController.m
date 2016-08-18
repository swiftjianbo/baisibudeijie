//
//  SJBBaseViewController.m
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBBaseViewController.h"
#import "SJBBarButtonItem.h"

@interface SJBBaseViewController ()

@end

@implementation SJBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [SJBBarButtonItem creatBarButtonItemWithImage:@"MainTagSubIcon" selectImage:@"MainTagSubIconClick" target:self action:@selector(leftBarButtonItemAction)];

  

}


- (void)leftBarButtonItemAction
{
    SJBLog(@"leftBarButtonItemAction");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
