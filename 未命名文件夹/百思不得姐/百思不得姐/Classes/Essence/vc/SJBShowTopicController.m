//
//  SJBShowTopicController.m
//  小白
//
//  Created by zyyt on 16/7/14.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBShowTopicController.h"
#import "SJBTopicCell.h"
#import "SJBTopicModel.h"
#import "SJBConment.h"
#import "SJBCommentCell.h"

@interface SJBShowTopicController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray <SJBConment *>* commentData;

@property (nonatomic,strong)NSMutableArray <SJBConment *> * hotCommentData;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) IBOutlet UIView *bottomToolBar;

@property (weak, nonatomic) IBOutlet UIButton *sendVoice;

@property (weak, nonatomic) IBOutlet UIButton *addFriend;

@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)AFHTTPSessionManager * manager;

@property (nonatomic,assign)NSInteger total;


@end

static NSString * const cellID = @"Comment";

@implementation SJBShowTopicController

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
        return _manager;
}

- (NSMutableArray *)commentData
{
    if (_commentData == nil) {
        _commentData = [NSMutableArray array];
    }
    return _commentData;
}

- (NSMutableArray *)hotCommentData
{
    if (_hotCommentData == nil) {
        _hotCommentData = [NSMutableArray array];
    }
    return _hotCommentData;
}

- (void)viewDidLoad {
    [super viewDidLoad];

  
    [self addNotification];
    
    [self setupNav];
    
    [self setTableviewHerder];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SJBCommentCell class]) bundle:nil] forCellReuseIdentifier:cellID];
   
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self  setupTableViewHeaderAndFooter];
    
}

- (void)setupTableViewHeaderAndFooter
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

- (void)requestData
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
      [self.manager GET:Main_URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
          
      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          [self.tableView.mj_header endRefreshing];
          if ( self.topic.comment == 0)   return   ;
          
          NSLog(@"%@",responseObject);
          
          [self.hotCommentData removeAllObjects];
          [self.commentData removeAllObjects];
          
         
              NSArray * hotComment = [responseObject objectForKey:@"hot"];
              for (int i=0; i<hotComment.count; i++) {
                  SJBConment * model = [[SJBConment alloc] init];
                  [model setValuesForKeysWithDictionary:hotComment[i]];
                  [self.hotCommentData addObject:model];
              }
              
              
              NSArray * comment = [responseObject objectForKey:@"data"];
              for (int i=0; i<comment.count; i++) {
                  SJBConment * model = [[SJBConment alloc] init];
                  [model setValuesForKeysWithDictionary:comment[i]];
                  // [model.user setValuesForKeysWithDictionary:comment[i][@"user"] ];
                  [self.commentData addObject:model];
              }
              [self.tableView reloadData];

          
          
          NSInteger total = [responseObject[@"total"] integerValue];
          if (self.commentData.count >= total) { // 全部加载完毕
              self.tableView.mj_footer.hidden = YES;
          } else {
              // 结束刷新状态
              [self.tableView.mj_footer endRefreshing];
          }
          
          
           self.page = 1;
          
          
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          [self.tableView.mj_header endRefreshing];

      }];
}

- (void)loadMoreComments
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 页码
    NSInteger page = self.page + 1;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    SJBConment *cmt = [self.commentData lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:Main_URL  parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }  success:^(NSURLSessionDataTask *task, id responseObject) {
        // 没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        
        // 最新评论
     
        NSArray * commentnewData = [responseObject objectForKey:@"data"];
        for (int i=0; i<commentnewData.count; i++) {
            SJBConment * model = [[SJBConment alloc] init];
            [model setValuesForKeysWithDictionary:commentnewData[i]];
           
            [self.commentData addObject:model];
        }

     
        // 页码
        self.page = page;
        
        // 刷新数据
        [self.tableView reloadData];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.commentData.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)setupNav
{
    self.navigationItem.title = @"评论";
    
//    self.navigationItem.rightBarButtonItem
}


- (void)setTableviewHerder{
    
  //  UIView * header = [[UIView alloc] init];
    
   SJBTopicCell * cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SJBTopicCell class]) owner:nil options:nil] lastObject];
    cell.model = self.topic;
    
    cell.height = self.topic.cellHeight;
    
  //  [header addSubview:cell];
    
    self.tableView.tableHeaderView = cell;
    
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJBConment * model = [self getmodelIndexPath:indexPath];
    return model.cellHeight;
}

//添加获取键盘升起或落下的通知
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//监听键盘的出现
- (void)keyboardWillShow:(NSNotification*)noti
{
     self.bottomConstraint.constant = 258;
    [UIView animateWithDuration:0.25 animations:^{
       
        [self.bottomToolBar layoutIfNeeded];
        
    }];
}

//监听键盘的隐藏
- (void)keyboardWillHide:(NSNotification*)noti
{
    self.bottomConstraint.constant = 0;
   
    [UIView animateWithDuration:0.25 animations:^{
            [self.bottomToolBar layoutIfNeeded];
            }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - TableView的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{


    if (self.hotCommentData.count > 0)   return 2;
    
    if (self.commentData.count > 0)  return 1;
    
    return 0;
}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        if (self.hotCommentData.count > 0) {
            return self.hotCommentData.count;
        }else{
         return    self.commentData.count ;
        }
    } else {
        return self.commentData.count;
    }
    
    return   0;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        if (self.hotCommentData.count > 0) {
            return @"热门评论";
        }else{
            return   @"最新评论";
        }
    } else {
        return @"最新评论";
    }
    
    return nil;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SJBCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
  
    SJBConment * model  =  [self getmodelIndexPath:indexPath];;
    
    cell.comment = model;

    return cell;
}

- (SJBConment*)getmodelIndexPath:(NSIndexPath*)indexpath{
    
    if (indexpath.section == 0) {
        
        if (self.hotCommentData.count > 0) {
            return [self.hotCommentData objectAtIndex:indexpath.row];
        }else{
           return    [self.commentData objectAtIndex:indexpath.row ];
        }
    } else {
       
        return [self.commentData objectAtIndex:indexpath.row];
        
    }
    
    return nil;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.contentTextField resignFirstResponder];
}

@end
