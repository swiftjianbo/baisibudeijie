//
//  SJBAddTagViewController.m
//  小白
//
//  Created by zyyt on 16/7/18.
//  Copyright © 2016年 sjb. All rights reserved.

                           /*添加标签的视图控制器 */

#import "SJBAddTagViewController.h"
#import "SJBBarButtonItem.h"
#import "SJBPublishAddTagTextField.h"

@interface SJBAddTagViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic,strong)SJBPublishAddTagTextField * textField;

@property (nonatomic,strong)UIButton * addTagButton;

@property (nonatomic,strong)NSMutableArray * tagsButton;

@end

@implementation SJBAddTagViewController

/*
 *懒加载
 */
- (NSMutableArray *)tagsButton
{
    if (_tagsButton == nil) {
        _tagsButton = [NSMutableArray array];
    }
    return _tagsButton;
}

- (UIButton *)addTagButton
{
    if (_addTagButton == nil) {
        
        _addTagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addTagButton.backgroundColor = SJBRGBColor(89, 196, 247);
        [_addTagButton addTarget:self action:@selector(addTags
) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addTagButton];
    }
    return _addTagButton;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
  [self setupBaseSetting];
    
    [self addTextField];

    
}

/*
 *添加编辑文本
 */
- (void)addTextField
{
    SJBPublishAddTagTextField * textField = [[SJBPublishAddTagTextField alloc] initWithFrame:CGRectMake(5, 5, self.contentView.width - 10, SJBPublishAddTagMarginHeight)];
   //设置代理
    textField.delegate = self;
    //设置占位符
    textField.placeholder = @"标签以逗号和换行符隔开";
    //设置高度
    textField.height = 30;
    //为编辑框添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    __weak typeof(self)  weakSelf = self;
    
    [textField setPublishAddTagTextFieldBlock:^(NSInteger  integer) {
        
        if (integer == 0) {
            UIButton * btn =  [weakSelf.tagsButton lastObject];
            [weakSelf deleteTag:btn];
        }
           }];
    
    self.textField = textField;
  
    self.addTagButton.frame = CGRectMake(5, CGRectGetMaxY(self.textField.frame) + 5,k_ScreenWidth - 20 , 30);
    self.addTagButton.hidden = YES;
    [self.contentView addSubview:textField];
    
}

/*
 *基本设置
 */
- (void)setupBaseSetting
{
    self.navigationItem.title = @"添加标签";
    self.navigationItem.leftBarButtonItem =  [SJBBarButtonItem creatBarButtonItemWithTitleName:@"返回" target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem =  [SJBBarButtonItem creatBarButtonItemWithTitleName:@"完成" target:self action:@selector(done)];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

/*
 *导航栏按钮事件
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)done
{
    
    NSMutableArray * titles = [NSMutableArray array];
    for (int i=0; i<self.tagsButton.count; i++) {
        UIButton  * button = self.tagsButton[i];
        [titles addObject:button.currentTitle];
    }
    
    !self.titleBlock ? : self.titleBlock(titles);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
 *点击屏幕取消编辑事件
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}

//添加标签
- (void)addTags
{
    if (self.tagsButton.count == 5) {
        
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        
        return;
        
    }
    
    UIButton * tag = [UIButton buttonWithType:UIButtonTypeCustom];
    tag.backgroundColor = SJBRGBColor(89, 196, 247);
    [tag setTitle:self.textField.text forState:UIControlStateNormal];
    [tag addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
    [tag sizeToFit];
    
    [self.tagsButton addObject:tag];
    [self.contentView addSubview:tag];
    
    

    self.textField.text = nil;
    self.addTagButton.hidden = YES;
    
    [self  updateTagButtonFrame];
    
}

/*
 *标签按钮的点击事件(删除标签)
 */
- (void)deleteTag:(UIButton*)tagBtn
{
    
    [self.tagsButton removeObject:tagBtn];
    [UIView animateWithDuration:0.25 animations:^{
        [tagBtn removeFromSuperview];
          [self updateTagButtonFrame];
    }];
  
}

/*
 *更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    for (int i=0; i<self.tagsButton.count; i++) {
    
        UIButton * button = self.tagsButton[i];
        
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
    
    UIButton * lastButton = [self.tagsButton lastObject];
    
    if (((k_ScreenWidth - 20) -  CGRectGetMaxX(lastButton.frame)) > 100) {
        self.textField.frame = CGRectMake(CGRectGetMaxX(lastButton.frame) + 5, lastButton.y, self.textField.width, self.textField.height);
    }else{
        self.textField.frame = CGRectMake(0 , CGRectGetMaxY(lastButton.frame) + 5, self.textField.width, self.textField.height);
    }
    self.addTagButton.frame = CGRectMake(5, CGRectGetMaxY(self.textField.frame) + 5,k_ScreenWidth - 20 , 30);
    
    
}


#pragma  mark-  <UITextFieldDelegate>

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.addTagButton.hidden = NO;
    [self.addTagButton setTitle:[NSString stringWithFormat:@"标签内容:%@",textField.text] forState:UIControlStateNormal];
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addTags];
    
    return YES;
}



/*
 *监听编辑文本的文本变化
 */
- (void)textFieldTextChange:(NSNotification*)noti
{
    if (self.textField.hasText == NO) {
        self.addTagButton.hidden = YES;
        return;
    }
    
    self.addTagButton.hidden = NO;
    [self.addTagButton setTitle:[NSString stringWithFormat:@"标签内容:%@",self.textField.text] forState:UIControlStateNormal];
}

- (void)setTitles:(NSArray *)titles
{
    for (int i=0; i<self.titles.count; i++) {
        self.textField.text = [self.titles  objectAtIndex:i];
        [self addTagButton];
    }
}

//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
