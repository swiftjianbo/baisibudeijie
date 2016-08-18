//
//  SJBMeViewController.m
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBMeViewController.h"
#import "SJBBarButtonItem.h"
#import "SJBMyModel.h"
#import "SJBItemCell.h"
#import "SJBMyWebViewController.h"

//#define cellID = @"cell";

static NSString * const cellID = @"cell";

@interface SJBMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)NSMutableArray * dataSouce;

@property (nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic,strong)UICollectionViewFlowLayout * collectionViewFlowLayout;

@end

@implementation SJBMeViewController

- (NSMutableArray *)dataSouce
{
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setupNav];
    
    [self setupCollectionview];
    
    [self requestData];
    
 
   
}

- (void)requestData
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:Main_URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * arr = responseObject[@"square_list"];
        
        for (NSDictionary * dic in arr) {
            SJBMyModel * modle = [[SJBMyModel alloc] init];
            [modle setValuesForKeysWithDictionary:dic];
            [self.dataSouce addObject:modle];
        }
    
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNav];
    
    [self setupContent];
    
}

- (void)setupContent
{
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        self.view.backgroundColor = SJBGlobalBgColor;

    }else{
    
    self.view.backgroundColor = SJBRGBColor(29, 29, 29);
        self.collectionView.backgroundColor =SJBRGBColor(29, 29, 29);
        
        
    }
}

- (void)setupNav
{
    self.view.backgroundColor = SJBRGBColor(223, 223, 223);
    
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        self.navigationItem.rightBarButtonItems = @[[SJBBarButtonItem creatBarButtonItemWithImage:@"mine-setting-icon" selectImage:@"mine-setting-icon-click" target:self action:@selector(friendsRecomment)],[SJBBarButtonItem creatBarButtonItemWithImage:@"mine-moon-icon" selectImage:@"mine-moon-icon-click" target:self action:@selector(mine)]];

    }else{
        self.navigationItem.rightBarButtonItems = @[[SJBBarButtonItem creatBarButtonItemWithImage:@"mine-setting-iconN" selectImage:@"mine-setting-icon-click" target:self action:@selector(friendsRecomment)],[SJBBarButtonItem creatBarButtonItemWithImage:@"mine-moon-icon" selectImage:@"mine-moon-icon-click" target:self action:@selector(mine)]];

    }
    
      self.navigationItem.title = @"我的";

}


- (void)setupCollectionview
{
    self.collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionViewFlowLayout.itemSize = CGSizeMake(k_ScreenWidth/3 - 20, 100);
    self.collectionViewFlowLayout.minimumInteritemSpacing = 10;
    self.collectionViewFlowLayout.minimumLineSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewFlowLayout];
    
   // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SJBItemCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - Collectionview的代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    SJBItemCell * cell = (SJBItemCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.myModel = [self.dataSouce objectAtIndex:indexPath.row];
    
    
    return cell;
}

////定义每个UICollectionView 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(96, 100);
//}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SJBMyWebViewController * webVC = [[SJBMyWebViewController alloc] initWithNibName:NSStringFromClass([SJBMyWebViewController class]) bundle:nil];
    
    webVC.urlStr = (NSString*)[[self.dataSouce objectAtIndex:indexPath.row] url];
   
    [self.navigationController pushViewController:webVC animated:YES];
    
}

- (void)friendsRecomment
{
    SJBLog(@"friendsRecomment");
}

- (void)mine
{
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        [NightModeShareInstance shareInstance].mode = NightModeNight;
    }else{
        [NightModeShareInstance shareInstance].mode = NightModeDay;
    }
    
    [self updateNightModeChangeColor];
}

- (void)updateNightModeChangeColor
{
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
         [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
       
        
    }else{
       
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundN-44"] forBarMetrics:UIBarMetricsDefault];
         [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundN-44"] forBarMetrics:UIBarMetricsDefault];
         [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    }
    
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateSelected];
    }else{
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    }
  
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        
        [self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
    }else{
        [self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-lightN"]];
    }
    
    [self preferredStatusBarStyle];
    
    
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateSelected];
        
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
    }else{
         [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
        self.collectionView.backgroundColor = SJBRGBColor(21, 21, 21);
    }
    

    [self setupNav];

    [self.collectionView reloadData];
    

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    if ([NightModeShareInstance shareInstance].mode == NightModeDay) {
        
        return  UIStatusBarStyleDefault;

    }else
        return UIStatusBarStyleLightContent;

    
   }


@end
