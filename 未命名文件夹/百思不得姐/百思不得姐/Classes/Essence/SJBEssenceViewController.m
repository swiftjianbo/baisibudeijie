//
//  SJBEssenceViewController.m
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBEssenceViewController.h"
#import "SJBTagsController.h"
#import "SJBTopicTableViewController.h"


@interface SJBEssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIButton * selectedButton;
@property (nonatomic,strong)UIView * indicatorView;

@property (nonatomic,strong)UIScrollView * contentView;

@property (nonatomic,weak)UIView * titlesView;

@end

@implementation SJBEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = SJBGlobalBgColor;

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    [self setUpTitlesView];
   
    [self setUpViewControllers];

    
    [self setContentView];
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        self.view.backgroundColor = [UIColor whiteColor];

    }else{
        self.view.backgroundColor = SJBRGBColor(21, 21, 21);

    }
    
}

- (void)setUpTitlesView
{
    UIView * titleView = [[UIView alloc] init];
    titleView.x = 0;
    titleView.y = self.navigationController.navigationBar.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    titleView.width = self.view.bounds.size.width;
    titleView.height = 35;
    titleView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
      [self.view addSubview:titleView];
    self.titlesView = titleView;
    NSArray * titles = @[@"全部",@"视频",@"音频",@"图片",@"段子"];
    CGFloat width = self.view.width/5;
    CGFloat height = titleView.height;
    CGFloat y = 0;
    
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.backgroundColor = [UIColor redColor];
    self.indicatorView.height = 2;
    self.indicatorView.y = titleView.height;
    [titleView addSubview:self.indicatorView];
    
    for (int i=0; i<titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width, y, width, height);
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(titleViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        if (0 == i) {
            [button layoutIfNeeded];
           
            [self titleViewButtonAction:button];
            
        }
        
    }
    
   
   }

- (void)setContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.contentView.pagingEnabled = YES;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.delegate = self;
    self.contentView.contentSize = CGSizeMake(self.view.width * 5, 0);
  
    [self.view insertSubview:self.contentView atIndex:0];
     [self scrollViewDidEndScrollingAnimation:self.contentView];
}

- (void)titleViewButtonAction:(UIButton*)btn
{
    self.selectedButton.enabled = YES;
    
    btn.enabled = NO;
    self.selectedButton = btn;
    SJBFunction;
    
 
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = btn.titleLabel.width;
        self.indicatorView.centerX = btn.center.x;
        self.indicatorView.centerY = self.indicatorView.superview.height - 1;
        
    }];
    CGPoint offset = self.contentView.contentOffset;
    offset.x = (btn.tag - 100) * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}


- (void)setUpViewControllers
{
    SJBTopicTableViewController * all = [[SJBTopicTableViewController alloc] init];
    all.type = SJBTopicTypeAll;
    [self addChildViewController:all];
    
    SJBTopicTableViewController * video = [[SJBTopicTableViewController alloc] init];
    video.type = SJBTopicTypeVideo;

    [self addChildViewController:video];

    
    SJBTopicTableViewController * voice = [[SJBTopicTableViewController alloc] init];
    voice.type = SJBTopicTypeVoice;
    [self addChildViewController:voice];

    
    SJBTopicTableViewController * picture = [[SJBTopicTableViewController alloc] init];
    picture.type = SJBTopicTypePicture;
    [self addChildViewController:picture];

    SJBTopicTableViewController * word = [[SJBTopicTableViewController alloc] init];
    word.type = SJBTopicTypeWord;
    [self addChildViewController:word];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger  index = scrollView.contentOffset.x/scrollView.width;
    
    UIButton * btn = [self.titlesView viewWithTag:index + 100];
    [self titleViewButtonAction:btn];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}


//重写父类的方法
- (void)leftBarButtonItemAction
{
    SJBTagsController * tags = [[SJBTagsController alloc] initWithNibName:NSStringFromClass([SJBTagsController class]) bundle:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tags animated:YES];
    self.hidesBottomBarWhenPushed = NO;
   
}

@end
