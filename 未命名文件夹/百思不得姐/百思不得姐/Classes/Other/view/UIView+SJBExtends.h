//
//  UIView+SJBExtends.h
//  小白
//
//  Created by zyyt on 16/6/24.
//  Copyright © 2016年 sjb. All rights reserved.
/*    
 myCompanyName        
 */

#import <UIKit/UIKit.h>

/*********
 
 直接获取控件的X Y W H Size CenterX  CenterY

 *********/

@interface UIView (SJBExtends)

/*
 *控件的x值
 */
@property (nonatomic,assign)CGFloat x;

/*
 *控件的y值
 */
@property (nonatomic,assign)CGFloat y;

/*
 *控件的宽度值
 */
@property (nonatomic,assign)CGFloat width;

/*
 *控件的高度值
 */
@property (nonatomic,assign)CGFloat height;

/*
 *控件的size
 */
@property (nonatomic,assign)CGSize size;

/*
 *中心点的x值
 */
@property (nonatomic,assign)CGFloat centerX;

/*
 *中心点的y值
 */
@property (nonatomic,assign)CGFloat centerY;

@end
