//
//  SJBPublishBarButtonItem.h
//  小白
//
//  Created by zyyt on 16/7/15.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJBPublishBarButtonItem : UIButton

+ (__kindof UIBarButtonItem*)leftItemTitle:(NSString*)title font:(NSInteger)font  color:(UIColor*)color  highStateColor:(UIColor*)highStateColor target:(id)target action:(SEL)selector;


+ (__kindof UIBarButtonItem*)rightItemTitle:(NSString*)title font:(NSInteger)font  color:(UIColor*)color  highStateColor:(UIColor*)highStateColor target:(id)target action:(SEL)selector;

@end
