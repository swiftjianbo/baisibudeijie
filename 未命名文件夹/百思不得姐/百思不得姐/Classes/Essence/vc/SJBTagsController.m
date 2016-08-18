//
//  SJBTagsController.m
//  小白
//
//  Created by zyyt on 16/6/28.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBTagsController.h"
#import "SJBTagsModel.h"
#import "SJBTagCell.h"

@interface SJBTagsController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray * dataSouce;

@end

@implementation SJBTagsController

- (NSMutableArray *)dataSouce
{
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.tableview.backgroundColor = [UIColor whiteColor];
    }else{
        self.view.backgroundColor = SJBRGBColor(21, 21, 21);
        self.tableview.backgroundColor = SJBRGBColor(21, 21, 21);
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUptableview];
    
    [self addMJRefresh];
    
    [self.tableview.mj_header beginRefreshing];
}

- (void)addMJRefresh{
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
}

- (void)requestData
{
    
    NSMutableDictionary * patams = [NSMutableDictionary dictionary];
    patams[@"a"] = @"tag_recommend";
    patams[@"action"] = @"sub";
    patams[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:Main_URL parameters:patams progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * arr = responseObject;
        [self.dataSouce removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            SJBTagsModel * modle = [[SJBTagsModel alloc] init];
            [modle setValuesForKeysWithDictionary:arr[i]];
            [self.dataSouce addObject:modle];
        }
        [self.tableview.mj_header endRefreshing];
        [self.tableview reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)setUptableview
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.rowHeight = 70;
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([SJBTagCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([self.tableview class])];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJBTagCell * cell = [SJBTagCell getTableViewcellWithTableView:tableView];
    cell.tagModel = [self.dataSouce objectAtIndex:indexPath.row];
    return cell;
}

@end
