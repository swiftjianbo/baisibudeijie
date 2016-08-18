//
//  UIImage+CircleImage.m
//  小白
//
//  Created by zyyt on 16/7/13.
//  Copyright © 2016年 sjb. All rights reserved.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

- (UIImage *)sjb_CircleImage
{
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    //获取图形上下文
    CGContextRef context =  UIGraphicsGetCurrentContext();
    
    //得到图片的范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

    //画圆
    CGContextAddEllipseInRect(context, rect);

    //剪裁边角
    CGContextClip(context);
    
    //画图
    [self drawInRect:rect];
    
    //获取图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
   
    //结束图形上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
