//
//  SJBPublishTextController.m
//  小白
//
//  Created by zyyt on 16/7/15.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "SJBPublishTextController.h"
#import "SJBPublishBarButtonItem.h"
#import "SJBTextView.h"
#import "SJBAddTagViewController.h"

@interface SJBPublishTextController ()<UITextViewDelegate>

@property (nonatomic,strong)SJBTextView * textView;

@property (nonatomic,strong)UIButton * addButton;

@property (nonatomic,strong)UIView * toolView;

@property (nonatomic,strong)NSMutableArray * tagsButton;

@end

@implementation SJBPublishTextController

- (NSMutableArray *)tagsButton
{
    if (_tagsButton == nil) {
        _tagsButton = [NSMutableArray array];
    }
    return _tagsButton;
}

- (UIButton *)addButton
{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@"  +  " forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _addButton.backgroundColor = [UIColor whiteColor];
        [_addButton sizeToFit];
        [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
   //设置导航栏相关
    [self setupNav];
    
    //创建文本编辑控件
    [self setupTextView];
    
    //创建工具栏
    [self setUpToolView];
    
    
}

- (void)setUpToolView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, k_ScreenHeight - SJBPublishToolViewHeight, k_ScreenWidth, SJBPublishToolViewHeight )];
    view.backgroundColor = [UIColor lightGrayColor];
    self.addButton.frame = CGRectMake(5, 5, self.addButton.width, self.addButton.height);
    [view addSubview:self.addButton];
      self.toolView = view;
    [self.view addSubview:view];
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [SJBPublishBarButtonItem leftItemTitle:@"取消" font:14 color:[UIColor blackColor] highStateColor:[UIColor grayColor] target:self action:@selector(leftNavigationItemAction)];
    self.navigationItem.rightBarButtonItem = [SJBPublishBarButtonItem leftItemTitle:@"发送" font:14 color:[UIColor blackColor] highStateColor:[UIColor grayColor] target:self action:@selector(postTextWodAction)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.title = @"发表段子";
    
}

- (void)setupTextView
{
  
   self.textView = [[SJBTextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.textView.delegate = self;
    self.textView.placeholdTextFont = 14;
    self.textView.placehold = @"标签以逗号或换行符号隔开";
    
    [self.view addSubview:self.textView];
    
    //添加键盘的通知
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardShow:(NSNotification*)noti
{
    
   CGRect rect   =    [[noti.userInfo  objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.toolView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - SJBPublishToolViewHeight - rect.size.height, [UIScreen mainScreen].bounds.size.width, SJBPublishToolViewHeight) ;
    
}

- (void)keyboardHide:(NSNotification*)noti
{
    self.toolView.frame = CGRectMake(0, k_ScreenHeight - SJBPublishToolViewHeight, k_ScreenWidth, SJBPublishToolViewHeight) ;
    

}

//添加按钮的点击事件
- (void)addButtonClick:(UIButton*)btn
{
    SJBAddTagViewController * addvc = [[SJBAddTagViewController alloc] initWithNibName:NSStringFromClass([SJBAddTagViewController class]) bundle:nil];
    
    NSMutableArray * tagButtonTitles =[NSMutableArray array];
    for (int i=0; i<self.tagsButton.count; i++) {
        UIButton * btn = [self.tagsButton objectAtIndex:i];
        [tagButtonTitles addObject:btn.currentTitle];
    }
    
    addvc.titles =  tagButtonTitles;
    
    [addvc setTitleBlock:^(NSArray *titles) {
        
        __weak typeof(self) weakSelf = self;
        
        for (int i=0; i<titles.count; i++) {
            
            UIButton * button = [UIButton  buttonWithType:UIButtonTypeCustom];
            
            [button setTitle:titles[i] forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            
            [button sizeToFit];
            
            [weakSelf.tagsButton addObject:button];
            
            button.backgroundColor =  SJBRGBColor(89, 196, 247);
           
            [weakSelf.toolView addSubview:button];
            
           if (i==0) {
               
                button.frame = CGRectMake(5, 5, button.width, button.height);
               
            }else{
                
                UIButton *   lastBtn = self.tagsButton[i-1];
                
                CGFloat lastX = CGRectGetMaxX(lastBtn.frame) + 5;
                
                if (k_ScreenWidth - 20  -  lastX > button.width) {
                    
                    button.frame = CGRectMake(lastX, lastBtn.y, button.width, button.height);
                }else{
                    UIButton *   lastBtn = self.tagsButton[i-1];
                    
                    button.frame = CGRectMake(5, CGRectGetMaxY(lastBtn.frame) + 5, button.width, button.height);
                }
                
            }
            
            [button layoutIfNeeded];
            
        }
        
        UIButton * button = [self.tagsButton lastObject];
        
        if (weakSelf.toolView.width - button.width > self.addButton.width) {
            weakSelf.addButton.frame = CGRectMake(CGRectGetMaxX(button.frame) + 5, button.y, weakSelf.addButton.width, weakSelf.addButton.height);
        }else{
            weakSelf.addButton.frame = CGRectMake(0 , CGRectGetMaxY(button.frame) + 5, weakSelf.addButton.width, weakSelf.addButton.height);
        }

    }];
    
    [self.navigationController pushViewController:addvc animated:YES];
    
    SJBFunction;
}

//
- (void)leftNavigationItemAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//发送文本事件
- (void)postTextWodAction{
    
}



- (void)postTextWord
{
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length?YES:NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView resignFirstResponder];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
