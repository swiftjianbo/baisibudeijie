//
//  SJBTextView.h
//  小白
//
//  Created by zyyt on 16/7/15.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJBTextView : UITextView

//占位文字
@property (nonatomic,copy)NSString * placehold;

//占位文字的颜色
@property (nonatomic,strong)UIColor * placeholdTextColor;

//占位文字的大小
@property (nonatomic,assign)NSInteger placeholdTextFont;

@end
