//
//  SJBTopicTableViewController.m
//  小白
//
//  Created by zyyt on 16/7/5.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBTopicTableViewController.h"
#import "SJBTopicModel.h"
#import "SJBTopicCell.h"
#import "UMSocial.h"
#import "UMSocialData.h"
#import "SJBShowTopicController.h"

@class SJBNewViewController;

@interface SJBTopicTableViewController ()<SJBTopicCellDelegate,UMSocialUIDelegate>
@property (nonatomic,strong)NSMutableArray * dataSouce;

@property (nonatomic,assign)NSInteger page;

@property (nonatomic,copy)NSString * maxtime;

@property (nonatomic,strong)NSDictionary * params;

@property (nonatomic,copy)NSString *a;

@end

@implementation SJBTopicTableViewController

- (NSMutableArray *)dataSouce
{
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self setUpTableView];
}

- (void)setUpTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter   footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.automaticallyHidden = YES;
    
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.view.backgroundColor = [UIColor whiteColor];
      
    }else{
    
        self.tableView.backgroundColor =  SJBRGBColor(21, 21, 21);
        self.view.backgroundColor =  SJBRGBColor(21, 21, 21);
       }
    
    [self.tableView reloadData];
    
}

- (void)loadNewData
{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(0);
    self.page = 0;
    self.params = params;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:Main_URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
  
        [self.dataSouce removeAllObjects];
        
        for (int i=0; i<[responseObject[@"list"] count]; i++) {
            SJBTopicModel * model = [[SJBTopicModel alloc] init];
            [model setValuesForKeysWithDictionary:responseObject[@"list"][i]];
            [self.dataSouce addObject:model];
        }
        
        self.maxtime = [[responseObject objectForKey:@"info"] objectForKey:@"maxtime"];
        [self.tableView reloadData];

        self.page ++ ;
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
    }];
}

- (NSString*)a{

   // BOOL * isNO = [self isKindOfClass:NSClassFromString(@"SJBNewViewController")];
    
    return [self.parentViewController isKindOfClass:NSClassFromString(@"SJBNewViewController")]?@"newlist":@"list";
}


- (void)loadMoreData
{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];

    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
  
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:Main_URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if (self.params != params) {
            return ;
        }
        //[self.dataSouce removeAllObjects];
        
        for (int i=0; i<[responseObject[@"list"] count]; i++) {
            SJBTopicModel * model = [[SJBTopicModel alloc] init];
            [model setValuesForKeysWithDictionary:responseObject[@"list"][i]];
            [self.dataSouce addObject:model];
        }
        self.page ++ ;
        self.maxtime = [[responseObject objectForKey:@"info"] objectForKey:@"maxtime"];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SJBTopicCell * cell =[SJBTopicCell tableViewRegisterCellWithTableview:tableView];
    
    
    SJBTopicModel * model = [self.dataSouce objectAtIndex:indexPath.row];
   
        cell.model = model;

    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJBTopicModel * topic = [self.dataSouce objectAtIndex:indexPath.row];
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJBShowTopicController * vc = [[SJBShowTopicController alloc] initWithNibName:NSStringFromClass([SJBShowTopicController class]) bundle:nil];
    vc.topic = [self.dataSouce objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

- (void)shrewith:(SJBTopicModel*)topic{
 
    
    switch (topic.type) {
        case SJBTopicTypeWord:{
            
            [UMSocialData defaultData].extConfig.title = [NSString stringWithFormat:@"%@",topic.name];
            
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:UMSocialKey
                                              shareText:topic.text
                                             shareImage:[UIImage imageNamed:@"AppIcon"]
                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToSms]
                                               delegate:self];
        }
            
            break;
            
       
            case SJBTopicTypeVideo:
        {
              [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:topic.small_image];
           
            [UMSocialData defaultData].extConfig.title = [NSString stringWithFormat:@"%@",topic.name];
          
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:UMSocialKey
                                              shareText:[NSString stringWithFormat:@"%@,视频地址:%@",topic.text,topic.videouri]
                                             shareImage:[UIImage imageNamed:@"AppIcon"]
                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToSms]
                                               delegate:self];
        }
            break;
        case SJBTopicTypeVoice:{
            
               [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:topic.small_image];
            [UMSocialData defaultData].extConfig.title = [NSString stringWithFormat:@"%@",topic.name];
        
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:UMSocialKey
                                              shareText:[NSString stringWithFormat:@"%@,视频地址:%@",topic.text,topic.voiceuri]
                                             shareImage:[UIImage imageNamed:@"AppIcon"]
                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToSms]
                                               delegate:self];

        }
            break;
        case SJBTopicTypePicture:{
            [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:topic.small_image];
            [UMSocialData defaultData].extConfig.title = [NSString stringWithFormat:@"%@",topic.name];
            
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:UMSocialKey
                                              shareText:topic.text
                                             shareImage:[UIImage imageNamed:@"AppIcon"]
                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToSms]
                                               delegate:self];
        }
            break;
            
        default:
            break;
    }
  

}


@end
