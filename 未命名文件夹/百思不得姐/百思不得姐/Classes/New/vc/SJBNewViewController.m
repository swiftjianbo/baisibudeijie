//
//  SJBNewViewController.m
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBNewViewController.h"
#import "SJBTagsController.h"

@implementation SJBNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = SJBGlobalBgColor;

    self.navigationItem.title = @"新帖";
}

- (void)leftBarButtonItemAction
{
    SJBTagsController * tags = [[SJBTagsController alloc] initWithNibName:NSStringFromClass([SJBTagsController class]) bundle:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tags animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
